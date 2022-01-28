//
//  GPXTrackParser.swift
//  
//
//  Created by Andre Albach on 28.01.22.
//

import CoreLocation

/// A simple gpx track parser
class GPXTrackParser: NSObject, XMLParserDelegate {
    
    /// The parsed points of the track
    var parsedPoints: [CLLocationCoordinate2D] = []
    
    
    /// Initialisation with a URL to a gps track file
    init?(url: URL) {
        super.init()
        guard let parser = XMLParser(contentsOf: url) else { return nil }
        
        parser.delegate = self
        parser.parse()
    }
    
    /// Parsing of the track point elements. Thats all we need here, elevation is not relevant.
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        guard elementName == "trkpt" else { return }
        
        guard let raw_latitude = attributeDict["lat"],
              let latitude = Double(raw_latitude),
              let raw_longitude = attributeDict["lon"],
              let longitude = Double(raw_longitude)
        else { return }
        
        parsedPoints.append(CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
    }
}
