package io.github.paxel.catlog

import android.content.Context
import android.net.ConnectivityManager
import android.net.Network
import android.net.NetworkCapabilities
import android.net.NetworkRequest
import android.net.wifi.WifiManager
import android.net.wifi.WifiNetworkSpecifier
import android.os.Build
import android.os.Handler
import android.os.Looper
import io.flutter.plugin.common.MethodChannel
import java.net.NetworkInterface

/// Android-to-Android sync without any Wi-Fi (ADR-0002 extension):
/// the host runs a LocalOnlyHotspot (no internet, system-generated
/// credentials), the joiner joins it app-scoped via WifiNetworkSpecifier
/// and binds the process to that network so the sync HTTP flows through
/// it. Both sides tear down right after the session.
class HotspotChannel(private val context: Context) {
    private var reservation: WifiManager.LocalOnlyHotspotReservation? = null
    private var joinCallback: ConnectivityManager.NetworkCallback? = null

    fun handle(call: io.flutter.plugin.common.MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "startHotspot" -> startHotspot(result)
            "stopHotspot" -> {
                reservation?.close()
                reservation = null
                result.success(null)
            }
            "joinHotspot" -> joinHotspot(
                call.argument<String>("ssid")!!,
                call.argument<String>("pass")!!,
                result
            )
            "leaveHotspot" -> {
                val cm = context.getSystemService(Context.CONNECTIVITY_SERVICE)
                        as ConnectivityManager
                joinCallback?.let { cm.unregisterNetworkCallback(it) }
                joinCallback = null
                cm.bindProcessToNetwork(null)
                result.success(null)
            }
            else -> result.notImplemented()
        }
    }

    private fun startHotspot(result: MethodChannel.Result) {
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.O) {
            result.error("hotspot", "Requires Android 8+", null)
            return
        }
        val wifi = context.applicationContext
            .getSystemService(Context.WIFI_SERVICE) as WifiManager
        try {
            wifi.startLocalOnlyHotspot(object :
                WifiManager.LocalOnlyHotspotCallback() {
                override fun onStarted(
                    res: WifiManager.LocalOnlyHotspotReservation) {
                    reservation = res
                    val (ssid, pass) = credentials(res)
                    // The AP interface appears with a fresh IPv4 —
                    // that's the address the joiner must dial.
                    Handler(Looper.getMainLooper()).postDelayed({
                        result.success(mapOf(
                            "ssid" to ssid,
                            "pass" to pass,
                            "ip" to hotspotAddress()
                        ))
                    }, 500)
                }

                override fun onFailed(reason: Int) {
                    result.error("hotspot", "Failed: $reason", null)
                }
            }, Handler(Looper.getMainLooper()))
        } catch (e: Exception) {
            result.error("hotspot", e.message, null)
        }
    }

    @Suppress("DEPRECATION")
    private fun credentials(
        res: WifiManager.LocalOnlyHotspotReservation): Pair<String, String> {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) {
            val config = res.softApConfiguration
            return Pair(
                config.wifiSsid?.toString()?.trim('"')
                    ?: config.ssid ?: "",
                config.passphrase ?: "")
        }
        val config = res.wifiConfiguration!!
        return Pair(config.SSID ?: "", config.preSharedKey ?: "")
    }

    private fun hotspotAddress(): String {
        for (iface in NetworkInterface.getNetworkInterfaces()) {
            if (!iface.isUp || iface.isLoopback) continue
            val name = iface.name.lowercase()
            if (!name.contains("ap") && !name.contains("swlan") &&
                !name.contains("wlan1")) continue
            for (addr in iface.inetAddresses) {
                val ip = addr.hostAddress ?: continue
                if (!ip.contains(':')) return ip
            }
        }
        // Common LocalOnlyHotspot gateway as last resort.
        return "192.168.49.1"
    }

    private fun joinHotspot(ssid: String, pass: String,
                            result: MethodChannel.Result) {
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.Q) {
            result.error("hotspot", "Joining requires Android 10+", null)
            return
        }
        val cm = context.getSystemService(Context.CONNECTIVITY_SERVICE)
                as ConnectivityManager
        val specifier = WifiNetworkSpecifier.Builder()
            .setSsid(ssid)
            .setWpa2Passphrase(pass)
            .build()
        val request = NetworkRequest.Builder()
            .addTransportType(NetworkCapabilities.TRANSPORT_WIFI)
            .removeCapability(NetworkCapabilities.NET_CAPABILITY_INTERNET)
            .setNetworkSpecifier(specifier)
            .build()
        var answered = false
        val callback = object : ConnectivityManager.NetworkCallback() {
            override fun onAvailable(network: Network) {
                cm.bindProcessToNetwork(network)
                if (!answered) {
                    answered = true
                    Handler(Looper.getMainLooper()).post {
                        result.success(true)
                    }
                }
            }

            override fun onUnavailable() {
                if (!answered) {
                    answered = true
                    Handler(Looper.getMainLooper()).post {
                        result.success(false)
                    }
                }
            }
        }
        joinCallback = callback
        cm.requestNetwork(request, callback, 30000)
    }
}
