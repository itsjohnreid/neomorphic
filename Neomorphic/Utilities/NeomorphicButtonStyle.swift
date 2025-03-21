import SwiftUI

enum NeomorphicShape {
    case rectangle
    case circle(size: CGFloat?)
}

struct NeomorphicButtonStyle: ButtonStyle {
    let color: Color?
    let shape: NeomorphicShape
    @State private var isAnimating = false
    
    init(color: Color? = nil, shape: NeomorphicShape = .rectangle) {
        self.color = color
        self.shape = shape
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(.primary)
            .padding(.vertical, 12)
            .padding(.horizontal, horizontalPadding)
            .frame(width: circleSize, height: circleSize)
//            .neomorphic(color: color, cornerRadius: .infinity, isPressed: configuration.isPressed)
            .neomorphic(color: color, cornerRadius: .infinity, isPressed: isAnimating)
            .onChange(of: configuration.isPressed) { _, isPressed in
                if isPressed {
                    withAnimation(.easeOut(duration: 0.1)) {
                        isAnimating = true
                    }
                } else {
                    withAnimation(.default.delay(0.15)) {
                        isAnimating = false
                    }
                }
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
    
    private var horizontalPadding: CGFloat {
        switch shape {
        case .circle:
            return 12
        case .rectangle:
            return 16
        }
    }
}

extension ButtonStyle where Self == NeomorphicButtonStyle {
    static var neomorphic: NeomorphicButtonStyle {
        NeomorphicButtonStyle()
    }
    
    static func neomorphic(color: Color? = nil, shape: NeomorphicShape = .rectangle) -> NeomorphicButtonStyle {
        NeomorphicButtonStyle(color: color, shape: shape)
    }
}

#Preview {
    ScrollView {
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
            }
            .buttonStyle(.neomorphic)
            
            // Circular button
            Button {
                print("Circle button tapped!")
            } label: {
                Image(systemName: "heart.fill")
            }
            .buttonStyle(.neomorphic(shape: .circle(size: 80)))
            
            // Small circular button
            Button {
                print("Small circle button tapped!")
            } label: {
                Image(systemName: "plus")
            }
            .buttonStyle(.neomorphic(shape: .circle(size: nil)))
        }
        .padding(40)
        .background(Color.neomorphicWhite)
        .cornerRadius(40)
    }
}
