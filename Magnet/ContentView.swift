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
                store.solves.append(Solve(solveTime: stopwatchCentiseconds, dnf: false, penalty: 0))
            }
        }

        return TabView {
            Stopwatch(active: activeBinding, centiseconds: $stopwatchCentiseconds)
                .tabItem {
                    Image(systemName: "timer")
                    Text("Timer")
                }

            NavigationView {
                List(store.solves) { solve in
                    Text("\(solve.solveTime) centiseconds")
                }
                .navigationBarTitle("Session")
            }
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
        let store = MagnetStore()

        return Group {
            ContentView(store: store)
            ContentView(store: store).environment(\.colorScheme, .dark)
        }
    }
}
