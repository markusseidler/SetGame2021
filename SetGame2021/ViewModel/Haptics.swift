//
//  Haptics.swift
//  SetGame2021
//
//  Created by Markus Seidler on 15/2/21.
//

import CoreHaptics

//https://www.hackingwithswift.com/books/ios-swiftui/making-vibrations-with-uinotificationfeedbackgenerator-and-core-haptics

struct Haptics {
    
    private var engine: CHHapticEngine?
    
    init() {
        prepareHaptics()
    }
    
    private mutating func prepareHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        
        do {
            self.engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("There was an error detecting the haptic engine: \(error.localizedDescription)")
        }
    }
    
    private func slicePattern() throws -> CHHapticPattern {
        let slice = CHHapticEvent(
          eventType: .hapticContinuous,
          parameters: [
            CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.35),
            CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.25)
          ],
          relativeTime: 0,
          duration: 0.25)

        let snip = CHHapticEvent(
          eventType: .hapticTransient,
          parameters: [
            CHHapticEventParameter(parameterID: .hapticIntensity, value: 1.0),
            CHHapticEventParameter(parameterID: .hapticSharpness, value: 1.0)
          ],
          relativeTime: 0.08)

        return try CHHapticPattern(events: [slice, snip], parameters: [])
      }
    
    func wrongSelection() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        
        
        do {
            let pattern = try slicePattern()
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print("Failed to play haptic pattern: \(error.localizedDescription)")
        }
    }
}


