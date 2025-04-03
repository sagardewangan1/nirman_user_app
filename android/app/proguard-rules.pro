# Flutter-specific rules
-keep class io.flutter.** { *; }
-keep class io.flutter.embedding.** { *; }
-keep class io.flutter.plugins.** { *; }

# Keep all class members that are used by Flutter
-keep class com.example.** { *; }

# Keep Gson models
-keep class com.google.gson.** { *; }
-keepattributes *Annotation*

# OkHttp & Retrofit
-dontwarn okhttp3.**
-keep class okhttp3.** { *; }
-keep class retrofit2.** { *; }

# Room Database (if using)
-keep class androidx.room.** { *; }

# Prevent code stripping for certain annotations (Jetpack libraries)
-keepattributes *Annotation*

# R8 optimizations
-dontwarn android.support.v4.**
-dontwarn java.nio.file.*

# Keep model classes (prevent obfuscation of data models)
-keep class com.example.nirman_user_app.model.** { *; }
-keep class nirman_user_app.model.** { *; }
-keep class **.SellerForMobile { *; }
-keep class **.ServicebyCategoryModel { *; }
-keep class **.SubcategoryModel { *; }

# More comprehensive Gson rules
-keepattributes Signature
-keepattributes *Annotation*
-keep class sun.misc.Unsafe { *; }
-keep class com.google.gson.stream.** { *; }
-keep class com.google.gson.examples.android.model.** { *; }
-keep class * implements com.google.gson.TypeAdapterFactory
-keep class * implements com.google.gson.JsonSerializer
-keep class * implements com.google.gson.JsonDeserializer
-keepclassmembers,allowobfuscation class * {
  @com.google.gson.annotations.SerializedName <fields>;
}

-keepattributes Signature
-keepattributes *Annotation*

# If using Kotlin data classes for models
-keepclassmembers class **.**{
    public synthetic <methods>;
}

# If using reflection (which JSON parsing libraries often use)
-keepattributes EnclosingMethod
-keepattributes InnerClasses

# If using JSON serialization libraries
-keep class org.json.** { *; }
-keep class com.fasterxml.jackson.** { *; }

# If using Moshi
-keep class com.squareup.moshi.** { *; }

# Rules from missing_rules.txt to fix current errors
-dontwarn com.stripe.android.pushProvisioning.PushProvisioningActivity$g
-dontwarn com.stripe.android.pushProvisioning.PushProvisioningActivityStarter$Args
-dontwarn com.stripe.android.pushProvisioning.PushProvisioningActivityStarter$Error
-dontwarn com.stripe.android.pushProvisioning.PushProvisioningActivityStarter
-dontwarn com.stripe.android.pushProvisioning.PushProvisioningEphemeralKeyProvider
-dontwarn proguard.annotation.Keep
-dontwarn proguard.annotation.KeepClassMembers

# Additional Stripe SDK rules
-keep class com.stripe.android.** { *; }
-keep class com.stripe.android.pushProvisioning.** { *; }

# React Native Stripe SDK
-keep class com.reactnativestripesdk.** { *; }
-keep class com.reactnativestripesdk.pushprovisioning.** { *; }

# Razorpay rules
-keep class com.razorpay.** { *; }
-keepclassmembers class com.razorpay.** { *; }

# Keep any classes referenced from native code
-keepclasseswithmembers class * {
    native <methods>;
}