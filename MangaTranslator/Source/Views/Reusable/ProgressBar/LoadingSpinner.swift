//
//  LoadingSpinner.swift
//  MangaTranslator
//
//  Created by BOWEN WU on 8/30/20.
//

import SwiftUI

struct LoadingSpinner: View {
    let description: String
    @State var isAnimating = false
    
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .stroke(AngularGradient(gradient: Gradient(colors: [Color.purple, Color.blue]), center: .center, angle: .degrees(30)), lineWidth: 8)
                    .frame(width: 45, height: 45, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    
                Circle()
                    .trim(from: 0, to: 0.2)
                    .stroke(Color.white, lineWidth: 8)
                    .frame(width: 45, height: 45, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .rotationEffect(.init(degrees: isAnimating ? 360 : 0), anchor: .center)
                    .animation(Animation.linear(duration: 0.7).repeatForever(autoreverses: false))
            }
            
            
            Text(description)
                .foregroundColor(.secondary)
        }
        .onAppear {
            isAnimating = true
        }
        
    }
}

struct LoadingSpinner_Previews: PreviewProvider {
    static var previews: some View {
        LoadingSpinner(description: "Loading")
    }
}
