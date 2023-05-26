//
//  Pie.swift
//  Memorize
//
//  Created by Niyaz Fazlyev on 24.05.2023.
//

import SwiftUI

struct Pie: Shape {
    var startAngle: Angle
    var endAngle: Angle
    
    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2
        let start = CGPoint(
            x: center.x + CGFloat(cos(startAngle.radians)) * radius,
            y: center.y + CGFloat(sin(startAngle.radians)) * radius
        )
        var p = Path()
        p.move(to: center)
        p.addLine(to: start)
        p.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        p.addLine(to: center)

        return p
    }
    
    
}
