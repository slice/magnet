//
//  ContentView.swift
//  Magnet
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var store: MagnetStore

    @State private var timerActive = false
    @State private var timerCentiseconds = 0

    var body: some View {
        let activeBinding = Binding {
            timerActive
        } set: { newValue in
            timerActive = newValue
            if (!newValue) {
                store.solves.append(Solve(time: timerCentiseconds, dnf: false, penalty: 0))
            }
        }

        return TabView {
            TimerView(active: activeBinding, centiseconds: $timerCentiseconds)
                .tabItem {
                    Label("Timer", systemImage: "timer")
                }

            NavigationView {
                SessionView(store: store)
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
