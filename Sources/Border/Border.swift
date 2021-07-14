//
//  Border.swift
//  SwiftUIBorder
//
//  Created by DeShawn Jackson on 7/13/21.
//

import SwiftUI

struct Border_Previews: PreviewProvider {
    static var previews: some View {
        
        VStack {
            
            // Border as a shape
            title("Shape") {
                border
                    .stroke()
                    .frame(width: 100, height: 100)
            }
            
            // Border as a shape (clip shape)
            title("Clip Shape") {
                Color(white: 0.9)
                    .frame(width: 100, height: 100)
                    .clipShape(border)
            }
            
            // Border as a view
            title("View") {
                border
                    .frame(width: 100, height: 100)
                    .padding()
            }
            
            // Border as a shape (clip shape) and view (border)
            title("Clip Shape\n&\nOverlay View") {
                Color(white: 0.9)
                    .frame(width: 100, height: 100)
                    .border(border)
            }
        }
        .padding(50)
    }
    
    static func title<A: View>(_ title: String, content: @escaping () -> A) -> some View {
        ZStack {
            content()
            Text(title)
                .font(.subheadline)
                .multilineTextAlignment(.center)
        }
    }
    
    static var border: Border {
        
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
        
        return Border(corners: corners, edges: edges)
    }
}

// TODO: Conform Border to InsettableShape for use with .strokeBorder

public struct Border: Shape {
    
    // MARK: - Stored Properties
    
    private var corners: [Corner: BorderCorner] = [
        .topLeading: .topLeading,
        .topTrailing: .topTrailing,
        .bottomLeading: .bottomLeading,
        .bottomTrailing: .bottomTrailing
    ]
    
    private var edges: [Edge: BorderEdge] = [
        .top: .top,
        .leading: .leading,
        .trailing: .trailing,
        .bottom: .bottom
    ]
    
    // MARK: - Init
    
    public init() { }
    
    public init(corners: [Corner: BorderCorner], edges: [Edge: BorderEdge]) {
        self.corners = corners
        
        // Adjust the given edges based on the corners
        edges.forEach { (edge, borderEdge) in
            self.edges[edge] = borderEdge.corners(corners: edgeCorners(borderEdge))
        }
    }
    
    // MARK: - Helpers
    
    private func edgeCorners(_ edge: BorderEdge) -> (startingCorner: BorderCorner, endingCorner: BorderCorner) {
        let startingCorner = edge.edge.startingCorner
        let endingCorner = edge.edge.endingCorner
        return (corners[startingCorner] ?? startingCorner.borderCorner, corners[endingCorner] ?? endingCorner.borderCorner)
    }
    
    // MARK: - View (Border as a View)
    
    public var body: some View {
        ZStack {
            ForEach(Corner.allCases, id: \.self) { corners[$0] }
            ForEach(Edge.allCases, id: \.self) { edges[$0] }
        }
    }
    
    // MARK: - Shape (Border as a Shape)
    
    public func path(in rect: CGRect) -> Path {
                
        // Corners
        let topLeading = corners[.topLeading] ?? .topLeading
        let topTrailing = corners[.topTrailing] ?? .topTrailing
        let bottomTrailing = corners[.bottomTrailing] ?? .bottomTrailing
        let bottomLeading = corners[.bottomLeading] ?? .bottomLeading
        
        // Edges
        let top = edges[.top] ?? .top(corners: edgeCorners(.top))
        let trailing = edges[.trailing] ?? .trailing(corners: edgeCorners(.trailing))
        let bottom = edges[.bottom] ?? .bottom.corners(corners: edgeCorners(.bottom))
        let leading = edges[.leading] ?? .leading.corners(corners: edgeCorners(.leading))
        
        // Create path
        
        var path = Path()
        
        func addEdge(_ edge: BorderEdge) {
            //path.addPath(edge.path(in: rect))
            //path.addLine(to: edge.endingPoint(in: rect))
            edge.path(&path, in: rect)
        }
        
        func addCorner(_ corner: BorderCorner) {
            //path.addPath(corner.path(in: rect))
            //path.addRelativeArc(center: corner.arcCenterPoint(in: rect), radius: corner.radius, startAngle: corner.startingAngle, delta: .degrees(90))
            corner.path(&path, in: rect)
        }
        
        // Corner.topLeading
        addCorner(topLeading)
        
        // Edge.top
        addEdge(top)
        
        // Corner.topTrailing
        addCorner(topTrailing)
        
        //Edge.trailing
        addEdge(trailing)
        
        // Corner.bottomTrailing
        addCorner(bottomTrailing)
        
        // Edge.bottom
        addEdge(bottom)
        
        // Corner.bottomLeading
        addCorner(bottomLeading)
        
        // Edge.leading
        addEdge(leading)
        
        return path
    }
    
//    // MARK: - Insettable Shape
//
//    public func inset(by amount: CGFloat) -> some InsettableShape {
//
//        corners.forEach({ $0.value.inset(by: amount) })
//        edges.forEach({ $0.value.inset(by: amount) })
//
//        return self
//    }
}

// MARK: - View+

extension View {
    public func border(_ border: Border = .init()) -> some View {
        self
            .clipShape(border)
            .overlay(border)
    }
}
