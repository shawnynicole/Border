//
//  BorderCornerSet.swift
//
//
//  Created by DeShawn Jackson on 7/14/21.
//

import SwiftUI

public struct BorderCornerSet: ExpressibleByDictionaryLiteral {
   
    // MARK: - ExpressibleByDictionaryLiteral
    
    public init(dictionaryLiteral elements: (Corner, BorderCorner)...) {
        self.init([Corner: BorderCorner](uniqueKeysWithValues: elements))
    }
    
    // MARK: - Static
    
    public static var none: BorderCornerSet {
        BorderCornerSet([:])
    }
    
    public static func all(radius: CGFloat = 0, color: Color = .black, lineWidth: CGFloat = 1, dotted: Bool = false) -> BorderCornerSet {
        
        let corners: [Corner: BorderCorner] = [
            .topLeading: .topLeading(radius: radius, color: color, lineWidth: lineWidth, dotted: dotted),
            .topTrailing: .topTrailing(radius: radius, color: color, lineWidth: lineWidth, dotted: dotted),
            .bottomTrailing: .bottomTrailing(radius: radius, color: color, lineWidth: lineWidth, dotted: dotted),
            .bottomLeading: .bottomLeading(radius: radius, color: color, lineWidth: lineWidth, dotted: dotted)
        ]
        
        return BorderCornerSet(corners)
    }
    
    public static func topLeading(radius: CGFloat = 0, color: Color = .black, lineWidth: CGFloat = 1, dotted: Bool = false) -> BorderCornerSet {
        BorderCornerSet([.topLeading: .topLeading(radius: radius, color: color, lineWidth: lineWidth, dotted: dotted)])
    }
    
    public static func topTrailing(radius: CGFloat = 0, color: Color = .black, lineWidth: CGFloat = 1, dotted: Bool = false) -> BorderCornerSet {
        BorderCornerSet([.topTrailing: .topTrailing(radius: radius, color: color, lineWidth: lineWidth, dotted: dotted)])
    }
    
    public static func bottomTrailing(radius: CGFloat = 0, color: Color = .black, lineWidth: CGFloat = 1, dotted: Bool = false) -> BorderCornerSet {
        BorderCornerSet([.bottomTrailing: .bottomTrailing(radius: radius, color: color, lineWidth: lineWidth, dotted: dotted)])
    }
    
    public static func bottomLeading(radius: CGFloat = 0, color: Color = .black, lineWidth: CGFloat = 1, dotted: Bool = false) -> BorderCornerSet {
        BorderCornerSet([.bottomLeading: .bottomLeading(radius: radius, color: color, lineWidth: lineWidth, dotted: dotted)])
    }
    
    public static func top(radius: CGFloat = 0, color: Color = .black, lineWidth: CGFloat = 1, dotted: Bool = false) -> BorderCornerSet {
        BorderCornerSet([
            .topLeading: .topLeading(radius: radius, color: color, lineWidth: lineWidth, dotted: dotted),
            .topTrailing: .topTrailing(radius: radius, color: color, lineWidth: lineWidth, dotted: dotted)
        ])
    }
    
    public static func trailing(radius: CGFloat = 0, color: Color = .black, lineWidth: CGFloat = 1, dotted: Bool = false) -> BorderCornerSet {
        BorderCornerSet([
            .topTrailing: .topTrailing(radius: radius, color: color, lineWidth: lineWidth, dotted: dotted),
            .bottomTrailing: .bottomTrailing(radius: radius, color: color, lineWidth: lineWidth, dotted: dotted)
        ])
    }
    
    public static func bottom(radius: CGFloat = 0, color: Color = .black, lineWidth: CGFloat = 1, dotted: Bool = false) -> BorderCornerSet {
        BorderCornerSet([
            .bottomLeading: .bottomLeading(radius: radius, color: color, lineWidth: lineWidth, dotted: dotted),
            .bottomTrailing: .bottomTrailing(radius: radius, color: color, lineWidth: lineWidth, dotted: dotted)
        ])
    }
    
    public static func leading(radius: CGFloat = 0, color: Color = .black, lineWidth: CGFloat = 1, dotted: Bool = false) -> BorderCornerSet {
        BorderCornerSet([
            .topLeading: .topLeading(radius: radius, color: color, lineWidth: lineWidth, dotted: dotted),
            .bottomLeading: .bottomLeading(radius: radius, color: color, lineWidth: lineWidth, dotted: dotted)
        ])
    }
    
    // MARK: - Stored Properties
    
    public var corners: [Corner: BorderCorner]
    
    // MARK: - Init
    
    public init(_ corners: [Corner: BorderCorner]) {
        self.corners = corners
    }
    
    // MARK: - Local
    
    public subscript(_ corner: Corner) -> BorderCorner? {
        get { corners[corner] }
        set { corners[corner] = newValue }
    }
    
    public func contains(_ corner: Corner) -> Bool {
        corners.contains(where: { $0.key == corner })
    }
    
    public func topLeading(radius: CGFloat? = nil, color: Color? = nil, lineWidth: CGFloat? = nil, dotted: Bool? = nil) -> BorderCornerSet {
        var corners = self.corners
        let current = corners[.topLeading]
        let radius: CGFloat = (radius ?? current?.radius) ?? 0
        let color: Color = (color ?? current?.color) ?? .black
        let lineWidth: CGFloat = (lineWidth ?? current?.lineWidth) ?? 1
        let dotted: Bool = (dotted ?? current?.dotted) ?? false
        corners[.topLeading] = .topLeading(radius: radius, color: color, lineWidth: lineWidth, dotted: dotted)
        return BorderCornerSet(corners)
    }
    
    public func topTrailing(radius: CGFloat? = nil, color: Color? = nil, lineWidth: CGFloat? = nil, dotted: Bool? = nil) -> BorderCornerSet {
        var corners = self.corners
        let current = corners[.topTrailing]
        let radius: CGFloat = (radius ?? current?.radius) ?? 0
        let color: Color = (color ?? current?.color) ?? .black
        let lineWidth: CGFloat = (lineWidth ?? current?.lineWidth) ?? 1
        let dotted: Bool = (dotted ?? current?.dotted) ?? false
        corners[.topTrailing] = .topTrailing(radius: radius, color: color, lineWidth: lineWidth, dotted: dotted)
        return BorderCornerSet(corners)
    }
    
    public func bottomTrailing(radius: CGFloat? = nil, color: Color? = nil, lineWidth: CGFloat? = nil, dotted: Bool? = nil) -> BorderCornerSet {
        var corners = self.corners
        let current = corners[.bottomTrailing]
        let radius: CGFloat = (radius ?? current?.radius) ?? 0
        let color: Color = (color ?? current?.color) ?? .black
        let lineWidth: CGFloat = (lineWidth ?? current?.lineWidth) ?? 1
        let dotted: Bool = (dotted ?? current?.dotted) ?? false
        corners[.bottomTrailing] = .bottomTrailing(radius: radius, color: color, lineWidth: lineWidth, dotted: dotted)
        return BorderCornerSet(corners)
    }
    
    public func bottomLeading(radius: CGFloat? = nil, color: Color? = nil, lineWidth: CGFloat? = nil, dotted: Bool? = nil) -> BorderCornerSet {
        var corners = self.corners
        let current = corners[.bottomLeading]
        let radius: CGFloat = (radius ?? current?.radius) ?? 0
        let color: Color = (color ?? current?.color) ?? .black
        let lineWidth: CGFloat = (lineWidth ?? current?.lineWidth) ?? 1
        let dotted: Bool = (dotted ?? current?.dotted) ?? false
        corners[.bottomLeading] = .bottomLeading(radius: radius, color: color, lineWidth: lineWidth, dotted: dotted)
        return BorderCornerSet(corners)
    }
    
    public func top(radius: CGFloat? = nil, color: Color? = nil, lineWidth: CGFloat? = nil, dotted: Bool? = nil) -> BorderCornerSet {
        var corners = self.corners
        let current = corners[.topLeading]
        let radius: CGFloat = (radius ?? current?.radius) ?? 0
        let color: Color = (color ?? current?.color) ?? .black
        let lineWidth: CGFloat = (lineWidth ?? current?.lineWidth) ?? 1
        let dotted: Bool = (dotted ?? current?.dotted) ?? false
        corners[.topLeading] = .topLeading(radius: radius, color: color, lineWidth: lineWidth, dotted: dotted)
        corners[.topTrailing] = .topTrailing(radius: radius, color: color, lineWidth: lineWidth, dotted: dotted)
        return BorderCornerSet(corners)
    }
    
    public func trailing(radius: CGFloat? = nil, color: Color? = nil, lineWidth: CGFloat? = nil, dotted: Bool? = nil) -> BorderCornerSet {
        var corners = self.corners
        let current = corners[.topTrailing]
        let radius: CGFloat = (radius ?? current?.radius) ?? 0
        let color: Color = (color ?? current?.color) ?? .black
        let lineWidth: CGFloat = (lineWidth ?? current?.lineWidth) ?? 1
        let dotted: Bool = (dotted ?? current?.dotted) ?? false
        corners[.topTrailing] = .topTrailing(radius: radius, color: color, lineWidth: lineWidth, dotted: dotted)
        corners[.bottomTrailing] = .bottomTrailing(radius: radius, color: color, lineWidth: lineWidth, dotted: dotted)
        return BorderCornerSet(corners)
    }
    
    public func bottom(radius: CGFloat? = nil, color: Color? = nil, lineWidth: CGFloat? = nil, dotted: Bool? = nil) -> BorderCornerSet {
        var corners = self.corners
        let current = corners[.bottomTrailing]
        let radius: CGFloat = (radius ?? current?.radius) ?? 0
        let color: Color = (color ?? current?.color) ?? .black
        let lineWidth: CGFloat = (lineWidth ?? current?.lineWidth) ?? 1
        let dotted: Bool = (dotted ?? current?.dotted) ?? false
        corners[.bottomLeading] = .bottomLeading(radius: radius, color: color, lineWidth: lineWidth, dotted: dotted)
        corners[.bottomTrailing] = .bottomTrailing(radius: radius, color: color, lineWidth: lineWidth, dotted: dotted)
        return BorderCornerSet(corners)
    }
    
    public func leading(radius: CGFloat? = nil, color: Color? = nil, lineWidth: CGFloat? = nil, dotted: Bool? = nil) -> BorderCornerSet {
        var corners = self.corners
        let current = corners[.bottomLeading]
        let radius: CGFloat = (radius ?? current?.radius) ?? 0
        let color: Color = (color ?? current?.color) ?? .black
        let lineWidth: CGFloat = (lineWidth ?? current?.lineWidth) ?? 1
        let dotted: Bool = (dotted ?? current?.dotted) ?? false
        corners[.topLeading] = .topLeading(radius: radius, color: color, lineWidth: lineWidth, dotted: dotted)
        corners[.bottomLeading] = .bottomLeading(radius: radius, color: color, lineWidth: lineWidth, dotted: dotted)
        return BorderCornerSet(corners)
    }
}
