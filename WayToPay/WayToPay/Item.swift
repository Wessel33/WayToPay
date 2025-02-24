//
//  Item.swift
//  WayToPay
//
//  Created by Wesley Frost on 24/02/2025.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
