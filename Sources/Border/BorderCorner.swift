//
//  BorderCorner.swift
//  SwiftUIBorder
//
//  Created by DeShawn Jackson on 7/14/21.
//

import SwiftUI

struct BorderCorner_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            BorderCorner.topLeading(radius: 10, color: .red, lineWidth: 2, dotted: true)
            BorderCorner.topTrailing(radius: 10, color: .orange, lineWidth: 5, dotted: false)
            BorderCorner.bottomTrailing(radius: 10, color: .green, lineWidth: 2, dotted: true)
            BorderCorner.bottomLeading(radius: 10, color: .blue, lineWidth: 5, dotted: false)
        }
        .frame(width: 100, height: 100)
    }
}

public struct BorderCorner: BorderProperty {
    
    // MARK: - "Init"
    
    public static var all: [BorderCorner] {
        [.topLeading, .topTrailing, .bottomLeading, .bottomTrailing]
    }
    
    public static func all(radius: CGFloat = 0, color: Color = .black, lineWidth: CGFloat = 1) -> [BorderCorner] {
        [
            .topLeading(radius: radius, color: color, lineWidth: lineWidth),
            .topTrailing(radius: radius, color: color, lineWidth: lineWidth),
            .bottomLeading(radius: radius, color: color, lineWidth: lineWidth),
            .bottomTrailing(radius: radius, color: color, lineWidth: lineWidth)
        ]
    }
    
    public static var topLeading: BorderCorner { BorderCorner(corner: .topLeading) }
    
    public static func topLeading(radius: CGFloat = 0, color: Color = .black, lineWidth: CGFloat = 1, dotted: Bool = false) -> BorderCorner {
        BorderCorner(radius: radius, color: color, lineWidth: lineWidth, dotted: dotted, corner: .topLeading)
    }
    
    public static var topTrailing: BorderCorner { BorderCorner(corner: .topTrailing) }
    
    public static func topTrailing(radius: CGFloat = 0, color: Color = .black, lineWidth: CGFloat = 1, dotted: Bool = false) -> BorderCorner {
        BorderCorner(radius: radius, color: color, lineWidth: lineWidth, dotted: dotted, corner: .topTrailing)
    }
    
    public static var bottomLeading: BorderCorner { BorderCorner(corner: .bottomLeading) }
    
    public static func bottomLeading(radius: CGFloat = 0, color: Color = .black, lineWidth: CGFloat = 1, dotted: Bool = false) -> BorderCorner {
        BorderCorner(radius: radius, color: color, lineWidth: lineWidth, dotted: dotted, corner: .bottomLeading)
    }
    
    public static var bottomTrailing: BorderCorner { BorderCorner(corner: .bottomTrailing) }
    
    public static func bottomTrailing(radius: CGFloat = 0, color: Color = .black, lineWidth: CGFloat = 1, dotted: Bool = false) -> BorderCorner {
        BorderCorner(radius: radius, color: color, lineWidth: lineWidth, dotted: dotted, corner: .bottomTrailing)
    }
    
    // MARK: - Stored Properties
    
    public let radius: CGFloat
    public let color: Color
    public let lineWidth: CGFloat
    public let dotted: Bool
    public let corner: Corner
    
    // InsettableShape
    public var insetAmount: CGFloat = 0
    
    // MARK: - Init
    
    private init(radius: CGFloat = 0, color: Color = .black, lineWidth: CGFloat = 1, dotted: Bool = false, corner: Corner) {
        self.radius = radius
        self.color = color
        self.lineWidth = lineWidth
        self.dotted = dotted
        self.corner = corner
    }
    
    // MARK: - Computed Properties
    
    public var startingAngle: Angle { corner.startingAngle }
    
    // MARK: - Computed Methods
    
    public func startingPoint(in rect: CGRect) -> CGPoint {
        
        let edge: BorderEdge = {
            switch corner {
            case .topLeading: return BorderEdge.leading
            case .topTrailing: return BorderEdge.top
            case .bottomTrailing: return BorderEdge.trailing
            case .bottomLeading: return BorderEdge.bottom
            }
        }()
        
        let point = edge.endingCorner(self).endingPoint(in: rect)
        let insetPoint = CGPoint(x: point.x - insetAmount, y: point.y - insetAmount)
        return insetPoint
    }
    
    public func endingPoint(in rect: CGRect) -> CGPoint {
        
        let edge: BorderEdge = {
            switch corner {
            case .topLeading: return BorderEdge.top
            case .topTrailing: return BorderEdge.trailing
            case .bottomTrailing: return BorderEdge.bottom
            case .bottomLeading: return BorderEdge.leading
            }
        }()
        
        let point = edge.startingCorner(self).startingPoint(in: rect)
        let insetPoint = CGPoint(x: point.x - insetAmount, y: point.y - insetAmount)
        return insetPoint
    }
    
    public func arcCenterPoint(in rect: CGRect) -> CGPoint {
        // startPoint(in:) and endingPoint(in:) are already inset
        switch corner {
        case .topLeading: return CGPoint(x: endingPoint(in: rect).x, y: startingPoint(in: rect).y)
        case .topTrailing: return CGPoint(x: startingPoint(in: rect).x, y: endingPoint(in: rect).y)
        case .bottomTrailing: return CGPoint(x: endingPoint(in: rect).x, y: startingPoint(in: rect).y)
        case .bottomLeading: return CGPoint(x: startingPoint(in: rect).x, y: endingPoint(in: rect).y)
        }
    }
    
    // MARK: - Shape
    
    public func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: startingPoint(in: rect))
        self.path(&path, in: rect)
        //path.addRelativeArc(center: arcCenterPoint(in: rect), radius: radius - insetAmount, startAngle: startingAngle, delta: Angle.degrees(90))
        return path
    }
    
    public func path(_ path: inout Path, in rect: CGRect) {
        path.addRelativeArc(center: arcCenterPoint(in: rect), radius: radius - insetAmount, startAngle: startingAngle, delta: Angle.degrees(90))
    }
}

extension BorderEdge {
    fileprivate func startingCorner(_ corner: BorderCorner) -> BorderEdge {
        self.corners(corners: (startingCorner: corner, endingCorner: edge.endingCorner.borderCorner))
    }
    
    fileprivate func endingCorner(_ corner: BorderCorner) -> BorderEdge {
        self.corners(corners: (startingCorner: edge.startingCorner.borderCorner, endingCorner: corner))
    }
}
