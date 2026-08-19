# ML Kit text recognition: only the Latin model ships with the app; the
# plugin references the other script recognizers reflectively-optional.
# R8 must not fail on those absent optional models (#32).
-dontwarn com.google.mlkit.vision.text.chinese.**
-dontwarn com.google.mlkit.vision.text.devanagari.**
-dontwarn com.google.mlkit.vision.text.japanese.**
-dontwarn com.google.mlkit.vision.text.korean.**
