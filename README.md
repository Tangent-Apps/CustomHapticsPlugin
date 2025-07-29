# Tangent Custom Haptics

A Flutter plugin for advanced haptic feedback patterns on iOS using CoreHaptics framework.

## Features

- 18 predefined haptic patterns for different use cases
- Automatic fallback to system haptics on unsupported devices
- Lifecycle-aware haptic engine management
- iOS 13.0+ support with CoreHaptics framework

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  tangent_custom_haptics: ^1.0.1
```

Then run:

```bash
flutter pub get
```

## Platform Support

| Platform | Supported |
|----------|-----------|
| iOS      | ✅ (13.0+) |
| Android  | ❌        |
| macOS    | ❌        |
| Web      | ❌        |
| Windows  | ❌        |
| Linux    | ❌        |

## Usage

Import the package:

```dart
import 'package:tangent_custom_haptics/tangent_custom_haptics.dart';
```

### Basic Usage

```dart
// Initialize the plugin (happens automatically on first use)
final haptics = CustomHapticsPlugin.instance;

// Play a success haptic
await CustomHapticsPlugin.playSuccess();

// Play a combo haptic
await CustomHapticsPlugin.playCombo();

// Play an error haptic
await CustomHapticsPlugin.playErrorFail();
```

### Available Haptic Patterns

#### Success & Reward Patterns
- `playSuccess()` - Quick success feedback
- `playSuccessReward()` - Success followed by reward
- `playHeavyReward()` - Intense reward feedback

#### Game & Interaction Patterns
- `playCombo()` - Building combo feedback
- `playRampUpCombo()` - Escalating combo with finale
- `playMatchCombo()` - Progressive match feedback
- `playVictoryFan()` - Victory celebration
- `playBigWin()` - Major achievement
- `playChestOpen()` - Treasure chest opening
- `playCoinCollect()` - Coin collection sequence

#### UI Interaction Patterns
- `playSinglePop()` - Light tap feedback
- `playDragStart()` - Drag gesture start
- `playDragMove()` - Drag gesture movement
- `playSwipeTrail()` - Swipe gesture trail

#### Utility Patterns
- `playCountdownPulse()` - Countdown timer pulses
- `playPowerUpSurge()` - Power-up activation
- `playErrorFail()` - Error/failure feedback
- `playFailureRumble()` - Extended failure feedback

### Example Usage in a Game

```dart
class GameWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () async {
            // User collected a coin
            await CustomHapticsPlugin.playCoinCollect();
          },
          child: Text('Collect Coin'),
        ),
        ElevatedButton(
          onPressed: () async {
            // User completed a combo
            await CustomHapticsPlugin.playCombo();
          },
          child: Text('Combo Hit'),
        ),
        ElevatedButton(
          onPressed: () async {
            // User won the level
            await CustomHapticsPlugin.playVictoryFan();
          },
          child: Text('Victory!'),
        ),
      ],
    );
  }
}
```

### Error Handling

The plugin automatically handles errors and falls back to system haptics when:
- Device doesn't support CoreHaptics
- Haptic engine fails to initialize
- Individual haptic patterns fail to play

```dart
try {
  await CustomHapticsPlugin.playSuccess();
} catch (e) {
  // Error is automatically handled with fallback
  print('Haptic feedback not available: $e');
}
```

### Lifecycle Management

The plugin automatically manages the haptic engine lifecycle:
- Initializes when first used
- Restarts when app returns to foreground
- Handles system interruptions gracefully

To manually dispose (usually not needed):

```dart
CustomHapticsPlugin.dispose();
```

## Requirements

- iOS 13.0 or later
- Device with haptic engine (iPhone 7 and later)
- Flutter 3.24.0 or later

## License

MIT License - see the [LICENSE](LICENSE) file for details.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.