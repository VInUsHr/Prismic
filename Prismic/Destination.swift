//
// Destination.swift
// Prismic
// https://www.github.com/twostraws/Prismic
// See LICENSE for license information.
//

import SwiftUI

enum Destination: CaseIterable {
    case visualization, striped, highlight, wave
    case earthquake, perspectiveTilt, curved
    case water, grayscaleGradient, rainbowGradient
    case blurredRainbowGradient

    var name: String {
        switch self {
        case .visualization:
            "TextRenderer Visualization"
        case .striped:
            "Striped Lines"
        case .highlight:
            "Highlighted Text"
        case .wave:
            "Animated Wave"
        case .earthquake:
            "Animated Earthquake"
        case .perspectiveTilt:
            "Perspective Tilt"
        case .curved:
            "Curved Text"
        case .water:
            "Water"
        case .grayscaleGradient:
            "Grayscale Gradient"
        case .rainbowGradient:
            "Rainbow Gradient"
        case .blurredRainbowGradient:
            "Blurred Rainbow Gradient"
        }
    }

    @ViewBuilder var view: some View {
        switch self {
        case .visualization:
            VisualizationView()
        case .striped:
            StripedLinesView()
        case .highlight:
            HighlightView()
        case .wave:
            WaveView()
        case .earthquake:
            EarthquakeView()
        case .perspectiveTilt:
            PerspectiveTiltView()
        case .curved:
            CurvedView()
        case .water:
            WaterView()
        case .grayscaleGradient:
            GrayscaleGradientView()
        case .rainbowGradient:
            RainbowGradientView()
        case .blurredRainbowGradient:
            BlurredRainbowGradientView()
        }
    }
}
