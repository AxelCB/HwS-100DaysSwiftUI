//
//  ChallengeContentView.swift
//  Drawing
//
//  Created by Axel Collard Bovy on 22/9/22.
//

import SwiftUI

struct ChallengeContentView: View {
    @State var arrowLineWidth = 1.0

    var body: some View {
        AnimatableArrow(lineWidth: arrowLineWidth)
            .frame(width: 200, height: 600)
            .onTapGesture {
                withAnimation(.easeInOut(duration: 6)) {
                    arrowLineWidth += 15
                }
            }
    }
}

struct ChallengeContentView_Previews: PreviewProvider {
    static var previews: some View {
        ChallengeContentView()
    }
}

struct AnimatableArrow: View, Animatable {
    var lineWidth: Double
    var animatableData: Double {
        get { lineWidth }
        set { lineWidth = newValue }
    }

    var body: some View {
        Arrow()
            .strokeBorder(lineWidth: lineWidth)
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

struct ColorCyclingRectangle: View {
    var amount = 0.0
    var steps = 100
    var gradientStartPoint: (Double, Double) = (0.0, 0.0)
    var gradientEndPoint: (Double, Double) = (0.0, 0.0)

    var body: some View {
        ZStack {
            ForEach(0..<steps) { value in
                Rectangle()
                    .inset(by: Double(value))
                    .strokeBorder(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                color(for: value, brightness: 1),
                                color(for: value, brightness: 0.5)
                            ]),
                            startPoint: UnitPoint(x: gradientStartPoint.0, y: gradientStartPoint.1),
                            endPoint: UnitPoint(x: gradientEndPoint.0, y: gradientEndPoint.1)
                        ),
                        lineWidth: 2
                    )
            }
        }
        .drawingGroup()
    }

    func color(for value: Int, brightness: Double) -> Color {
        var targetHue = Double(value) / Double(steps) + amount

        if targetHue > 1 {
            targetHue -= 1
        }

        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }
}

struct ColorCyclingRectangleContentView: View {
    @State private var colorCycle = 0.0
    @State private var gradientStartX = 0.0
    @State private var gradientStartY = 0.0
    @State private var gradientEndX = 0.0
    @State private var gradientEndY = 0.0

    var body: some View {
        VStack {
            ColorCyclingRectangle(amount: colorCycle,
                                  gradientStartPoint: (gradientStartX, gradientStartY),
                                  gradientEndPoint: (gradientEndX, gradientEndY)
                )
                .frame(width: 300, height: 300)

            HStack {
                Text("Color: ")
                Slider(value: $colorCycle)
            }
            HStack {
                Text("Gradient Start X: ")
                Slider(value: $gradientStartX)
            }
            HStack {
                Text("Gradient Start Y: ")
                Slider(value: $gradientStartY)
            }
            HStack {
                Text("Gradient End X: ")
                Slider(value: $gradientEndX)
            }
            HStack {
                Text("Gradient End Y: ")
                Slider(value: $gradientEndY)
            }

        }
    }
}
