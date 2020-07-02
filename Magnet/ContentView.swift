//
//  ContentView.swift
//  Magnet
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var store: MagnetStore

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
                SettingsView()
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
        let settings = SettingsStore()

        return Group {
            ContentView(store: store).environmentObject(settings)
            ContentView(store: store).environmentObject(settings).environment(\.colorScheme, .dark)
        }
    }
}
