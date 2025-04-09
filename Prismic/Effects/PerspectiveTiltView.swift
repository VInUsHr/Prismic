//
// PerspectiveTiltView.swift
// Prismic
// https://www.github.com/twostraws/Prismic
// See LICENSE for license information.
//

import SwiftUI

struct PerspectiveTiltAttribute: TextAttribute { }

struct PerspectiveTiltRenderer: TextRenderer {
    var strength: Double

    func draw(layout: Text.Layout, in context: inout GraphicsContext) {
        for line in layout {
            for run in line {
                if run[PerspectiveTiltAttribute.self] != nil {
                    var copy = context

                    copy.addFilter(.distortionShader(
                        ShaderLibrary.perspectiveTilt(
                            .float2(run.typographicBounds.rect.origin),
                            .float2(run.typographicBounds.rect.size),
                            .float(strength)
                        ), maxSampleOffset: .zero))

                    copy.draw(run)
                } else {
                    context.draw(run)
                }
            }
        }
    }
}

struct PerspectiveTiltView: View {
    @State private var strength = 0.0

    var body: some View {
        let important = Text("important")
           .customAttribute(PerspectiveTiltAttribute())

        let inside = Text("inside")
           .customAttribute(PerspectiveTiltAttribute())

        VStack {
            Text("This is an \(important) string with lots of text \(inside).")
                .font(.system(size: 72))
                .lineSpacing(40)
                .textRenderer(PerspectiveTiltRenderer(strength: strength))

            Slider(value: $strength)
        }
        .navigationSubtitle("Perspective Tilt")
        .padding()
    }
}

#Preview {
    PerspectiveTiltView()
}
