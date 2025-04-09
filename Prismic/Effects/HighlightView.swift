//
// HighlightView.swift
// Prismic
// https://www.github.com/twostraws/Prismic
// See LICENSE for license information.
//

import SwiftUI

struct HighlightAttribute: TextAttribute { }

struct HighlightRenderer: TextRenderer {
    var color: Color

    func draw(layout: Text.Layout, in context: inout GraphicsContext) {
        for line in layout {
           for run in line {
              if run[HighlightAttribute.self] != nil {
                  context.fill(
                     Rectangle()
                        .path(in: run.typographicBounds.rect),
                     with: .color(color)
                  )
              }

              context.draw(run)
           }
        }
    }
}

struct HighlightView: View {
    @State private var color = Color.blue

    var body: some View {
        let important = Text("important")
           .customAttribute(HighlightAttribute())

        VStack {
            Text("This is an \(important) string with lots of text inside.")
                .font(.system(size: 72))
                .lineSpacing(40)
                .textRenderer(HighlightRenderer(color: color))

            ColorPicker("Select a color", selection: $color)
        }
        .padding()
        .navigationSubtitle("Highlighted Text")
    }
}

#Preview {
    HighlightView()
}
