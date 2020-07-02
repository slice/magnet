//
//  SettingsView.swift
//  Magnet
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var settings: SettingsStore

    var timerArmDelayBinding: Binding<Double> {
        Binding {
            Double(settings.timerArmDelay)
        } set: { newValue in
            settings.timerArmDelay = Int(newValue)
        }
    }

    var timerArmDelayDescription: String {
        "\(Double(settings.timerArmDelay) / 1000)s"
    }

    var body: some View {
        Form {
            Section(
                header: Text("Timer Safety"),
                footer: Text("Adjust the amount of time you have to hold your tap before the timer can start.")
            ) {
                Slider(
                    value: timerArmDelayBinding,
                    in: 25...1000,
                    step: 25,
                    minimumValueLabel: Image(systemName: "hare"),
                    maximumValueLabel: Image(systemName: "tortoise")
                ) {
                    Text(timerArmDelayDescription)
                }
                Text(timerArmDelayDescription).foregroundColor(.secondary)
            }
            Section(
                header: Text("Timer Display"),
                footer: Text("Monospaced digits will always be used, even when a monospaced font is not in use.")
            ) {
                Toggle(isOn: $settings.timerHideTimeWhileActive) {
                    Text("Hide Time While Running")
                }
                Toggle(isOn: $settings.timerMonospaceFont) {
                    Text("Monospaced Font")
                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        return SettingsView().environmentObject(SettingsStore())
    }
}
