//
//  Formatting.swift
//  Magnet
//

func formatCentiseconds(_ centiseconds: Int) -> String {
    let second = 100
    let minute = 60 * second

    func pad(_ n: Int) -> String {
        return n < 10 ? "0\(n)" : String(n)
    }

    if centiseconds > minute {
        let minutes = centiseconds / minute
        let seconds = (centiseconds % minute) / second
        let remainder = (centiseconds % minute % second)
        return "\(minutes):\(pad(seconds)).\(pad(remainder))"
    } else {
        let seconds = centiseconds / second
        let remainder = centiseconds % second
        return "\(seconds).\(pad(remainder))"
    }
}
