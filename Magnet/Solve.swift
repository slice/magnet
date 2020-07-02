//
//  Solve.swift
//  Magnet
//

import Foundation

struct Solve: Identifiable {
    var id = UUID()

    /// The solve duration in centiseconds.
    var time: Int

    /// Indicates if the solve was a DNF (Did Not Finish).
    var dnf: Bool = false

    /// The penalty incurred in centiseconds. Usually either 0 or 2.
    var penalty: Int = 0
}

extension Solve: CustomStringConvertible {
    var description: String {
        if dnf {
            return "DNF"
        }

        let formatted = formatCentiseconds(time)
        return penalty == 0 ? formatted : "\(formatted) (+\(penalty))"
    }
}
