//
//  SettingsStore.swift
//  Magnet
//

import Combine
import SwiftUI

/// A property wrapper similiar to `@AppStorage`. We don't use `@AppStorage` because
/// it doesn't rerender views properly when used inside of an `ObservableObject`.
@propertyWrapper
struct UserDefault<Value> {
    let key: String
    let defaultValue: Value

    init(wrappedValue defaultValue: Value, _ key: String) {
        self.key = key
        self.defaultValue = defaultValue
    }

    var wrappedValue: Value {
        get {
            UserDefaults.standard.object(forKey: key) as? Value ?? defaultValue
        }

        set {
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
}

class SettingsStore: ObservableObject {
    let objectWillChange = PassthroughSubject<Void, Never>()

    /// Hides the time while the timer is active.
    @UserDefault("timerHideTimeWhileActive") var timerHideTimeWhileActive = false {
        willSet {
            objectWillChange.send()
        }
    }

    /// The amount of time the user must keep holding down before they can release to
    /// start the timer in milliseconds.
    @UserDefault("timerArmDelay") var timerArmDelay = 500 {
        willSet {
            objectWillChange.send()
        }
    }

    /// Uses a monospace font for the timer.
    @UserDefault("timerMonospaceFont") var timerMonospaceFont = false {
        willSet {
            objectWillChange.send()
        }
    }
}
