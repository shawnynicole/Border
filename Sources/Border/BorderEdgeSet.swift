//
//  BorderEdgeSet.swift
//  
//
//  Created by DeShawn Jackson on 7/14/21.
//

import SwiftUI

public struct BorderEdgeSet: ExpressibleByDictionaryLiteral {
    
    // MARK: - ExpressibleByDictionaryLiteral
    
    public init(dictionaryLiteral elements: (Edge, BorderEdge)...) {
        self.init([Edge: BorderEdge](uniqueKeysWithValues: elements))
    }
    
    // MARK: - Static
    
    public static var none: BorderEdgeSet {
        BorderEdgeSet([:])
    }
    
    public static func all(color: Color = .black, lineWidth: CGFloat = 1, dotted: Bool = false) -> BorderEdgeSet {
        
        let edges: [Edge: BorderEdge] = [
            .top: .top(color: color, lineWidth: lineWidth, dotted: dotted),
            .bottom: .bottom(color: color, lineWidth: lineWidth, dotted: dotted),
            .leading: .leading(color: color, lineWidth: lineWidth, dotted: dotted),
            .trailing: .trailing(color: color, lineWidth: lineWidth, dotted: dotted)
        ]
        
        return BorderEdgeSet(edges)
    }
    
    public static func top(color: Color = .black, lineWidth: CGFloat = 1, dotted: Bool = false) -> BorderEdgeSet {
        BorderEdgeSet([.top: .top(color: color, lineWidth: lineWidth, dotted: dotted)])
    }
    
    public static func bottom(color: Color = .black, lineWidth: CGFloat = 1, dotted: Bool = false) -> BorderEdgeSet {
        BorderEdgeSet([.bottom: .bottom(color: color, lineWidth: lineWidth, dotted: dotted)])
    }
    
    public static func leading(color: Color = .black, lineWidth: CGFloat = 1, dotted: Bool = false) -> BorderEdgeSet {
        BorderEdgeSet([.leading: .leading(color: color, lineWidth: lineWidth, dotted: dotted)])
    }
    
    public static func trailing(color: Color = .black, lineWidth: CGFloat = 1, dotted: Bool = false) -> BorderEdgeSet {
        BorderEdgeSet([.trailing: .trailing(color: color, lineWidth: lineWidth, dotted: dotted)])
    }
    
    // MARK: - Stored Properties
    
    public var edges: [Edge: BorderEdge]
    
    // MARK: - Init
    
    public init(_ edges: [Edge: BorderEdge]) {
        self.edges = edges
    }
    
    // MARK: - Local
    
    public subscript(_ edge: Edge) -> BorderEdge? {
        get { edges[edge] }
        set { edges[edge] = newValue }
    }
    
    public func contains(_ edge: Edge) -> Bool {
        edges.contains(where: { $0.key == edge })
    }
    
    public func top(color: Color? = nil, lineWidth: CGFloat? = nil, dotted: Bool? = nil) -> BorderEdgeSet {
        var edges = self.edges
        let current = edges[.top]
        let color: Color = (color ?? current?.color) ?? .black
        let lineWidth: CGFloat = (lineWidth ?? current?.lineWidth) ?? 1
        let dotted: Bool = (dotted ?? current?.dotted) ?? false
        edges[.top] = .top(color: color, lineWidth: lineWidth, dotted: dotted)
        return BorderEdgeSet(edges)
    }
    
    public func bottom(color: Color? = nil, lineWidth: CGFloat? = nil, dotted: Bool? = nil) -> BorderEdgeSet {
        var edges = self.edges
        let current = edges[.bottom]
        let color: Color = (color ?? current?.color) ?? .black
        let lineWidth: CGFloat = (lineWidth ?? current?.lineWidth) ?? 1
        let dotted: Bool = (dotted ?? current?.dotted) ?? false
        edges[.bottom] = .bottom(color: color, lineWidth: lineWidth, dotted: dotted)
        return BorderEdgeSet(edges)
    }
    
    public func leading(color: Color? = nil, lineWidth: CGFloat? = nil, dotted: Bool? = nil) -> BorderEdgeSet {
        var edges = self.edges
        let current = edges[.leading]
        let color: Color = (color ?? current?.color) ?? .black
        let lineWidth: CGFloat = (lineWidth ?? current?.lineWidth) ?? 1
        let dotted: Bool = (dotted ?? current?.dotted) ?? false
        edges[.leading] = .leading(color: color, lineWidth: lineWidth, dotted: dotted)
        return BorderEdgeSet(edges)
    }
    
    public func trailing(color: Color? = nil, lineWidth: CGFloat? = nil, dotted: Bool? = nil) -> BorderEdgeSet {
        var edges = self.edges
        let current = edges[.trailing]
        let color: Color = (color ?? current?.color) ?? .black
        let lineWidth: CGFloat = (lineWidth ?? current?.lineWidth) ?? 1
        let dotted: Bool = (dotted ?? current?.dotted) ?? false
        edges[.trailing] = .trailing(color: color, lineWidth: lineWidth, dotted: dotted)
        return BorderEdgeSet(edges)
    }
}
