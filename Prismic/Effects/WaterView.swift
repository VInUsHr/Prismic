//
// WaterView.swift
// Prismic
// https://www.github.com/twostraws/Prismic
// See LICENSE for license information.
//

import SwiftUI

struct WaterAttribute: TextAttribute { }

struct WaterRenderer: TextRenderer {
    var time: Double
    var speed: Double
    var strength: Double
    var frequency: Double

    func draw(layout: Text.Layout, in context: inout GraphicsContext) {
        for line in layout {
            for run in line {
                if run[WaterAttribute.self] != nil {
                    var copy = context

                    copy.addFilter(.distortionShader(
                        ShaderLibrary.water(
                            .float2(run.typographicBounds.rect.size),
                            .float(time),
                            .float(speed),
                            .float(strength),
                            .float(frequency)
                        ), maxSampleOffset: CGSize(width: 100, height: 100)))

                    copy.draw(run)
                } else {
                    context.draw(run)
                }
            }
        }
    }
}

struct WaterView: View {
    @State private var startTime = Date.now
    @State private var speed = 3.0
    @State private var strength = 3.0
    @State private var frequency = 10.0

    var body: some View {
        VStack {
            TimelineView(.animation) { timeline in
                let time = startTime.distance(to: timeline.date)

                Text("WORDART")
                    .customAttribute(WaterAttribute())
                    .font(.system(size: 72))
                    .lineSpacing(40)
                    .textRenderer(WaterRenderer(time: time, speed: speed, strength: strength, frequency: frequency))
            }

            LabeledContent("Speed") {
                Slider(value: $speed, in: 0.5...10)
            }

            LabeledContent("Strength") {
                Slider(value: $strength, in: 1...5)
            }

            LabeledContent("Frequency") {
                Slider(value: $frequency, in: 5...25)
            }
        }
        .navigationSubtitle("Water")
        .padding()
    }
}

#Preview {
    WaterView()
}
