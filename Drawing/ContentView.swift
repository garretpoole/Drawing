//
//  ContentView.swift
//  Drawing
//
//  Created by Garret Poole on 3/20/22.
//

import SwiftUI

struct Triangle: Shape{
    func path(in rect: CGRect) -> Path{
        var path = Path()
        //creates triangle freely using call to Rect
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        return path
    }
}
//InsettableShape inherits from Shape so no need to confrom to both
struct Arc: InsettableShape{
    let startAngle: Angle
    let endAngle: Angle
    let clockwise: Bool
    //make strokeBorder modifier work with Arc through InsettableShape
    var insetAmount = 0.0
    
    func path(in rect: CGRect) -> Path {
        //0 degrees mathematically is to the right in SwiftUI and other languages so must adjust by 90 degrees
        let rotationAdjustment = Angle.degrees(90)
        let modifiedStart = startAngle - rotationAdjustment
        let modifiedEnd = endAngle - rotationAdjustment
        //Shapes measure coordinates from bottom left corner rather than top left so must flip clockwise to get actual clockwise drawing
        var path = Path()
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width / 2 - insetAmount, startAngle: modifiedStart, endAngle: modifiedEnd, clockwise: !clockwise)
        return path
    }
    
    func inset(by amount: CGFloat) -> some InsettableShape{
        var arc = self
        arc.insetAmount += amount
        return arc
    }
}

struct ContentView: View {
    var body: some View {
        //main difference with Shapes is reusability
        Arc(startAngle: .degrees(-90), endAngle: .degrees(90), clockwise: true)
        //strokes inside of the shape border
            .strokeBorder(.blue, lineWidth: 40)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
