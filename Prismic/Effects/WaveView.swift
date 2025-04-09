//
// WaveView.swift
// Prismic
// https://www.github.com/twostraws/Prismic
// See LICENSE for license information.
//

import SwiftUI

struct WaveRenderer: TextRenderer {
    var strength: Double
    var frequency: Double

    var animatableData: Double {
       get { strength }
       set { strength = newValue }
    }

    func draw(layout: Text.Layout, in context: inout GraphicsContext) {
        for line in layout {
            for run in line {
                for (i, glyph) in run.enumerated() {
                    let yOffset = strength
                             * sin(Double(i) * frequency)

                    var copy = context
                    copy.translateBy(x: 0, y: yOffset)
                    copy.draw(glyph)
                }
            }
        }
    }
}

struct WaveView: View {
    @State private var offsetAmount = -20.0

    var body: some View {
        Text("This is an ***important*** string with lots of text inside.")
            .font(.system(size: 72))
            .lineSpacing(40)
            .foregroundStyle(.linearGradient(colors: [.red, .orange], startPoint: .bottom, endPoint: .top))
            .textRenderer(
               WaveRenderer(
                  strength: offsetAmount,
                  frequency: 0.5
               )
            )
            .onAppear {
               withAnimation(.easeInOut(duration: 1)
                  .repeatForever()) {
                     offsetAmount = 20
               }
            }
            .padding()
            .navigationSubtitle("Animated Wave")
    }
}

#Preview {
    WaveView()
}
