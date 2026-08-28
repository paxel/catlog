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
