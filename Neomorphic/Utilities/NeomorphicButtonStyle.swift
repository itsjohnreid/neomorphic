import SwiftUI

enum NeomorphicShape {
    case rectangle
    case circle(size: CGFloat)
}

struct NeomorphicButtonStyle: ButtonStyle {
    let shape: NeomorphicShape
    
    init(shape: NeomorphicShape = .rectangle) {
        self.shape = shape
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(.primary)
            .frame(width: circleSize, height: circleSize)
            .neomorphic(cornerRadius: cornerRadius, isPressed: configuration.isPressed)
    }
    
    private var cornerRadius: CGFloat {
        switch shape {
        case .rectangle:
            return 16
        case .circle:
            return circleSize ?? 1
        }
    }
    
    private var circleSize: CGFloat? {
        switch shape {
        case .rectangle:
            return nil
        case .circle(let size):
            return size
        }
    }
}

extension ButtonStyle where Self == NeomorphicButtonStyle {
    static var neomorphic: NeomorphicButtonStyle {
        NeomorphicButtonStyle()
    }
    
    static func neomorphic(shape: NeomorphicShape) -> NeomorphicButtonStyle {
        NeomorphicButtonStyle(shape: shape)
    }
}

#Preview {
    VStack(spacing: 20) {
        // Regular rectangular button
        Button("Tap Me") {
            print("Button tapped!")
        }
        .buttonStyle(.neomorphic)
        
        // Custom rectangular button
        Button {
            print("Custom button tapped!")
        } label: {
            HStack {
                Image(systemName: "star.fill")
                Text("Custom Button")
            }
            .padding(.horizontal, 12)
        }
        .buttonStyle(.neomorphic)
        
        // Circular button
        Button {
            print("Circle button tapped!")
        } label: {
            Image(systemName: "heart.fill")
        }
        .buttonStyle(.neomorphic(shape: .circle(size: 60)))
        
        // Small circular button
        Button {
            print("Small circle button tapped!")
        } label: {
            Image(systemName: "plus")
        }
        .buttonStyle(.neomorphic(shape: .circle(size: 44)))
    }
    .padding(40)
    .background(Color(white: 0.9))
}
