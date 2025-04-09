//
// BlurredRainbowGradientView.swift
// Prismic
// https://www.github.com/twostraws/Prismic
// See LICENSE for license information.
//

import SwiftUI

struct BlurredRainbowGradientAttribute: TextAttribute { }

struct BlurredRainbowGradientRenderer: TextRenderer {
    var xOffset: Double

    var animatableData: Double {
        get { xOffset }
        set { xOffset = newValue }
    }

    func draw(layout: Text.Layout, in context: inout GraphicsContext) {
        for line in layout {
            for run in line {
                if run[BlurredRainbowGradientAttribute.self] != nil {
                    var copy = context

                    copy.addFilter(
                        .colorShader(
                            ShaderLibrary.rainbowGradient(
                                .float2(run.typographicBounds.rect.size),
                                .float(xOffset)
                            )
                        )
                    )

                    copy.addFilter(.blur(radius: 10))

                    copy.draw(run)
                    copy.draw(run)
                    context.draw(run)
                } else {
                    context.draw(run)
                }
            }
        }
    }
}

struct BlurredRainbowGradientView: View {
    @State private var xOffset = 0.0

    var body: some View {
        VStack {
            Text("This is a really ***important*** string with lots of text inside.")
                .customAttribute(BlurredRainbowGradientAttribute())
                .font(.system(size: 72))
                .foregroundStyle(.white)
                .lineSpacing(40)
                .textRenderer(BlurredRainbowGradientRenderer(xOffset: xOffset))
        }
        .navigationSubtitle("Blurred Rainbow Gradient")
        .padding()
        .onAppear {
            withAnimation(.linear(duration: 2).repeatForever(autoreverses: false)) {
                xOffset = 1
            }
        }
    }
}

#Preview {
    BlurredRainbowGradientView()
}
