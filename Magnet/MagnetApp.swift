//
//  App.swift
//  Magnet
//

import SwiftUI

@main
struct MagnetApp: App {
    @StateObject var store = MagnetStore()
    @StateObject var settings = SettingsStore()

    var body: some Scene {
        WindowGroup {
            ContentView(store: store)
                .environmentObject(settings)
        }
    }
}
