import Flutter
import UIKit
import RevlumOfferwallSDK
import SwiftUI

public class OfferwallPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "offerwall", binaryMessenger: registrar.messenger())
        let instance = OfferwallPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "configure":
            guard let args = call.arguments as? [String: Any],
                  let apiKey = args["apiKey"] as? String else {
                result(FlutterError(code: "INVALID_ARGUMENTS", message: "API Key is required", details: nil))
                return
            }
            let subId = args["subId"] as? String
            let userId = args["userId"] as? String
            RevlumOfferwallSdk.shared.configure(apiKey: apiKey, subId: subId, userId: userId)
            result(nil)
            
        case "launch":
            if let navigationController = UIApplication.shared.delegate?.window??.rootViewController as? UINavigationController {
                let offerwallView = RevlumOfferwallSdk.shared.offerwallView
                
                if #available(iOS 13.0, *) {
                    let hostingController = UIHostingController(rootView: offerwallView)
                    navigationController.setNavigationBarHidden(false, animated: false)
                    navigationController.pushViewController(hostingController, animated: true)
                } else {
                    result(FlutterError(code: "UNSUPPORTED_IOS_VERSION",
                                        message: "iOS version below 13.0 is not supported for launching Offerwall",
                                        details: nil))
                }
                result(nil)
            } else {
                result(FlutterError(code: "NO_NAVIGATION_CONTROLLER",
                                    message: "Navigation controller not found",
                                    details: nil))
            }

        case "setUserId":
            guard let args = call.arguments as? [String: Any],
                  let userId = args["userId"] as? String else {
                result(FlutterError(code: "INVALID_ARGUMENTS", message: "User ID is required", details: nil))
                return
            }
            RevlumOfferwallSdk.shared.setUserId(userId)
            result(nil)

        case "setSubId":
            guard let args = call.arguments as? [String: Any],
                  let subId = args["subId"] as? String else {
                result(FlutterError(code: "INVALID_ARGUMENTS", message: "Sub ID is required", details: nil))
                return
            }
            RevlumOfferwallSdk.shared.setSubId(subId: subId)
            result(nil)

        case "checkReward":
            RevlumOfferwallSdk.shared.checkReward(
                onCheckReward: { checkReward in
                    let rewardData: [String: Any] = [
                        "reward": checkReward.reward,
                        "offers": checkReward.offers.map { offer in
                            return [
                                "status": offer.status,
                                "id": offer.id,
                                "name": offer.name,
                                "revenue": offer.revenue,
                                "reward": offer.reward,
                                "transactionId": offer.transactionId,
                                "time": offer.time
                            ]
                        }
                    ]
                    do {
                        let jsonData = try JSONSerialization.data(withJSONObject: rewardData, options: [])
                        let jsonString = String(data: jsonData, encoding: .utf8)
                        result(jsonString)
                    } catch {
                        result(FlutterError(code: "JSON_SERIALIZATION_ERROR", message: error.localizedDescription, details: nil))
                    }
                },
                onError: { error in
                    let errorMessage = "\(String(describing: error))"
                    result(FlutterError(code: "CHECK_REWARD_ERROR", message: errorMessage, details: nil))
                }
            )
            
        default:
            result(FlutterMethodNotImplemented)
        }
    }
}
