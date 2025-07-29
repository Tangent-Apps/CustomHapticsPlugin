import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CustomHapticsPlugin with WidgetsBindingObserver {
  /// Registers this plugin with the Flutter engine.
  /// Required for legacy plugin registration.
  static void registerWith(dynamic registrar) {
    // This method is called by Flutter for legacy plugin registration
    // The actual registration is handled by the iOS plugin code
  }
  static const MethodChannel _channel = MethodChannel('custom_haptics');
  static CustomHapticsPlugin? _instance;
  static bool _isInitialized = false;
  
  static CustomHapticsPlugin get instance {
    if (_instance == null) {
      _instance = CustomHapticsPlugin._internal();
      _initialize();
    }
    return _instance!;
  }
  
  CustomHapticsPlugin._internal();
  
  static void _initialize() {
    if (!_isInitialized && _instance != null) {
      WidgetsBinding.instance.addObserver(_instance!);
      _isInitialized = true;
      // Prepare haptic engine on initialization
      _prepareHapticEngine();
    }
  }
  
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // Re-prepare haptic engine when app comes to foreground
      _prepareHapticEngine();
    }
  }
  
  static Future<void> _prepareHapticEngine() async {
    try {
      // Call a prepare method on the native side to ensure haptic engine is ready
      await _channel.invokeMethod('prepareHapticEngine');
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Failed to prepare haptic engine: $e');
      }
    }
  }

  static Future<void> _safeInvoke(String method) async {
    // Ensure instance exists (which will trigger initialization if needed)
    instance;
    
    try {
      await _channel.invokeMethod(method);
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Custom haptic feedback not available, using fallback: $e');
      }
      // Fallback to system haptics if custom haptics fail
      HapticFeedback.lightImpact();
    }
  }

  static Future<void> playSuccess() => _safeInvoke('playSuccessHaptic');
  static Future<void> playCombo() => _safeInvoke('playComboHaptic');
  static Future<void> playRampUpCombo() => _safeInvoke('playRampUpComboHaptic');
  static Future<void> playVictoryFan() => _safeInvoke('playVictoryFanHaptic');
  static Future<void> playHeavyReward() => _safeInvoke('playHeavyRewardHaptic');
  static Future<void> playSuccessReward() => _safeInvoke('playSuccessRewardHaptic');
  static Future<void> playSinglePop() => _safeInvoke('playSinglePopHaptic');
  static Future<void> playChestOpen() => _safeInvoke('playChestOpenHaptic');
  static Future<void> playBigWin() => _safeInvoke('playBigWinHaptic');
  static Future<void> playCoinCollect() => _safeInvoke('playCoinCollectHaptic');
  static Future<void> playErrorFail() => _safeInvoke('playErrorFailHaptic');
  static Future<void> playMatchCombo() => _safeInvoke('playMatchComboHaptic');
  static Future<void> playDragStart() => _safeInvoke('playDragStartHaptic');
  static Future<void> playDragMove() => _safeInvoke('playDragMoveHaptic');
  static Future<void> playFailureRumble() => _safeInvoke('playFailureRumbleHaptic');
  static Future<void> playSwipeTrail() => _safeInvoke('playSwipeTrailHaptic');
  static Future<void> playCountdownPulse() => _safeInvoke('playCountdownPulseHaptic');
  static Future<void> playPowerUpSurge() => _safeInvoke('playPowerUpSurgeHaptic');
  
  static void dispose() {
    if (_isInitialized && _instance != null) {
      WidgetsBinding.instance.removeObserver(_instance!);
      _isInitialized = false;
    }
  }
}
