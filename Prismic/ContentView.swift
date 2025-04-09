//
// ContentView.swift
// Prismic
// https://www.github.com/twostraws/Prismic
// See LICENSE for license information.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationSplitView {
            List(Destination.allCases, id: \.self) { destination in
                NavigationLink(destination.name, value: destination)
            }
            .navigationDestination(for: Destination.self, destination: \.view)
            .frame(minWidth: 250)
        } detail: {
            VStack {
                Image(.logo)

                Text("A collection of `TextRenderer` effects for SwiftUI.")
                    .font(.largeTitle)
            }
        }
    }
}

#Preview {
    ContentView()
}
