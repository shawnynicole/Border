//
//  Corner.swift
//  SwiftUIBorder
//
//  Created by DeShawn Jackson on 7/14/21.
//

import SwiftUI

public enum Corner: CaseIterable {
    
    case topLeading
    case topTrailing
    case bottomLeading
    case bottomTrailing
    
    // MARK: - Computed Properties
    
    public func cornerPoint(in rect: CGRect) -> CGPoint {
        switch self {
        case .topLeading: return CGPoint(x: rect.minX, y: rect.minY)
        case .topTrailing: return CGPoint(x: rect.maxX, y: rect.minY)
        case .bottomTrailing: return CGPoint(x: rect.maxX, y: rect.maxY)
        case .bottomLeading: return CGPoint(x: rect.minX, y: rect.maxY)
        }
    }
    
    public var startingAngle: Angle {
        switch self {
        case .topLeading: return Angle.degrees(180)
        case .topTrailing: return Angle.degrees(270)
        case .bottomTrailing: return Angle.degrees(0)
        case .bottomLeading: return Angle.degrees(90)
        }
    }
    
    public var borderCorner: BorderCorner {
        switch self {
        case .topLeading: return .topLeading
        case .topTrailing: return .topTrailing
        case .bottomTrailing: return .bottomTrailing
        case .bottomLeading: return .bottomLeading
        }
    }
}
