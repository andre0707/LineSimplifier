//
//  CGPoint+Point2DRepresentable.swift
//  
//
//  Created by Andre Albach on 28.01.22.
//

import CoreGraphics

/// Add `Point2DRepresentable` conformance to CGPoint
extension CGPoint: Point2DRepresentable {
    public var point: CGPoint { self }
}
