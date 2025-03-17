import SwiftUI

extension Color {
    static let neomorphicWhite = Color(white: 0.9)
    static let neomorphicBlack = Color(white: 0.15)
    
    /// Convenience property for light shadow
    var lightShadow: Color {
        self.neomorphic.light
    }
    
    /// Convenience property for dark shadow
    var darkShadow: Color {
        self.neomorphic.dark
    }
}

extension Color {
    var neomorphic: (light: Color, dark: Color) {
        let uiColor = UIColor(self)
        var hue: CGFloat = 0
        var saturation: CGFloat = 0
        var brightness: CGFloat = 0
        var alpha: CGFloat = 0
        
        if uiColor.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha) {
            let lightShadow = UIColor(
                hue: hue,
                saturation: max(saturation * 0.8, 0.0),
                brightness: min(brightness * 1.2, 1.0),
                alpha: 1
            )
            
            let darkShadow = UIColor(
                hue: hue,
                saturation: min(saturation * 1.1, 1.0),
                brightness: max(brightness * 0.8, 0.0),
                alpha: 1
            )
            
            return (Color(uiColor: lightShadow), Color(uiColor: darkShadow))
        } else {
            return (.white, .black) // I don't think this actually happens?
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
