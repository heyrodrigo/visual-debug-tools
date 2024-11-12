//
//  DebugViewUpdateViewModifier.swift
//
//  Created by Rigo Rigo AB on 2024-11-12.
//  Copyright © 2024 Rigo Rigo AB. All rights reserved.
//

import Foundation
import SwiftUI

public struct DebugViewUpdateViewModifier: ViewModifier {
    
    var color: Color
    
    public func body(content: Content) -> some View {
        content
            .overlay(
                Rectangle()
                    .fill(color)
                    .allowsHitTesting(false)
            )
    }
}

public extension View {
    /// Adds a debug overlay that changes color when view is re-evaluted.
    /// - Parameter opacity: Opacity of the overlay
    /// - Returns: some View
    func debugViewUpdate(opacity: Double = 0.8) -> some View {
        self.modifier(DebugViewUpdateViewModifier(color: Color.random.opacity(opacity)))
    }
}
