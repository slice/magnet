//
//  SessionView.swift
//  Magnet
//

import SwiftUI

struct SessionView: View {
    @ObservedObject var store: MagnetStore

    var body: some View {
        List {
            ForEach(store.solves) { solve in
                Text(solve.description)
                    .foregroundColor(solve.dnf ? .secondary : .primary)
            }
            .onDelete { indexSet in
                store.solves.remove(atOffsets: indexSet)
            }

            if (store.solves.isEmpty) {
                Text("No solves yet...").foregroundColor(.secondary)
            }
        }
        .navigationBarTitle("Session")
        .navigationBarItems(trailing: EditButton())
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

        return NavigationView {
            SessionView(store: store)
        }
    }
}
