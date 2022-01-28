//
//  CLLocationCoordinate2D+Point2DRepresentable.swift
//  
//
//  Created by Andre Albach on 28.01.22.
//

import CoreGraphics
import CoreLocation

/// Add `Point2DRepresentable` conformance to CLLocationCoordinate2D
extension CLLocationCoordinate2D: Point2DRepresentable {
    public typealias T = Double
    
    public var x: Double { latitude }
    
    public var y: Double { longitude }
    
    public var point: CGPoint { CGPoint(x: x, y: y) }
}
