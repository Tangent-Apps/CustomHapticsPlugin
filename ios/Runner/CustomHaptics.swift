//
//  CustomHaptics.swift
//  Runner
//
//  Created by Mena Gamal on 09/06/2025.
//
import Foundation
import CoreHaptics

@available(iOS 13.0, *)
@objc class CustomHaptics: NSObject {
    private var engine: CHHapticEngine?

    override init() {
        super.init()
        prepareHaptics()
    }

    private func prepareHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        do {
            self.engine = try CHHapticEngine()
            try self.engine?.start()
            
            // Set up engine restart handler for when the app returns to foreground
            self.engine?.resetHandler = { [weak self] in
                do {
                    try self?.engine?.start()
                } catch {
                    print("Failed to restart haptic engine: \(error)")
                }
            }
            
            // Set up handler for when engine stops due to external factors
            self.engine?.stoppedHandler = { reason in
                print("Haptic engine stopped: \(reason)")
                // Don't automatically restart here to avoid recursion
            }
        } catch {
            print("Failed to start haptic engine: \(error)")
        }
    }
    
    @objc func restartHapticEngine() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        do {
            try self.engine?.start()
        } catch {
            print("Failed to restart haptic engine: \(error)")
            // If restart fails, try to recreate the engine
            prepareHaptics()
        }
    }

    @objc func playSuccessHaptic() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        let events = [
            CHHapticEvent(eventType: .hapticTransient,
                          parameters: [
                            CHHapticEventParameter(parameterID: .hapticIntensity, value: 1.0),
                            CHHapticEventParameter(parameterID: .hapticSharpness, value: 1.0)
                          ],
                          relativeTime: 0)
        ]
        playPattern(events: events)
    }

    @objc func playComboHaptic() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        let events = [
            CHHapticEvent(eventType: .hapticTransient,
                          parameters: [
                            CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.3),
                            CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.5)
                          ],
                          relativeTime: 0),
            CHHapticEvent(eventType: .hapticTransient,
                          parameters: [
                            CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.6),
                            CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.7)
                          ],
                          relativeTime: 0.1),
            CHHapticEvent(eventType: .hapticTransient,
                          parameters: [
                            CHHapticEventParameter(parameterID: .hapticIntensity, value: 1.0),
                            CHHapticEventParameter(parameterID: .hapticSharpness, value: 1.0)
                          ],
                          relativeTime: 0.2),
        ]
        playPattern(events: events)
    }

    @objc func playHeavyRewardHaptic() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        let events = [
            CHHapticEvent(eventType: .hapticContinuous,
                          parameters: [
                            CHHapticEventParameter(parameterID: .hapticIntensity, value: 1.0),
                            CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.7)
                          ],
                          relativeTime: 0,
                          duration: 0.5)
        ]
        playPattern(events: events)
    }

    private func playPattern(events: [CHHapticEvent]) {
        // Ensure engine is started before playing
        if engine?.currentTime == nil {
            restartHapticEngine()
        }
        
        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print("Failed to play custom haptic: \(error)")
            // Try to restart engine and play again
            restartHapticEngine()
        }
    }



    @objc func playDragStartHaptic() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        let events = [
            CHHapticEvent(eventType: .hapticTransient,
                          parameters: [
                            CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.5),
                            CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.8)
                          ],
                          relativeTime: 0)
        ]
        playPattern(events: events)
    }

    @objc func playDragMoveHaptic() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        // 4 light taps over 0.6s
        let events = [
            CHHapticEvent(eventType: .hapticTransient, parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.2),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.7)
            ], relativeTime: 0.0),
            CHHapticEvent(eventType: .hapticTransient, parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.2),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.7)
            ], relativeTime: 0.2),
            CHHapticEvent(eventType: .hapticTransient, parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.2),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.7)
            ], relativeTime: 0.4),
            CHHapticEvent(eventType: .hapticTransient, parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.2),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.7)
            ], relativeTime: 0.6),
        ]
        playPattern(events: events)
    }

    @objc func playRampUpComboHaptic() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        let events = [
            CHHapticEvent(eventType: .hapticTransient, parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.3),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.5)
            ], relativeTime: 0.0),
            CHHapticEvent(eventType: .hapticTransient, parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.6),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.7)
            ], relativeTime: 0.1),
            CHHapticEvent(eventType: .hapticTransient, parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 1.0),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 1.0)
            ], relativeTime: 0.2),
            CHHapticEvent(eventType: .hapticContinuous, parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 1.0),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.7)
            ], relativeTime: 0.3, duration: 0.3)
        ]
        playPattern(events: events)
    }

    @objc func playSuccessRewardHaptic() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        let events = [
            // Quick success tap
            CHHapticEvent(eventType: .hapticTransient, parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 1.0),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 1.0)
            ], relativeTime: 0.0),
            // Pause, then big reward
            CHHapticEvent(eventType: .hapticContinuous, parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 1.0),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.7)
            ], relativeTime: 0.2, duration: 0.5)
        ]
        playPattern(events: events)
    }

    @objc func playSinglePopHaptic() {
        let events = [
            CHHapticEvent(eventType: .hapticTransient,
                          parameters: [
                            CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.4),
                            CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.8)
                          ],
                          relativeTime: 0)
        ]
        playPattern(events: events)
    }

    @objc func playMatchComboHaptic() {
        let events = [
            CHHapticEvent(eventType: .hapticTransient,
                parameters: [CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.2)], relativeTime: 0.0),
            CHHapticEvent(eventType: .hapticTransient,
                parameters: [CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.4)], relativeTime: 0.10),
            CHHapticEvent(eventType: .hapticTransient,
                parameters: [CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.7)], relativeTime: 0.20),
            CHHapticEvent(eventType: .hapticTransient,
                parameters: [CHHapticEventParameter(parameterID: .hapticIntensity, value: 1.0)], relativeTime: 0.30),
        ]
        playPattern(events: events)
    }


    @objc func playChestOpenHaptic() {
        let events = [
            // Three quick ramps
            CHHapticEvent(eventType: .hapticTransient,
                parameters: [CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.3)], relativeTime: 0.00),
            CHHapticEvent(eventType: .hapticTransient,
                parameters: [CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.5)], relativeTime: 0.10),
            CHHapticEvent(eventType: .hapticTransient,
                parameters: [CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.8)], relativeTime: 0.20),
            // Big payoff
            CHHapticEvent(eventType: .hapticContinuous,
                parameters: [CHHapticEventParameter(parameterID: .hapticIntensity, value: 1.0)], relativeTime: 0.30, duration: 0.4),
        ]
        playPattern(events: events)
    }


    @objc func playBigWinHaptic() {
        let events = [
            CHHapticEvent(eventType: .hapticContinuous,
                parameters: [CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.8)], relativeTime: 0.00, duration: 0.12),
            CHHapticEvent(eventType: .hapticContinuous,
                parameters: [CHHapticEventParameter(parameterID: .hapticIntensity, value: 1.0)], relativeTime: 0.15, duration: 0.18),
            CHHapticEvent(eventType: .hapticContinuous,
                parameters: [CHHapticEventParameter(parameterID: .hapticIntensity, value: 1.0)], relativeTime: 0.40, duration: 0.20),
        ]
        playPattern(events: events)
    }


    @objc func playCoinCollectHaptic() {
        var events: [CHHapticEvent] = []
        for i in 0..<5 {
            events.append(CHHapticEvent(eventType: .hapticTransient,
                parameters: [CHHapticEventParameter(parameterID: .hapticIntensity, value: 2.15)],
                relativeTime: Double(i) * 1.06))
        }
        playPattern(events: events)
    }


    @objc func playErrorFailHaptic() {
        let events = [
            CHHapticEvent(eventType: .hapticTransient,
                parameters: [
                    CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.7),
                    CHHapticEventParameter(parameterID: .hapticSharpness, value: 1.0)
                ],
                relativeTime: 0.0),
            CHHapticEvent(eventType: .hapticTransient,
                parameters: [
                    CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.7),
                    CHHapticEventParameter(parameterID: .hapticSharpness, value: 1.0)
                ],
                relativeTime: 0.11)
        ]
        playPattern(events: events)
    }


    @objc func playVictoryFanHaptic() {
        var events: [CHHapticEvent] = []
        for i in 0..<6 {
            events.append(CHHapticEvent(
                eventType: .hapticTransient,
                parameters: [
                    CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(i) * 0.2),
                    CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(i) * 0.15)
                ],
                relativeTime: Double(i) * 0.08))
        }
        playPattern(events: events)
    }


    @objc func playFailureRumbleHaptic() {
        let events = [
            CHHapticEvent(eventType: .hapticContinuous,
                parameters: [
                    CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.6),
                    CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.4)
                ],
                relativeTime: 0.0, duration: 0.7)
        ]
        playPattern(events: events)
    }

    @objc func playSwipeTrailHaptic() {
        let events: [CHHapticEvent] = [
            CHHapticEvent(eventType: .hapticContinuous,
                          parameters: [
                              CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.3),
                              CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.9)
                          ],
                          relativeTime: 0.0, duration: 0.5)
        ]
        playPattern(events: events)
    }

    @objc func playCountdownPulseHaptic() {
        let interval = 0.25
        let pulses = (0..<4).map {
            CHHapticEvent(eventType: .hapticTransient,
                          parameters: [CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.5)],
                          relativeTime: Double($0) * interval)
        }
        playPattern(events: pulses)
    }

    @objc func playPowerUpSurgeHaptic() {
        let events: [CHHapticEvent] = [
            CHHapticEvent(eventType: .hapticTransient,
                parameters: [CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.4)], relativeTime: 0.00),
            CHHapticEvent(eventType: .hapticTransient,
                parameters: [CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.6)], relativeTime: 0.08),
            CHHapticEvent(eventType: .hapticTransient,
                parameters: [CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.8)], relativeTime: 0.16),
            CHHapticEvent(eventType: .hapticContinuous,
                parameters: [CHHapticEventParameter(parameterID: .hapticIntensity, value: 1.0)], relativeTime: 0.25, duration: 0.4)
        ]
        playPattern(events: events)
    }

}
