# Changelog

## 1.0.3

* Added registerWith method for legacy plugin registration compatibility
* Fixed build error with dart_plugin_registrant.dart

## 1.0.2

* Updated the README.md file

## 1.0.1

* Fixed iOS plugin structure and podspec configuration
* Removed unnecessary platform directories 
* Fixed plugin installation issues

## 1.0.0

* Initial release of Custom Haptics Plugin
* Support for advanced haptic feedback patterns on iOS devices with CoreHaptics
* 18 different haptic patterns including:
  - Success and reward haptics
  - Combo and victory patterns  
  - Drag and interaction feedback
  - Error and failure patterns
  - Gaming-specific haptics (coin collect, chest open, big win)
* Automatic fallback to system haptics on unsupported devices
* Lifecycle-aware haptic engine management
* iOS 13.0+ support with CoreHaptics framework