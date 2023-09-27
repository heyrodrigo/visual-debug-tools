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
    var borderColor:Color
    var showSize:Bool
    var showBorder:Bool
    
    public func body(content: Content) -> some View {
        content
            .overlay( GeometryReader{ geometry in
                color.opacity(0.5)
                    .overlay(
                        Text("\(String(format: "%.0f", geometry.size.width))x\(String(format: "%.0f", geometry.size.height))")
                            .padding(4)
                            .background(color)
                            .opacity(showSize ? 1 : 0)
                            .foregroundColor(borderColor)
                        
                    )
                    .overlay(
                        
                        // Corner markers
                        Path{ path in
                            // Top left corner
                            path.move(to: CGPoint(x: 0, y: geometry.size.height * 0.45))
                            path.addLine(to: CGPoint(x: 0, y: 0))
                            path.addLine(to: CGPoint(x: geometry.size.width * 0.45, y: 0))
                            
                            // Top right corner
                            path.move(to: CGPoint(x: geometry.size.width * 0.55, y: 0))
                            path.addLine(to: CGPoint(x: geometry.size.width, y: 0))
                            path.addLine(to: CGPoint(x: geometry.size.width, y: geometry.size.height * 0.45))
                            
                            // Bottom right corner
                            path.move(to: CGPoint(x: geometry.size.width, y: geometry.size.height * 0.55))
                            path.addLine(to: CGPoint(x: geometry.size.width, y: geometry.size.height))
                            path.addLine(to: CGPoint(x: geometry.size.width * 0.55, y: geometry.size.height))
                            
                            // Bottom left corner
                            path.move(to: CGPoint(x: geometry.size.width * 0.45, y: geometry.size.height))
                            path.addLine(to: CGPoint(x: 0, y: geometry.size.height))
                            path.addLine(to: CGPoint(x: 0, y: geometry.size.height * 0.55))
                        }
                            .stroke(showBorder ? borderColor : .clear, lineWidth: 3)
                        
                    )
                    .allowsHitTesting(false)
            })
    }
}

public extension View {
    func debug(color:Color = .green, borderColor:Color = .white, showSize:Bool = true, showBorder:Bool = false) -> some View {
        self.modifier(DebugViewModifier(color: color, borderColor: borderColor, showSize:showSize, showBorder:showBorder))
    }
}
