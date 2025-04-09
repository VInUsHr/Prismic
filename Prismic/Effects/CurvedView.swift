//
// CurvedView.swift
// Prismic
// https://www.github.com/twostraws/Prismic
// See LICENSE for license information.
//

import SwiftUI

struct CurvedAttribute: TextAttribute { }

struct CurvedRenderer: TextRenderer {
    var strength: Double

    func draw(layout: Text.Layout, in context: inout GraphicsContext) {
        for line in layout {
            for run in line {
                if run[CurvedAttribute.self] != nil {
                    var copy = context

                    copy.addFilter(.distortionShader(
                        ShaderLibrary.curved(
                            .float2(run.typographicBounds.rect.origin),
                            .float2(run.typographicBounds.rect.size),
                            .float(strength)
                        ), maxSampleOffset: CGSize(width: 100, height: 100)))

                    copy.draw(run)
                } else {
                    context.draw(run)
                }
            }
        }
    }
}

struct CurvedView: View {
    @State private var strength = 0.0

    var body: some View {
        VStack {
            Text("WORDART")
                .customAttribute(CurvedAttribute())
                .font(.system(size: 72))
                .lineSpacing(40)
                .textRenderer(CurvedRenderer(strength: strength))

            Slider(value: $strength, in: 0...0.75)
        }
        .navigationSubtitle("Curved Text")
        .padding()
    }
}

#Preview {
    CurvedView()
}
