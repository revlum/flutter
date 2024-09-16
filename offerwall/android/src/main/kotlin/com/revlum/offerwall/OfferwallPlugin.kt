package com.revlum.offerwall

import android.app.Activity
import android.content.Context
import com.google.gson.Gson
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** OfferwallPlugin */
class OfferwallPlugin : FlutterPlugin, MethodCallHandler, ActivityAware {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel
    private val gson = Gson()
    private lateinit var applicationContext: Context
    private var activity: Activity? = null

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "offerwall")
        channel.setMethodCallHandler(this)
        applicationContext = flutterPluginBinding.applicationContext
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        when (call.method) {
            "configure" -> {
                val apiKey = call.argument<String>("apiKey")
                val subId = call.argument<String>("subId")
                val userId = call.argument<String>("userId")

                if (apiKey != null) {
                    RevlumOfferwallSdk.configure(apiKey, applicationContext, subId, userId)
                    result.success(null)
                } else {
                    result.error("ERROR", "API key is required", null)
                }
            }

            "launch" -> {
                activity?.let {
                    RevlumOfferwallSdk.launch(it)
                    result.success(null)
                } ?: run {
                    result.error(
                        "ERROR",
                        "Activity context is null. Cannot launch Offerwall without an Activity.",
                        null
                    )
                }
            }

            "setUserId" -> {
                val userId = call.argument<String>("userId")
                if (userId != null) {
                    RevlumOfferwallSdk.setUserId(userId, {
                        result.success(null)
                    }, { error ->
                        result.error("ERROR", error.message, null)
                    })
                } else {
                    result.error("ERROR", "User ID is required", null)
                }
            }

            "setSubId" -> {
                val subId = call.argument<String>("subId")
                RevlumOfferwallSdk.setSubId(subId)
                result.success(null)
            }

            "checkReward" -> {
                RevlumOfferwallSdk.checkReward({ reward ->
                    val rewardJson = gson.toJson(reward)
                    result.success(rewardJson)
                }, { error ->
                    result.error("ERROR", error.message, null)
                })
            }

            else -> {
                result.notImplemented()
            }
        }
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = binding.activity
    }

    override fun onDetachedFromActivityForConfigChanges() {
        activity = null
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        activity = binding.activity
    }

    override fun onDetachedFromActivity() {
        activity = null
    }


    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
}
