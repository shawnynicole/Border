# Border

**Border** makes ease of creating solid and dotted borders with any corner radius, color, or line width in SwiftUI.

<p align="center">
<img src="../assets/screenshot.png?raw=true" alt="Screenshot" width="300" />
</p>

<p align="center">
    <a href="#requirements">Requirements</a> • <a href="#usage">Usage</a> • <a href="#installation">Installation</a> • <a href="#author">Author</a> • <a href="#license-mit">License</a>
</p>

## Requirements

- iOS 14.0+
- Xcode 10.2+
- Swift 5.0+

## Usage

```swift

let lineWidth: CGFloat = 5

let corners: [Corner: BorderCorner] = [
    .topLeading: .topLeading(radius: 20, color: .red, lineWidth: lineWidth),
    //.topTrailing: .topTrailing(radius: 20),
    //.bottomLeading: .bottomLeading(radius: 20),
    .bottomTrailing: .bottomTrailing(radius: 20, color: .green, lineWidth: lineWidth)
]

let edges: [Edge: BorderEdge] = [
    .top: .top(color: .orange, lineWidth: lineWidth, dotted: true),
    .leading: .leading(color: .purple, lineWidth: lineWidth),
    .trailing: .trailing(color: .yellow, lineWidth: lineWidth),
    .bottom: .bottom(color: .blue, lineWidth: lineWidth, dotted: true)
]

let border = Border(corners: corners, edges: edges)

// Border as a shape
border
    .stroke()
    .frame(width: 100, height: 100)

// Border as a shape (clip shape)
Color(white: 0.9)
    .frame(width: 100, height: 100)
    .clipShape(border)

// Border as a view
border
    .frame(width: 100, height: 100)
    .padding()

// Border as a shape (clip shape) and view (border)
Color(white: 0.9)
    .frame(width: 100, height: 100)
    .border(border)

```

## Installation

#### Swift Package Manager
You can use [The Swift Package Manager](https://swift.org/package-manager) to install `Border` by adding the proper description to your `Package.swift` file:
```swift
import PackageDescription

let package = Package(
    name: "YOUR_PROJECT_NAME",
    targets: [],
    dependencies: [
        .package(url: "https://github.com/shawnynicole/Border.git", from: "1.0.0")
    ]
)
```
For more information on [Swift Package Manager](https://swift.org/package-manager), checkout its [GitHub Page](https://github.com/apple/swift-package-manager).

#### Manually

[Download](https://github.com/shawnynicole/Border/archive/master.zip) the project and copy the `Border` folder into your project to use it in.

## Author

shawnynicole

## License (MIT)

Border is available under the MIT license. See the LICENSE file for more info.
