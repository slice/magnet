//
//  Solve.swift
//  Magnet
//

import Foundation

struct Solve: Identifiable {
    var id = UUID()

    /// The solve duration in centiseconds.
    var solveTime: Int

    /// Whether the solve was completed or not.
    var dnf: Bool

    /// The penalty incurred in centiseconds.
    var penalty: Int
}
