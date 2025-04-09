//
// EarthquakeView.swift
// Prismic
// https://www.github.com/twostraws/Prismic
// See LICENSE for license information.
//

import SwiftUI

struct EarthquakeAttribute: TextAttribute { }

struct EarthquakeRenderer: TextRenderer {
    var moveAmount: Double
    var shouldBlur = false

    var animatableData: Double {
        get { moveAmount }
        set { moveAmount = newValue }
    }

    func draw(layout: Text.Layout, in context: inout GraphicsContext) {
        for line in layout {
            for run in line {
                for glyph in run {
                    if run[EarthquakeAttribute.self] != nil {
                        let yOffset = Double.random(in: -moveAmount...moveAmount)
                        var copy = context

                        if shouldBlur {
                            copy.addFilter(.blur(radius: moveAmount / 4))
                        }

                        copy.translateBy(x: 0, y: yOffset)
                        copy.draw(glyph)
                    } else {
                        context.draw(glyph)
                    }
                }
            }
        }
    }
}

struct EarthquakeView: View {
    @State private var addBlurEffect = false
    @State private var moveAmount = 0.0

    var body: some View {
        VStack {
            Text("This is an ***important*** string with lots of text inside.")
                .customAttribute(EarthquakeAttribute())
                .font(.system(size: 72))
                .lineSpacing(40)
                .textRenderer(EarthquakeRenderer(moveAmount: moveAmount, shouldBlur: addBlurEffect))

            Toggle("Add Motion Blur", isOn: $addBlurEffect)
        }
        .navigationSubtitle("Animated Earthquake")
        .padding()
        .onAppear {
            withAnimation(.easeInOut(duration: 1).repeatForever(autoreverses: true)) {
                moveAmount = 10
            }
        }
    }
}

#Preview {
    EarthquakeView()
}
