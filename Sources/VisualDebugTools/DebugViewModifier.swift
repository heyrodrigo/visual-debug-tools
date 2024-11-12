//
//  DebugViewModifier.swift
//
//  Created by Rigo Rigo AB on 2023-09-27.
//  Copyright © 2023 Rigo Rigo AB. All rights reserved.
//


import Foundation
import SwiftUI

public struct DebugViewModifier: ViewModifier {
    
    var color:Color
    var showSize:Bool
    var showBorder:Bool
    
    public func body(content: Content) -> some View {
        content
            .overlay( GeometryReader{ geometry in
                color.opacity(0.5)
                    .overlay(
                        Text("\(String(format: "%.0f", geometry.size.width))x\(String(format: "%.0f", geometry.size.height))")
                            .padding(4)
                            .foregroundColor(.white)
                            .background(color)
                            .opacity(showSize ? 1 : 0)
                        
                    )
                    .overlay(
                        CrosshairBorderShape()
                            .strokeBorder(showBorder ? color : .clear, lineWidth: 3)
                    )
                    .allowsHitTesting(false)
            })
    }
}

public extension View {
    /// Adds a debug overlay to view that colors the and shows size of view.
    /// - Parameters:
    ///   - color: Color of debug overlay
    ///   - showSize: If it should show the size information
    ///   - showBorder: If it should show a border around the view
    /// - Returns: some View
    func debug(color:Color = .green, showSize:Bool = true, showBorder:Bool = true) -> some View {
        self.modifier(DebugViewModifier(color: color, showSize:showSize, showBorder:showBorder))
    }
}


private struct CrosshairBorderShape:InsettableShape{
    
    var insetAmount:Double = 0.0
    
    func path(in rect: CGRect) -> Path {
        
        // Makes lines start at 25 or 75 percent of max widht/height
        let minPercentage:Double = 0.25
        let maxPercentage:Double = 0.75
        
        // Draws path
        let path = Path{ path in
            // Top left corner
            path.move(to: CGPoint(x: insetAmount, y: rect.size.height * minPercentage))
            path.addLine(to: CGPoint(x: insetAmount, y: insetAmount))
            path.addLine(to: CGPoint(x: rect.size.width * minPercentage, y: insetAmount))
            
            // Top right corner
            path.move(to: CGPoint(x: rect.size.width * maxPercentage, y: insetAmount))
            path.addLine(to: CGPoint(x: rect.size.width - insetAmount, y: insetAmount))
            path.addLine(to: CGPoint(x: rect.size.width - insetAmount, y: rect.size.height * minPercentage))
            
            // Bottom right corner
            path.move(to: CGPoint(x: rect.size.width - insetAmount, y: rect.size.height * maxPercentage))
            path.addLine(to: CGPoint(x: rect.size.width - insetAmount, y: rect.size.height - insetAmount))
            path.addLine(to: CGPoint(x: rect.size.width * maxPercentage, y: rect.size.height - insetAmount))
            
            // Bottom left corner
            path.move(to: CGPoint(x: rect.size.width * minPercentage, y: rect.size.height - insetAmount))
            path.addLine(to: CGPoint(x: insetAmount, y: rect.size.height - insetAmount))
            path.addLine(to: CGPoint(x: insetAmount, y: rect.size.height * maxPercentage))
        }
        return path
    }
    
    func inset(by amount: CGFloat) -> some InsettableShape {
        var shape = self
        shape.insetAmount += amount
        return shape
    }
}
