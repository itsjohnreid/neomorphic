//
//  NeomorphicModifier.swift
//  Neomorphic
//
//  Created by John Reid on 13/3/2025.
//

import SwiftUI

struct NeomorphicModifier: ViewModifier {
    @Environment(\.colorScheme) private var colorScheme // light or dark
    @Environment(\.neomorphicTheme) private var inheritedTheme
    
    let baseColor: Color?
    var cornerRadius: CGFloat = 20
    var shadowRadius: CGFloat = 6
    var shadowOffset: CGFloat = 7
    var isPressed: Bool = false
    
    private var effectiveColor: Color {
        if let color = baseColor {
            return color
        } else if let inheritedColor = inheritedTheme.baseColor {
            return inheritedColor
        }
        return defaultColor
    }
    
    private var defaultColor: Color {
        return colorScheme == .dark ? .neomorphicBlack : .neomorphicWhite
    }
    
    private var shadowColor: Color {
        inheritedTheme.baseColor ?? defaultColor
    }
    
    func body(content: Content) -> some View {
        content
            .padding(4)
            .background(
                Group {
                    if isPressed {
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .fill(effectiveColor)
                            .overlay(
                                RoundedRectangle(cornerRadius: cornerRadius)
                                    .fill(effectiveColor.darkShadow.opacity(0.1))
                            )
                            .shadow(color: shadowColor.darkShadow.opacity(0.8), radius: shadowRadius, x: -shadowOffset, y: -shadowOffset)
                            .shadow(color: shadowColor.lightShadow.opacity(0.8), radius: shadowRadius, x: shadowOffset, y: shadowOffset)
                    } else {
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .fill(effectiveColor)
                            .shadow(color: shadowColor.darkShadow.opacity(0.8), radius: shadowRadius, x: shadowOffset, y: shadowOffset)
                            .shadow(color: shadowColor.lightShadow.opacity(0.8), radius: shadowRadius, x: -shadowOffset, y: -shadowOffset)
                    }
                }
            )
    }
}

extension View {
    func neomorphic(
        color: Color? = nil,
        cornerRadius: CGFloat = 20,
        isPressed: Bool = false
    ) -> some View {
        self.modifier(NeomorphicModifier(
            baseColor: color,
            cornerRadius: cornerRadius,
            isPressed: isPressed
        ))
    }
}
