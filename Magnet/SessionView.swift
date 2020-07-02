//
//  SessionView.swift
//  Magnet
//

import SwiftUI

struct SessionView: View {
    @ObservedObject var store: MagnetStore

    var body: some View {
        Group {
            if (store.solves.isEmpty) {
                Text("No Solves Yet")
                    .font(.title)
                    .foregroundColor(.secondary)
            } else {
                List {
                    ForEach(store.solves) { solve in
                        Text(solve.description)
                            .foregroundColor(solve.dnf ? .secondary : .primary)
                    }
                    .onDelete { indexSet in
                        store.solves.remove(atOffsets: indexSet)
                    }
                }
                .navigationBarItems(trailing: EditButton())
                // BUG: For some reason, the edit button persists after deleting
                // all solves. Maybe this is a bug in SwiftUI?
            }
        }
        .navigationBarTitle("Session")
    }
}

struct SessionView_Previews: PreviewProvider {
    static var previews: some View {
        let store = MagnetStore()
        let second = 100

        store.solves += [
            Solve(time: 61 * second),
            Solve(time: 5 * second, dnf: true),
            Solve(time: 34 * second, penalty: 2),
        ]

        return Group {
            NavigationView {
                SessionView(store: store)
            }

            NavigationView {
                SessionView(store: MagnetStore())
            }
        }
    }
}
