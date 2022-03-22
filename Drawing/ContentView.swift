//
//  ContentView.swift
//  Drawing
//
//  Created by Garret Poole on 3/20/22.
//

import SwiftUI

struct ColorCyclingCircle: View{
    var amount = 0.0
    var steps = 100
    
    var body: some View{
        ZStack{
            ForEach(0..<steps) { value in
                Circle()
                    .inset(by: Double(value))
                    .strokeBorder(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                color(for: value, brightness: 1),
                                color(for: value, brightness: 0.5),
                            ]),
                            startPoint: .top,
                            endPoint: .bottom
                            ),
                        lineWidth: 2)
            }
        }
        //now powered by Apple's METAL framework rather than Core Animation, for high performance gpu graphics
        //renders contents of view offscreen before putting it on screen as a single piece of rendered output
        //wait until performance problem as it may actually slow down simple rendering
        .drawingGroup()
    }
    
    func color(for value: Int, brightness: Double) -> Color{
        var targetHue = Double(value)/Double(steps) + amount
        if targetHue > 1{
            targetHue -= 1
        }
        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }
}

struct ContentView: View {
    @State private var colorCycle = 0.0

    var body: some View{
        VStack{
            ColorCyclingCircle(amount: colorCycle)
                .frame(width: 300, height: 300)
            Slider(value: $colorCycle)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
