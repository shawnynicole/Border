//
//  Edge+.swift
//  SwiftUIBorder
//
//  Created by DeShawn Jackson on 7/14/21.
//

import SwiftUI

extension Edge {
    
    // MARK: - Computed Properties
    
    public var startingCorner: Corner {
        switch self {
        case .top: return Corner.topLeading
        case .trailing: return Corner.topTrailing
        case .bottom: return Corner.bottomTrailing
        case .leading: return Corner.bottomLeading
        }
    }
    
    public var endingCorner: Corner {
        switch self {
        case .top: return Corner.topTrailing
        case .trailing: return Corner.bottomTrailing
        case .bottom: return Corner.bottomLeading
        case .leading: return Corner.topLeading
        }
    }
    
    // MARK: - Computed Methods
    
    public func startingPoint(in rect: CGRect) -> CGPoint {
        startingCorner.cornerPoint(in: rect)
    }
    
    public func endingPoint(in rect: CGRect) -> CGPoint {
        endingCorner.cornerPoint(in: rect)
    }
}
