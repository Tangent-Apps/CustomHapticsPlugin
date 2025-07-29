import Flutter
import UIKit
import CoreHaptics

@available(iOS 13.0, *)
public class SwiftCustomHapticsPlugin: NSObject, FlutterPlugin {
    private let customHaptics = CustomHaptics()

    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "custom_haptics", binaryMessenger: registrar.messenger())
        let instance = SwiftCustomHapticsPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else {
            result(FlutterError(code: "UNSUPPORTED", message: "Device does not support CoreHaptics", details: nil))
            return
        }

        switch call.method {
        case "prepareHapticEngine":
            customHaptics.restartHapticEngine()
        case "playSuccessHaptic":
            customHaptics.playSuccessHaptic()
        case "playComboHaptic":
            customHaptics.playComboHaptic()
        case "playHeavyRewardHaptic":
            customHaptics.playHeavyRewardHaptic()
        case "playDragStartHaptic":
            customHaptics.playDragStartHaptic()
        case "playDragMoveHaptic":
            customHaptics.playDragMoveHaptic()
        case "playRampUpComboHaptic":
            customHaptics.playRampUpComboHaptic()
        case "playSuccessRewardHaptic":
            customHaptics.playSuccessRewardHaptic()
        case "playSinglePopHaptic":
            customHaptics.playSinglePopHaptic()
        case "playMatchComboHaptic":
            customHaptics.playMatchComboHaptic()
        case "playChestOpenHaptic":
            customHaptics.playChestOpenHaptic()
        case "playBigWinHaptic":
            customHaptics.playBigWinHaptic()
        case "playCoinCollectHaptic":
            customHaptics.playCoinCollectHaptic()
        case "playErrorFailHaptic":
            customHaptics.playErrorFailHaptic()
        case "playVictoryFanHaptic":
            customHaptics.playVictoryFanHaptic()
        case "playFailureRumbleHaptic":
            customHaptics.playFailureRumbleHaptic()
        case "playSwipeTrailHaptic":
            customHaptics.playSwipeTrailHaptic()
        case "playCountdownPulseHaptic":
            customHaptics.playCountdownPulseHaptic()
        case "playPowerUpSurgeHaptic":
            customHaptics.playPowerUpSurgeHaptic()
        default:
            result(FlutterMethodNotImplemented)
            return
        }

        result(nil)
    }
}
