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
        TabView {
            TimerView(active: $timerActive, centiseconds: $timerCentiseconds)
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
        .onChange(of: timerActive) { nowActive in
            // XXX: We should capture the previous value here to check if the
            // timer was actually stopped, but for some reason it always ends up
            // being the same as the new value. (`!nowActive && wasActive`.)
            //
            // Let's just check for a time of 0:00.00 instead.
            guard !nowActive && timerCentiseconds != 0 else { return }

            let solve = Solve(time: timerCentiseconds)
            store.solves.append(solve)
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
