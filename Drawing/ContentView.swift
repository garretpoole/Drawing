//
//  ContentView.swift
//  Drawing
//
//  Created by Garret Poole on 3/20/22.
//

import SwiftUI

struct Arrow: Shape{
    var thickness: Double
    var animatableData: Double{
        get { thickness }
        set { thickness = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX+thickness, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX-thickness, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX-thickness, y: rect.minY+2*thickness))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.midY+thickness))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.midY-thickness))
        path.addLine(to: CGPoint(x: rect.midX-thickness, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.midX+thickness, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY-thickness))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY+thickness))
        path.addLine(to: CGPoint(x: rect.midX+thickness, y: rect.minY+2*thickness))
        path.addLine(to: CGPoint(x: rect.midX+thickness, y: rect.maxY))
        return path
    }
}

struct ContentView: View {
    @State private var thickness = 20.0
    var body: some View{
        VStack(spacing: 0){
            Spacer()
            Arrow(thickness: thickness)
                .onTapGesture {
                    withAnimation{
                        thickness+=10
                    }
                }
                .frame(width: 250, height: 350)
            Spacer()
    
        }
       
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
