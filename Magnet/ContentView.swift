//
//  ContentView.swift
//  Magnet
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var settings: SettingsStore

    @State private var stopwatchActive = false
    @State private var stopwatchCentiseconds = 0

    var body: some View {
        TabView {
            Stopwatch(active: $stopwatchActive, centiseconds: $stopwatchCentiseconds)
                .tabItem {
                    Image(systemName: "timer")
                    Text("Timer")
                }

            Text("Session")
                .tabItem {
                    Image(systemName: "list.number")
                    Text("Session")
                }

            NavigationView {
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
                .navigationBarTitle(Text("Settings"))
            }
            .tabItem {
                Image(systemName: "gear")
                Text("Settings")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
            ContentView().environment(\.colorScheme, .dark)
        }
    }
}
