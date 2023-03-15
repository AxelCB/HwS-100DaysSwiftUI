//
//  ChallengeContentView.swift
//  Drawing
//
//  Created by Axel Collard Bovy on 22/9/22.
//

import SwiftUI

struct ChallengeContentView: View {
    var body: some View {
        Arrow()
            .strokeBorder(lineWidth: 10)
            .frame(width: 200, height: 300)

    }
}

struct ChallengeContentView_Previews: PreviewProvider {
    static var previews: some View {
        ChallengeContentView()
    }
}

struct Arrow: InsettableShape {
    var insetAmount = 0.0

    func path(in rect: CGRect) -> Path {
        var path = Path()

        let arrowTriangleHeight = rect.height * 1/3 - 2 * insetAmount

        path.move(to: CGPoint(x: rect.minX + insetAmount, y: arrowTriangleHeight ))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY + insetAmount))
        path.addLine(to: CGPoint(x: rect.maxX - insetAmount, y: arrowTriangleHeight))
        path.move(to: CGPoint(x: rect.midX, y: rect.minY + insetAmount))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))

        return path
    }

    func inset(by amount: CGFloat) -> some InsettableShape {
        var arrow = self
        arrow.insetAmount += amount
        return arrow
    }
}
