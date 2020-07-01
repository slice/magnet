//
//  App.swift
//  Magnet
//

import SwiftUI

@main
struct MagnetApp: App {
    @StateObject var settings = SettingsStore()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(settings)
        }
    }
}
