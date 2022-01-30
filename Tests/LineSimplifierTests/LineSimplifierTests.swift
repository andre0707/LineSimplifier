import CoreLocation
import XCTest
@testable import LineSimplifier

/// Simple tests for line simplification
final class LineSimplifierTests: XCTestCase {
    
    
    /// A simple test with a couple hard coded location points
    func test_LineSimplifcation() throws {
        
        let points: [CLLocationCoordinate2D] = [
            CLLocationCoordinate2D(latitude: 50.124, longitude: 8.345),
            CLLocationCoordinate2D(latitude: 50.125, longitude: 8.346),
            CLLocationCoordinate2D(latitude: 50.125, longitude: 8.347),
            CLLocationCoordinate2D(latitude: 50.126, longitude: 8.347),
            CLLocationCoordinate2D(latitude: 50.127, longitude: 8.347),
            CLLocationCoordinate2D(latitude: 50.128, longitude: 8.350),
            CLLocationCoordinate2D(latitude: 50.128, longitude: 8.351),
            CLLocationCoordinate2D(latitude: 50.128, longitude: 8.352),
            CLLocationCoordinate2D(latitude: 50.129, longitude: 8.352),
            CLLocationCoordinate2D(latitude: 50.129, longitude: 8.353),
        ]
        XCTAssertEqual(points.count, 10)
     
        XCTAssertEqual(points.simplify(withTolerance: 0.001).count, 3)
        XCTAssertEqual(points.simplify(withTolerance: 0.001, useHighestQuality: true).count, 4)
        
        XCTAssertEqual(points.simplify(withTolerance: 0.0001).count, 8)
        XCTAssertEqual(points.simplify(withTolerance: 0.0001, useHighestQuality: true).count, 8)
        
        XCTAssertEqual(points.simplify(withTolerance: 1, useHighestQuality: true).count, 2)
    }
    
    
    /// A line simplification of an actual hiking route
    func test_LineSimplificationHikingExample() throws {
        let url = try XCTUnwrap(Bundle.module.url(forResource: "MyResources/track", withExtension: "gpx"))
        
        let gpxParser = try XCTUnwrap(GPXTrackParser(url: url))
        
        let originalPoints = gpxParser.parsedPoints
        XCTAssertEqual(originalPoints.count, 13395)
        
        XCTAssertEqual(originalPoints.simplify(withTolerance: 0.0001).count, 107)
        XCTAssertEqual(originalPoints.simplify(withTolerance: 0.00001).count, 818)
        XCTAssertEqual(originalPoints.simplify(withTolerance: 0.000001).count, 3575)
        XCTAssertEqual(originalPoints.simplify(withTolerance: 0.0000001).count, 10088)
        XCTAssertEqual(originalPoints.simplify(withTolerance: 0.00000001).count, 12798)
        
        XCTAssertEqual(originalPoints.simplify(withTolerance: 0.0001, useHighestQuality: true).count, 118)
        XCTAssertEqual(originalPoints.simplify(withTolerance: 0.00001, useHighestQuality: true).count, 839)
        XCTAssertEqual(originalPoints.simplify(withTolerance: 0.000001, useHighestQuality: true).count, 3565)
        XCTAssertEqual(originalPoints.simplify(withTolerance: 0.0000001, useHighestQuality: true).count, 10087)
        XCTAssertEqual(originalPoints.simplify(withTolerance: 0.00000001, useHighestQuality: true).count, 12798)
    }
}
