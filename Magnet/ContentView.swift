//
//  ContentView.swift
//  Magnet
//

import SwiftUI

struct ContentView: View {
    @State private var stopwatchActive = false
    @State private var stopwatchCentiseconds = 0

    @State private var timerArmDelay = 75
    @State private var useMonospaceFont = false

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
                        Stepper(value: $timerArmDelay, in: 0...1000, step: 25) {
                            Text("Arm Delay: \(timerArmDelay)ms")
                        }
                        Toggle(isOn: $useMonospaceFont) {
                            Text("Monospace Font")
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
        ContentView()
    }
}
