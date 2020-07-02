//
//  SettingsView.swift
//  Magnet
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var settings: SettingsStore

    var body: some View {
        Form {
            Section(header: Text("Timer")) {
                Stepper(value: $settings.timerArmDelay, in: 0...1000, step: 25) {
                    Text("Arm Delay: \(settings.timerArmDelay)ms")
                }
                Toggle(isOn: $settings.timerMonospaceFont) {
                    Text("Monospace Font")
                }
                Toggle(isOn: $settings.timerHideTimeWhileActive) {
                    Text("Hide Time While Active")
                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        let store = SettingsStore()

        return SettingsView().environmentObject(store)
    }
}
