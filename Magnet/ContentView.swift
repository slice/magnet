//
//  ContentView.swift
//  Magnet
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var store: MagnetStore
    @EnvironmentObject var settings: SettingsStore

    @State private var stopwatchActive = false
    @State private var stopwatchCentiseconds = 0

    var body: some View {
        let activeBinding = Binding {
            stopwatchActive
        } set: { newValue in
            stopwatchActive = newValue
            if (!newValue) {
                store.solves.append(Solve(time: stopwatchCentiseconds, dnf: false, penalty: 0))
            }
        }

        return TabView {
            Stopwatch(active: activeBinding, centiseconds: $stopwatchCentiseconds)
                .tabItem {
                    Label("Timer", systemImage: "timer")
                }

            NavigationView {
                List(store.solves) { solve in
                    Text("\(formatCentiseconds(solve.time))")
                }
                .navigationBarTitle("Session")
            }
            .tabItem {
                Label("Session", systemImage: "list.number")
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
                Label("Settings", systemImage: "gear")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let store = MagnetStore()

        return Group {
            ContentView(store: store)
            ContentView(store: store).environment(\.colorScheme, .dark)
        }
    }
}
