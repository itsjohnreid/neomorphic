import SwiftUI

extension Color {
    static let neomorphicWhite = Color(white: 0.92)
    static let neomorphicBlack = Color(white: 0.17)
    
    /// Convenience property for light shadow
    var lightShadow: Color {
        self.neomorphicShadow.light
    }
    
    /// Convenience property for dark shadow
    var darkShadow: Color {
        self.neomorphicShadow.dark
    }
}

extension Color {
    var neomorphicShadow: (light: Color, dark: Color) {
        let uiColor = UIColor(self)
        var hue: CGFloat = 0
        var saturation: CGFloat = 0
        var brightness: CGFloat = 0
        var alpha: CGFloat = 0
        
        if self == .neomorphicWhite {
            return (Color(white: 0.999), Color(white: 0.78))
        }
        
        if self == .neomorphicBlack {
            return (Color(white: 0.23), Color(white: 0.1))
        }
        
        if uiColor.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha) {
            let lightShadow = UIColor(
                hue: hue,
                saturation: saturation * 0.9,
                brightness: brightness * 1.15,
                alpha: 1
            )
            
            let darkShadow = UIColor(
                hue: hue,
                saturation: saturation * 1.1,
                brightness: brightness * 0.75,
                alpha: 1
            )
            
            return (Color(uiColor: lightShadow), Color(uiColor: darkShadow))
        } else {
            return (.white, .black) // Fallback in case getHue doesn't resolve, which shouldn't ever really happen.
        }
    }
}

#Preview {
    VStack(spacing: 20) {
        ForEach([
            Color.blue,
            Color.green,
            Color.purple,
            Color.orange,
            Color.neomorphicWhite,
            Color.neomorphicBlack
        ], id: \.self) { color in
            RoundedRectangle(cornerRadius: 12)
                .fill(color)
                .frame(width: 200, height: 60)
                .overlay(Text("Base"))
                .overlay {
                    HStack(spacing: 20) {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(color.lightShadow)
                            .frame(width: 60, height: 60)
                            .overlay(Text("Light"))
                        
                        Spacer()
                        
                        RoundedRectangle(cornerRadius: 12)
                            .fill(color.darkShadow)
                            .frame(width: 60, height: 60)
                            .overlay(Text("Dark"))
                    }
                }
        }
    }
    .padding(40)
    .background(Color(white: 0.85))
} 
