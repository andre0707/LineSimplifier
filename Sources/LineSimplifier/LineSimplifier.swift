//
//  LineSimplifier.swift
//
//
//  Created by Andre Albach on 28.01.22.
//

import Foundation

/// Line simplifier functionalities
public enum LineSimplifier {
    
    /// This function will simplify the passed in points.
    /// Simplifying means if self describes points which build a line, some of the points will be dropped.
    /// The resulting points will form a new line which approximatly runs the same as the line through the original points
    /// - Parameters:
    ///   - points: The points which should be simplified
    ///   - tolerance: The tolerance to use
    ///   - useHighestQuality: Indicator, if the highest quality for the calculations should be used. If yes, it takes quite some time extra.
    /// - Returns: The resulting points which build the simplified line
    public static func simplify<T: Point2DRepresentable>(points: [T], withTolerance tolerance: T.T, useHighestQuality: Bool = false) -> [T] {
        /// There is nothing to simplify if we do not at least have 3 points
        guard points.count > 2 else { return points }
        
        let sqTolerance = tolerance * tolerance
        var result = useHighestQuality ? points : simplifyRadialDistance(points: points, withSquaredTolerance: sqTolerance)
        result = simplifyDouglasPeucker(points: result, with: sqTolerance)
        
        return result
        
    }
    
    
    /// A simple radial distance
    private static func simplifyRadialDistance<T: Point2DRepresentable>(points: [T], withSquaredTolerance squaredTolerance: T.T) -> [T] {
        guard points.count > 2 else { return points }
        
        var previousPoint = points[0]
        var newPoints = [previousPoint]
        var currentPoint: T!
        
        for i in 1 ..< points.count {
            currentPoint = points[i]
            if currentPoint.sqDistance(from: previousPoint) > squaredTolerance {
                newPoints.append(currentPoint)
                previousPoint = currentPoint
            }
        }
        
        if !previousPoint.equals(to: currentPoint) {
            newPoints.append(currentPoint)
        }
        
        return newPoints
    }
    
    /// The Douglas Peucker algorithm to simplify a line
    private static func simplifyDouglasPeucker<T: Point2DRepresentable>(points: [T], with sqTolerance: T.T) -> [T] {
        guard points.count > 1 else { return [] }
        
        
        /// This function reflects a single step and is called recursive.
        func simplifyDPStep<T: Point2DRepresentable>(points: [T], first: Int, last: Int, sqTolerance: T.T, simplified: inout [T]) {
            guard last > first else { return }
            var maxSqDistance = sqTolerance
            var index = 0
            
            for currentIndex in first+1..<last {
                let sqDistance = points[currentIndex].sqDistanceToSegment(reachingFrom: points[first], to: points[last])
                if sqDistance > maxSqDistance {
                    maxSqDistance = sqDistance
                    index = currentIndex
                }
            }
            
            if maxSqDistance > sqTolerance {
                if (index - first) > 1 {
                    simplifyDPStep(points: points, first: first, last: index, sqTolerance: sqTolerance, simplified: &simplified)
                }
                simplified.append(points[index])
                if (last - index) > 1 {
                    simplifyDPStep(points: points, first: index, last: last, sqTolerance: sqTolerance, simplified: &simplified)
                }
            }
        }
        
        
        let indexLastPoint = points.count - 1
        var simplied = [points.first!]
        simplifyDPStep(points: points, first: 0, last: indexLastPoint, sqTolerance: sqTolerance, simplified: &simplied)
        simplied.append(points.last!)
        
        return simplied
    }
}
