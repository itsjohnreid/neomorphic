//
//  ContentView.swift
//  Neomorphic
//
//  Created by John Reid on 13/3/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            ScrollView {
                VStack(spacing: 30) {
                    Button("Hey", action: { })
                        .buttonStyle(.neomorphic)
                    
                    // Uses inherited blue theme
                    Button("Button") { }
                        .buttonStyle(.neomorphic)
                    
                    // Overrides just this button's color
                    Button("Button") { }
                        .buttonStyle(.neomorphic)
                        .neomorphicTheme(.init(baseColor: .blue))
                    
                    Text("Neomorphic Tiles")
                        .font(.largeTitle)
                        .bold()
                        .padding()
                        .neomorphic()
                    
                    // Another example with different depths
                    VStack(spacing: 16) {
                        Text("Stacked Depths")
                            .font(.title3)
                            .bold()
                        
                        VStack(spacing: 12) {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color(white: 0.95))
                                .frame(height: 40)
                                .neomorphic()
                            
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color(white: 0.95))
                                .frame(height: 40)
                                .neomorphic()
                        }
                    }
                    .padding()
                    .neomorphic()
                    
                }
                .padding(24)
            }
        }
        .neomorphic()
//        .neomorphicTheme(.init(baseColor: .green))
        .colorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
