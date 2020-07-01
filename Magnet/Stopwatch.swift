//
//  Timer.swift
//  Magnet
//

import SwiftUI

enum StopwatchGestureState: String {
    case inactive
    case waiting
    case ready
}

func eraseGesture<G: Gesture>(_ gesture: G) -> AnyGesture<()> {
    return AnyGesture(gesture.map { _ in () })
}

let stopwatchFontSize: CGFloat = 60.0

struct Stopwatch: View {
    @EnvironmentObject var settings: SettingsStore
    @GestureState var gestureState = StopwatchGestureState.inactive
    @Binding var active: Bool
    @Binding var centiseconds: Int
    private let timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()

    private var stopGesture: some Gesture {
        DragGesture(minimumDistance: 0)
            .onChanged { _ in
                self.active = false
            }
    }

    private var startGesture: some Gesture {
        let armed = TapGesture().onEnded { _ in
            guard self.gestureState == .ready else { return }
            self.centiseconds = 0
            self.active = true
        }

        return LongPressGesture(minimumDuration: 0.75)
            .sequenced(before: armed)
            .updating($gestureState) { value, state, transaction in
                switch value {
                case .first(_):
                    state = .waiting
                case .second(_, nil):
                    state = .ready
                default:
                    state = .inactive
                }
            }
    }

    private var gestureColor: Color {
        switch gestureState {
        case .waiting: return .red
        case .ready: return .green
        default: return .clear
        }
    }

    private var formattedTime: String {
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

    var timerFont: Font {
        // Scale the font size according to Dynamic Type.
        let size = UIFontMetrics.default.scaledValue(for: stopwatchFontSize)

        return settings.timerMonospaceFont
            ? Font.system(size: size, weight: .bold, design: .monospaced)
            : Font.system(size: size, weight: .bold).monospacedDigit()
    }

    var body: some View {
        Text(formattedTime)
            .font(timerFont)
            .padding()
            .background(gestureColor)
            .foregroundColor(gestureColor == .clear ? .primary : .white)
            .cornerRadius(5.0)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .contentShape(Rectangle())
            .gesture(active ? eraseGesture(stopGesture) : eraseGesture(startGesture))
            .onReceive(timer) { input in
                guard self.active else { return }
                self.centiseconds += 1
            }
    }
}

struct Stopwatch_Previews: PreviewProvider {
    static var previews: some View {
        ForEach([5, 65, 60 * 2], id: \.self) { seconds in
            Stopwatch(
                active: Binding.constant(false),
                centiseconds: Binding.constant(seconds * 100)
            )
        }
    }
}
