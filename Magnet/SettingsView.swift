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
                    Text("Safety: \(settings.timerArmDelay)ms")
                }
                Toggle(isOn: $settings.timerMonospaceFont) {
                    Text("Monospaced Font")
                }
                Toggle(isOn: $settings.timerHideTimeWhileActive) {
                    Text("Hide Time While Running")
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
