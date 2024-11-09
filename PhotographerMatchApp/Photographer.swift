import SwiftUI

struct Photographer: Identifiable {
    let id = UUID()
    let name: String
    let styles: [String]
    let color: Color
    let sampleImage: Image
}
