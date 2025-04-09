//
// VisualizationView.swift
// Prismic
// https://www.github.com/twostraws/Prismic
// See LICENSE for license information.
//

import SwiftUI

struct VisualizationRenderer: TextRenderer {
    var showLines = false
    var showRuns = false
    var showGlyphs = false

    let width = 8.0

    func draw(layout: Text.Layout, in context: inout GraphicsContext) {
        for line in layout {
            for run in line {
                if showGlyphs {
                    for glyph in run {
                        context.stroke(Rectangle().path(in: glyph.typographicBounds.rect.insetBy(dx: width, dy: width)), with: .color(.blue), lineWidth: width)
                    }
                }

                if showRuns {
                    context.stroke(Rectangle().path(in: run.typographicBounds.rect), with: .color(.green), lineWidth: width)
                }
            }

            if showLines {
                context.stroke(Rectangle().path(in: line.typographicBounds.rect.insetBy(dx: -width, dy: -width)), with: .color(.red), lineWidth: width)
            }

            context.draw(line)
        }
    }
}

struct VisualizationView: View {
    @State private var showsLines = false
    @State private var showsRuns = false
    @State private var showsGlyphs = false

    var body: some View {
        VStack {
            Text("This is an ***important*** string with lots of text inside.")
                .font(.system(size: 72))
                .lineSpacing(40)
                .textRenderer(VisualizationRenderer(showLines: showsLines, showRuns: showsRuns, showGlyphs: showsGlyphs))

            HStack {
                Toggle("Show Lines", isOn: $showsLines)
                Toggle("Show Runs", isOn: $showsRuns)
                Toggle("Show Glyphs", isOn: $showsGlyphs)
            }
        }
        .navigationSubtitle("Visualization Renderer")
        .padding()
    }
}

#Preview {
    VisualizationView()
}
