# ML Kit text recognition: only the Latin model ships with the app; the
# plugin references the other script recognizers reflectively-optional.
# R8 must not fail on those absent optional models (#32).
-dontwarn com.google.mlkit.vision.text.chinese.**
-dontwarn com.google.mlkit.vision.text.devanagari.**
-dontwarn com.google.mlkit.vision.text.japanese.**
-dontwarn com.google.mlkit.vision.text.korean.**

# device_calendar hands calendars and events to Dart as Gson JSON built
# by reflection over its Kotlin models. Shrunk field names turn every
# calendar into {"a":…} — id and name null, "no calendar found" on a
# phone full of them. Keep the plugin untouched.
-keep class com.builttoroam.devicecalendar.** { *; }

# flutter_local_notifications serializes its scheduled notifications
# with Gson by reflection. Shrunk or renamed, the receiver cannot read
# them back, the permission request throws and the test notification
# does nothing; the debug build worked, the Play build did not (1.2.3).
# Rules as the plugin's README and Gson's own example prescribe.
-keep class com.dexterous.** { *; }
-keepattributes Signature, *Annotation*, EnclosingMethod, InnerClasses
-keep class com.google.gson.** { *; }
-keep class com.google.gson.reflect.TypeToken { *; }
-keep class * extends com.google.gson.reflect.TypeToken
-keep class * implements com.google.gson.TypeAdapter
-keep class * implements com.google.gson.TypeAdapterFactory
-keep class * implements com.google.gson.JsonSerializer
-keep class * implements com.google.gson.JsonDeserializer
-keepclassmembers,allowobfuscation class * {
  @com.google.gson.annotations.SerializedName <fields>;
}
-dontwarn sun.misc.**
