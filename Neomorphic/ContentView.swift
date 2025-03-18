//
//  ContentView.swift
//  Neomorphic
//
//  Created by John Reid on 13/3/2025.
//

import SwiftUI

struct ContentView: View {
    @State var darkMode = false
    @State var theme: Color? = nil
    
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                Text("Neomorphic")
                    .font(.largeTitle)
                    .bold()
                    .padding()
                
                Button("Nothing Button!") { }
                    .fontWeight(.bold)
                    .buttonStyle(.neomorphic)
                
                HStack(spacing: 20) {
                    Button("Teal") { theme = .teal}
                        .foregroundStyle(.teal)
                        .fontWeight(.bold)
                        .buttonStyle(.neomorphic(shape: .circle(size: nil)))
                    
                    Button("Orange") { theme = .orange}
                        .foregroundStyle(.orange)
                        .fontWeight(.bold)
                        .buttonStyle(.neomorphic(shape: .circle(size: nil)))
                    
                    Button("Clear") { theme = nil}
                        .fontWeight(.bold)
                        .buttonStyle(.neomorphic(shape: .circle(size: nil)))
                }
                .padding(20)
                .neomorphic(cornerRadius: .infinity)
                
                Button("Toggle Light/Dark") { darkMode.toggle() }
                    .buttonStyle(.neomorphic)
                
                Button("Colored Button") { }
                    .buttonStyle(.neomorphic(color: .teal))
                
                VStack(spacing: 20) {
                    Text("Stacked Panels")
                        .font(.title3)
                        .bold()
                    
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.neomorphicWhite)
                        .frame(height: 40)
                        .padding()
                        .neomorphic()
                    
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.neomorphicBlack)
                        .frame(height: 40)
                        .padding()
                        .neomorphic()
                }
                .padding(12)
                .neomorphic()
                
                VStack {
                    HStack(spacing: 4) {
                        ForEach("QWERTYUIOP".map { String($0) }, id: \.self) { letter in
                            letterButton(letter: letter)
                        }
                    }
                    HStack(spacing: 4) {
                        ForEach("ASDFGHJKL".map { String($0) }, id: \.self) { letter in
                            letterButton(letter: letter)
                        }
                    }
                    HStack(spacing: 4) {
                        ForEach("ZXCVBNM".map { String($0) }, id: \.self) { letter in
                            letterButton(letter: letter)
                        }
                    }
                }
                .padding(.vertical)
                
                Spacer(minLength: 40)
            }
            .padding(24)
        }
        .neomorphicTheme(.init(baseColor: theme))
        .background(backgroundColor, ignoresSafeAreaEdges: .all)
        .colorScheme(darkMode ? .dark : .light)
    }
    
    func letterButton(letter: String) -> some View {
        Button(action: { }) {
            Text(letter)
                .fixedSize()
        }
        .buttonStyle(.neomorphic(shape: .circle(size: 26)))
    }
    
    private var backgroundColor: Color {
        theme ?? (darkMode ? Color.neomorphicBlack : Color.neomorphicWhite)
    }
}

#Preview {
    ContentView()
}
