//
//  BorderEdge.swift
//  SwiftUIBorder
//
//  Created by DeShawn Jackson on 7/14/21.
//

import SwiftUI

struct BorderEdge_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            BorderEdge.top(color: .red, lineWidth: 2, dotted: true)
            BorderEdge.trailing(color: .orange, lineWidth: 5, dotted: false)
            BorderEdge.bottom(color: .green, lineWidth: 5, dotted: true)
            BorderEdge.leading(color: .blue, lineWidth: 2, dotted: false)
        }
        .frame(width: 100, height: 100)
    }
}

public struct BorderEdge: BorderProperty, InsettableShape {
    
    // MARK: - "Init"
    
    public static var all: [BorderEdge] {
        [.top, .bottom, .leading, .trailing]
    }
    
    public static func all(radius: CGFloat = 0, color: Color = .black, lineWidth: CGFloat = 1) -> [BorderEdge] {
        [
            .top(color: color, lineWidth: lineWidth),
            .bottom(color: color, lineWidth: lineWidth),
            .leading(color: color, lineWidth: lineWidth),
            .trailing(color: color, lineWidth: lineWidth)
        ]
    }
    
    public static var top: BorderEdge { BorderEdge(edge: .top) }
    
    public static func top(color: Color = .black, lineWidth: CGFloat = 1, dotted: Bool = false) -> BorderEdge {
        BorderEdge(color: color, lineWidth: lineWidth, dotted: dotted, edge: .top)
    }
    
    public static var bottom: BorderEdge { BorderEdge(edge: .bottom) }
    
    public static func bottom(color: Color = .black, lineWidth: CGFloat = 1, dotted: Bool = false) -> BorderEdge {
        BorderEdge(color: color, lineWidth: lineWidth, dotted: dotted, edge: .bottom)
    }
    
    public static var leading: BorderEdge { BorderEdge(edge: .leading) }
    
    public static func leading(color: Color = .black, lineWidth: CGFloat = 1, dotted: Bool = false) -> BorderEdge {
        BorderEdge(color: color, lineWidth: lineWidth, dotted: dotted, edge: .leading)
    }
    
    public static var trailing: BorderEdge { BorderEdge(edge: .trailing) }
    
    public static func trailing(color: Color = .black, lineWidth: CGFloat = 1, dotted: Bool = false) -> BorderEdge {
        BorderEdge(color: color, lineWidth: lineWidth, dotted: dotted, edge: .trailing)
    }
    
    // MARK: - Stored Properties
    
    public let color: Color
    public let lineWidth: CGFloat
    public let dotted: Bool
    public let edge: Edge
        
    internal var startingRadius: CGFloat = 0
    internal var endingRadius: CGFloat = 0
    
    // InsettableShape
    public var insetAmount: CGFloat = 0
    
    // MARK: - Init
    
    private init(color: Color = .black, lineWidth: CGFloat = 1, dotted: Bool = false, edge: Edge) {
        self.color = color
        self.lineWidth = lineWidth
        self.dotted = dotted
        self.edge = edge
    }
    
    private init(_ edge: BorderEdge, startingRadius: CGFloat, endingRadius: CGFloat) {
        self.init(color: edge.color, lineWidth: edge.lineWidth, dotted: edge.dotted, edge: edge.edge)
        self.startingRadius = startingRadius
        self.endingRadius = endingRadius
    }
    
    // MARK: - Computed Methods
    
    public func startingPoint(in rect: CGRect) -> CGPoint {
        
        let cornerPoint: CGPoint = edge.startingPoint(in: rect)
        let radius = startingRadius
        
        let point: CGPoint = {
            switch edge {
            case .top: return CGPoint(x: cornerPoint.x + radius, y: cornerPoint.y)
            case .trailing: return CGPoint(x: cornerPoint.x, y: cornerPoint.y + radius)
            case .bottom: return CGPoint(x: cornerPoint.x - radius, y: cornerPoint.y)
            case .leading: return CGPoint(x: cornerPoint.x, y: cornerPoint.y - radius)
            }
        }()
        
        return CGPoint(x: point.x - insetAmount, y: point.y - insetAmount)
    }
    
    public func endingPoint(in rect: CGRect) -> CGPoint {
        
        let cornerPoint: CGPoint = edge.endingPoint(in: rect)
        let radius = endingRadius
        
        let point: CGPoint = {
            switch edge {
            case .top: return CGPoint(x: cornerPoint.x - radius, y: cornerPoint.y)
            case .trailing: return CGPoint(x: cornerPoint.x, y: cornerPoint.y - radius)
            case .bottom: return CGPoint(x: cornerPoint.x + radius, y: cornerPoint.y)
            case .leading: return CGPoint(x: cornerPoint.x, y: cornerPoint.y + radius)
            }
        }()
        
        return CGPoint(x: point.x - insetAmount, y: point.y - insetAmount)
    }
    
    // MARK: - Shape
    
    public func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: startingPoint(in: rect))
        self.path(&path, in: rect)
        //path.addLine(to: endingPoint(in: rect))
        return path
    }
    
    public func path(_ path: inout Path, in rect: CGRect) {
        path.addLine(to: endingPoint(in: rect))
    }
}

extension BorderEdge {
    // Used by Border to adjust startingPoint/endingPoint based on the starting/ending corner radiuses
    internal func corners(corners: (startingCorner: BorderCorner, endingCorner: BorderCorner)) -> BorderEdge {
        BorderEdge(self, startingRadius: corners.startingCorner.radius, endingRadius: corners.endingCorner.radius)
    }
    
    // Used by Border to adjust startingPoint/endingPoint based on the starting/ending corner radiuses
    internal static func top(corners: (startingCorner: BorderCorner, endingCorner: BorderCorner)) -> BorderEdge {
        BorderEdge(.top, startingRadius: corners.startingCorner.radius, endingRadius: corners.endingCorner.radius)
    }
    
    // Used by Border to adjust startingPoint/endingPoint based on the starting/ending corner radiuses
    internal static func bottom(corners: (startingCorner: BorderCorner, endingCorner: BorderCorner)) -> BorderEdge {
        BorderEdge(.bottom, startingRadius: corners.startingCorner.radius, endingRadius: corners.endingCorner.radius)
    }
    
    // Used by Border to adjust startingPoint/endingPoint based on the starting/ending corner radiuses
    internal static func leading(corners: (startingCorner: BorderCorner, endingCorner: BorderCorner)) -> BorderEdge {
        BorderEdge(.leading, startingRadius: corners.startingCorner.radius, endingRadius: corners.endingCorner.radius)
    }
    
    // Used by Border to adjust startingPoint/endingPoint based on the starting/ending corner radiuses
    internal static func trailing(corners: (startingCorner: BorderCorner, endingCorner: BorderCorner)) -> BorderEdge {
        BorderEdge(.trailing, startingRadius: corners.startingCorner.radius, endingRadius: corners.endingCorner.radius)
    }
}
