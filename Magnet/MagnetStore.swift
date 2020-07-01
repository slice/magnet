//
//  MagnetStore.swift
//  Magnet
//

import Combine

class MagnetStore: ObservableObject {
    @Published var solves: [Solve] = []
}
