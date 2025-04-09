//
// StripedLinesView.swift
// Prismic
// https://www.github.com/twostraws/Prismic
// See LICENSE for license information.
//

import SwiftUI

struct StripedLineRenderer: TextRenderer {
    func draw(layout: Text.Layout, in context: inout GraphicsContext) {
        for (i, line) in layout.enumerated() {
           if i.isMultiple(of: 2) {
              context.opacity = 0.35
           } else {
              context.opacity = 1
           }

           context.draw(line)
        }
    }
}

struct StripedLinesView: View {
    var body: some View {
        Text("This is an ***important*** string with lots of text inside.")
            .font(.system(size: 72))
            .lineSpacing(40)
            .textRenderer(StripedLineRenderer())
            .padding()
            .navigationSubtitle("Striped Lines")
    }
}

#Preview {
    StripedLinesView()
}
