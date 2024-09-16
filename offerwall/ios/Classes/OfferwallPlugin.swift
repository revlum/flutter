import Flutter
import UIKit

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

            case "setSubId":
                guard let args = call.arguments as? [String: Any],
                      let subId = args["subId"] as? String else {
                    result(FlutterError(code: "INVALID_ARGUMENTS", message: "Sub ID is required", details: nil))
                    return
                }
                RevlumOfferwallSdk.shared.setSubId(subId)
                result(nil)

            case "setUserId":
                guard let args = call.arguments as? [String: Any],
                      let userId = args["userId"] as? String else {
                    result(FlutterError(code: "INVALID_ARGUMENTS", message: "User ID is required", details: nil))
                    return
                }
                RevlumOfferwallSdk.shared.setUserId(userId)
                result(nil)

            case "launch":
                if let navigationController = UIApplication.shared.delegate?.window??.rootViewController as? UINavigationController {
                    let offerwallView = RevlumOfferwallSdk.getOfferwallView()
                    let hostingController = UIHostingController(rootView: offerwallView)
                    navigationController.setNavigationBarHidden(false, animated: false)
                    navigationController.pushViewController(hostingController, animated: true)
                    result(nil)
                } else {
                    result(FlutterError(code: "NO_NAVIGATION_CONTROLLER", message: "Navigation controller not found", details: nil))
                }

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
                        result(rewardData)
                    },
                    onError: { error in
                        result(FlutterError(code: "CHECK_REWARD_ERROR", message: error.message, details: nil))
                    }
                )

            default:
                result(FlutterMethodNotImplemented)
        }
  }
}
