//
//  NeomorphicTheme.swift
//  Neomorphic
//
//  Created by John Reid on 13/3/2025.
//

import SwiftUI

struct NeomorphicTheme {
    let baseColor: Color
    
    init(baseColor: Color) {
        self.baseColor = baseColor
    }
    
    static var `default`: NeomorphicTheme {
        NeomorphicTheme(baseColor: .init(white: 0.9))
    }
    
    static var dark: NeomorphicTheme {
        NeomorphicTheme(baseColor: .init(white: 0.15))
    }
}

private struct NeomorphicThemeKey: EnvironmentKey {
    static let defaultValue = NeomorphicTheme.default
}

extension EnvironmentValues {
    var neomorphicTheme: NeomorphicTheme {
        get { self[NeomorphicThemeKey.self] }
        set { self[NeomorphicThemeKey.self] = newValue }
    }
}

extension View {
    func neomorphicTheme(_ theme: NeomorphicTheme) -> some View {
        environment(\.neomorphicTheme, theme)
    }
    
    func neomorphicTheme(color: Color) -> some View {
        environment(\.neomorphicTheme, NeomorphicTheme(baseColor: color))
    }
}
