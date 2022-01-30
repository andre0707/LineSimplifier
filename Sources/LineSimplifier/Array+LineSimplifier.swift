//
//  Array+LineSimplifier.swift
//  
//
//  Created by Andre Albach on 28.01.22.
//

import Foundation

public extension Array where Element: Point2DRepresentable {
    
    /// This function will simplify self.
    /// Simplifying means if self describes points which build a line, some of the points will be dropped.
    /// The resulting points will form a new line which approximatly runs the same as the line through the original points
    /// - Parameters:
    ///   - tolerance: The tolerance to use
    ///   - useHighestQuality: Indicator, if the highest quality for the calculations should be used. If yes, it takes quite some time extra.
    /// - Returns: The resulting points which build the simplified line
    func simplify(withTolerance tolerance: Element.T, useHighestQuality: Bool = false) -> Self {
        LineSimplifier.simplify(points: self, withTolerance: tolerance, useHighestQuality: useHighestQuality)
    }
}
