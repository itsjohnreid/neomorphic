//
//  NeomorphicModifier.swift
//  Neomorphic
//
//  Created by John Reid on 13/3/2025.
//

import SwiftUI

struct NeomorphicModifier: ViewModifier {
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.neomorphicTheme) private var inheritedTheme
    
    let baseColor: Color?
    var cornerRadius: CGFloat = 16
    var shadowRadius: CGFloat = 10
    var shadowOffset: CGFloat = 8
    var isPressed: Bool = false
    
    private var effectiveColor: Color {
        if let color = baseColor {
            return color
        }
        if inheritedTheme.baseColor != NeomorphicTheme.default.baseColor {
            return inheritedTheme.baseColor
        }
        return colorScheme == .light ? 
            Color(white: 0.9) : 
            Color(white: 0.15)
    }
    
    func body(content: Content) -> some View {
        content
            .padding(12)
            .background(
                Group {
                    if isPressed {
                        // Pressed state - concave effect
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .fill(effectiveColor)
                            .overlay(
                                RoundedRectangle(cornerRadius: cornerRadius)
                                    .fill(effectiveColor.darkShadow.opacity(0.2))
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: cornerRadius)
                                    .strokeBorder(effectiveColor.lightShadow.opacity(0.3), lineWidth: 1)
                                    .blur(radius: 2)
                            )
                            .shadow(color: effectiveColor.darkShadow, radius: shadowRadius, x: -shadowOffset, y: -shadowOffset)
                            .shadow(color: effectiveColor.lightShadow, radius: shadowRadius, x: shadowOffset, y: shadowOffset)
                    } else {
                        // Normal state - convex effect
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .fill(effectiveColor)
                            .overlay(
                                RoundedRectangle(cornerRadius: cornerRadius)
                                    .strokeBorder(effectiveColor.lightShadow.opacity(0.3), lineWidth: 1)
                                    .blur(radius: 2)
                            )
                            .shadow(color: effectiveColor.darkShadow, radius: shadowRadius, x: shadowOffset, y: shadowOffset)
                            .shadow(color: effectiveColor.lightShadow, radius: shadowRadius, x: -shadowOffset, y: -shadowOffset)
                    }
                }
            )
            .animation(.spring(response: 0.3, dampingFraction: 0.4, blendDuration: 0.2), value: isPressed)
    }
}

extension View {
    func neomorphic(
        color: Color? = nil,
        cornerRadius: CGFloat = 16,
        isPressed: Bool = false
    ) -> some View {
        self.modifier(NeomorphicModifier(
            baseColor: color,
            cornerRadius: cornerRadius,
            isPressed: isPressed
        ))
    }
}
