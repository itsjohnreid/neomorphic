import SwiftUI

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
                saturation: max(saturation * 0.7, 0.0),
                brightness: min(brightness * 1.2, 1.0),
                alpha: 1
            )
            
            let darkShadow = UIColor(
                hue: hue,
                saturation: max(saturation * 0.9, 0.0),
                brightness: max(brightness * 0.8, 0.0),
                alpha: 1
            )
            
            return (Color(uiColor: lightShadow), Color(uiColor: darkShadow))
        } else {
            var white: CGFloat = 0
            uiColor.getWhite(&white, alpha: &alpha)
            
            let lightShadow = UIColor(
                white: min(white * 1.3, 1.0),
                alpha: alpha * 0.8
            )
            
            let darkShadow = UIColor(
                white: max(white * 0.7, 0.0),
                alpha: alpha * 0.35
            )
            
            return (Color(uiColor: lightShadow), Color(uiColor: darkShadow))
        }
    }
    
    /// Convenience property for light shadow
    var lightShadow: Color {
        self.neomorphic.light
    }
    
    /// Convenience property for dark shadow
    var darkShadow: Color {
        self.neomorphic.dark
    }
}

#Preview {
    VStack(spacing: 20) {
        ForEach([
            Color.blue,
            Color.green,
            Color.purple,
            Color.orange,
            Color(white: 0.9), // light theme
            Color(white: 0.15) // dark theme
        ], id: \.self) { color in
            HStack(spacing: 20) {
                // Light shadow
                RoundedRectangle(cornerRadius: 12)
                    .fill(color.lightShadow)
                    .frame(width: 60, height: 60)
                    .overlay(Text("Light"))
                
                // Base color
                RoundedRectangle(cornerRadius: 12)
                    .fill(color)
                    .frame(width: 60, height: 60)
                    .overlay(Text("Base"))
                
                // Dark shadow
                RoundedRectangle(cornerRadius: 12)
                    .fill(color.darkShadow)
                    .frame(width: 60, height: 60)
                    .overlay(Text("Dark"))
            }
        }
    }
    .padding(40)
    .background(Color(white: 0.85))
} 
