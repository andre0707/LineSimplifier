//
//  Point2DRepresentable.swift
//  
//
//  Created by Andre Albach on 28.01.22.
//

import CoreGraphics

/// A protocol types can conform to to be used for the route/path simplification
public protocol Point2DRepresentable {
    associatedtype T: FloatingPoint
    
    /// The x value of self
    var x: T { get }
    /// The y value of self
    var y: T { get }
    /// Self as a point representation
    var point: CGPoint { get }
    /// The squared distance from self to `otherPoint`
    func sqDistance(from otherPoint: Self) -> T
    /// The squared distance from self to the segment going from `p1` to `p2`
    func sqdistanceToSegment(reachingFrom p1: Self, to p2: Self) -> T
    
    /// Equals function which compares self to `otherPoint`
    func equals(to otherPoint: Self) -> Bool
}

/// Add default implementations
public extension Point2DRepresentable {
    
    /// The squared distance from self to `otherPoint`
    /// - Parameter otherPoint: The other point to which the squared distance from `self` is calcualted to
    /// - Returns: The squared distance between `self` and `otherPoint`
    func sqDistance(from otherPoint: Self) -> T {
        let deltaX = x - otherPoint.x
        let deltaY = y - otherPoint.y
        
        return deltaX * deltaX + deltaY * deltaY
    }
    
    /// The squared distance from self to the segment going from `p1` to `p2`
    /// - Parameters:
    ///   - p1: Start point of the segment
    ///   - p2: End point of the segment
    /// - Returns: The squared distance from self to the segment
    func sqdistanceToSegment(reachingFrom p1: Self, to p2: Self) -> T {
        var dx = p2.x - p1.x
        var dy = p2.y - p1.y
        
        let x: T
        let y: T
        if !dx.isEqual(to: 0) || !dy.isEqual(to: 0) {
            let t = ((self.x - p1.x) * dx + (self.y - p1.y) * dy) / (dx * dx + dy * dy)
            if t > 1 {
                x = p2.x
                y = p2.y
            } else if t > 0 {
                x = p1.x + dx * t
                y = p1.y + dy * t
            } else {
                x = p1.x
                y = p1.y
            }
        } else {
            x = p1.x
            y = p1.y
        }
        
        dx = self.x - x
        dy = self.y - y
        
        return dx * dx + dy * dy
    }
    
    /// Compares `self` to `otherPoint` and checks for equalitiy
    /// - Parameter otherPoint: The point to which `self` is compared
    /// - Returns: True, if `self` is equal to `otherPoint`
    func equals(to otherPoint: Self) -> Bool {
        if !self.x.isEqual(to: otherPoint.x) { return false }
        return self.y.isEqual(to: otherPoint.y)
    }
}
