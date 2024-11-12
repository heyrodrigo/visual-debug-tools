//
//  Color.swift
//
//  Created by Rigo Rigo AB on 2024-11-12.
//  Copyright © 2024 Rigo Rigo AB. All rights reserved.
//

import SwiftUI

extension ShapeStyle where Self == Color {
    public static var random: Color {
        Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1)
        )
    }
}
