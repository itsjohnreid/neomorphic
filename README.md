# Neomorphic

A modern SwiftUI library for creating beautiful neomorphic UI elements that adapt to both light and dark modes. Right now I'm just making this demo app but I plan to set up a library.

## Features

- 🎨 Automatic light/dark mode adaptation
- 🌈 Support for any custom color
- 🎯 Customizable corner radius and shadow parameters
- 🔄 Smooth spring animations
- 📱 iOS-first design
- 🎭 Theme inheritance through SwiftUI environment

## Usage

### Basic Button

```swift
Button("Tap Me") {
    print("Button tapped!")
}
.buttonStyle(.neomorphic)
```

### Custom Color

```swift
Button("Blue Button") {
    print("Button tapped!")
}
.buttonStyle(.neomorphic)
.neomorphic(color: .blue)
```

### Circular Button

```swift
Button {
    print("Circle button tapped!")
} label: {
    Image(systemName: "heart.fill")
}
.buttonStyle(.neomorphic(shape: .circle(size: 60)))
```

### Theme Inheritance

Set a theme for an entire view hierarchy:

```swift
VStack {
    // All buttons will inherit the blue theme
    Button("Button 1") { }
        .buttonStyle(.neomorphic)
    
    Button("Button 2") { }
        .buttonStyle(.neomorphic)
}
.neomorphicTheme(color: .blue)
```

Override for specific views:

```swift
VStack {
    // Uses parent blue theme
    Button("Blue") { }
        .buttonStyle(.neomorphic)
    
    // Override with green
    Button("Green") { }
        .buttonStyle(.neomorphic)
        .neomorphic(color: .green)
}
.neomorphicTheme(color: .blue)
```

## Customization

### Shadow Parameters

```swift
Button("Custom Shadows") { }
    .buttonStyle(.neomorphic)
    .neomorphic(
        cornerRadius: 20,
        shadowRadius: 12,
        shadowOffset: 10
    )
```

### Custom Colors

The library automatically generates appropriate light and dark shadows for any color:

```swift
// Custom brand color
let brandColor = Color(red: 0.2, green: 0.5, blue: 0.8)

Button("Brand Button") { }
    .buttonStyle(.neomorphic)
    .neomorphic(color: brandColor)
```
