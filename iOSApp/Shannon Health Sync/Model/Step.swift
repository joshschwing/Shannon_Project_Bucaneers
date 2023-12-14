//
//  Step.swift
//  Step Count
//
//  Created by Adian Acosta on 12/10/23.
//

import Foundation

struct Step: Identifiable {
    let id = UUID()
    let count: Int
    let date: Date
}
