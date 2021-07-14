//
//  BorderProperty.swift
//  SwiftUIBorder
//
//  Created by DeShawn Jackson on 7/14/21.
//

import SwiftUI

internal protocol BorderProperty: InsettableShape {
    var color: Color { get }
    var lineWidth: CGFloat { get }
    var dotted: Bool { get }
    
    func path(_ path: inout Path, in rect: CGRect)
    
    // MARK: - InsettableShape
    var insetAmount: CGFloat { get set }
}

extension BorderProperty {
    
    public var strokeStyle: StrokeStyle {
        // TODO: miterLimit???
        StrokeStyle(lineWidth: lineWidth, lineCap: .square, lineJoin: .miter, dash: dotted ? [(lineWidth * 5) / 3] : [])
    }
    
    public func paint() -> some View {
        stroke(color, style: strokeStyle)
    }
    
    public func paintBorder() -> some View {
        strokeBorder(color, style: strokeStyle)
    }
    
    public var body: some View {
        paint()
    }
    
    // MARK: - InsettableShape
    public func inset(by amount: CGFloat) -> some InsettableShape {
        var insettableShape = self
        insettableShape.insetAmount += amount
        return insettableShape
    }
}
