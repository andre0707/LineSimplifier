# LineSimplifier

LineSimplifier is a small Swift Package to simplify lines.
A line is connecting multiple points and does not need to be straight.
In this package a line could also be called path or route.

**Limitations:** This package only works with 2 dimensional points.

Sometimes you have a lot of points describing the line, but they are not all needed, because a rough course of the line is good enough.
Using a lot of points in a line requires a lot of resources which is not always needed.
So a simplified version of the line is good enough


This Swift Package is inspired by the [original simplify in Java](https://github.com/mourner/simplify-js) and the [Swift translation](https://github.com/malcommac/SwiftSimplify). However, I felt like the swift version of it could use some improvements.  



## Example GPS tracks 

A real life example to use this package are gps tracks.
Depending on the data it might include a ton of data which is not really needed to simply draw the gps route on a map.
Especially when multiple routes are displayed, memory can become a problem when only the raw route data is used.
 
With LineSimplifier the route can be simplified and a lot of points will drop out which saves memory.



## Underlaying algorithm

LineSimplifier is based on the [Ramer–Douglas–Peucker algorithm](https://en.wikipedia.org/wiki/Ramer–Douglas–Peucker_algorithm).



# Using LineSimplifier

LineSimplifier comes with the `Point2DRepresentable` protocol. Just conform your type to this protocol to use the simplification algorithm.
After conforming to the protocol, just use the `LineSimplifier.simplify` function. Use the `tolerance` prameter to control the degree of simplification.
Use the `useHighestQuality` parameter to get the best quality. However, better quality requires more time to calculate the simplification.
If `useHighestQuality` is used, only the *Ramer–Douglas–Peucker algorithm* will be used. If `useHighestQuality` is set to false, a pre filtering with a radial distance is used to save some steps in *Ramer–Douglas–Peucker algorithm*.


LineSimplifier adds the `Point2DRepresentable` conformance to `CLLocationCoordinate2D` and `CGPoint` out of the box.
For other types, you need to implement th protocol yourself.


Here is a small example:


```swift
import CoreLocation
import LineSimplifier

let points: [CLLocationCoordinate2D] = ...
let result = LineSimplifier.simplify(points: points, withTolerance: 0.003)
let result2 = LineSimplifier.simplify(points: points, withTolerance: 0.003, useHighestQuality: true)
```


With the `Array` extension you can also use it just like this:

```swift
import CoreLocation
import LineSimplifier

let points: [CLLocationCoordinate2D] = ...
let result = points.simplify(withTolerance: 0.003)
let result2 = points.simplify(withTolerance: 0.003, useHighestQuality: true)
```



## Tolerance

The value of the tolerance heavyly depends on the points range. 

For GPS coordinates the tests resulted like so:

| Tolerance  | Resulting points |
| ---------- | ---------------- |
| 0.0001     |    107           |
| 0.00001    |    818           |
| 0.000001   |  3.575           |
| 0.0000001  | 10.088           |
| 0.00000001 | 12.798           |
| Original   | 13.395           |

The tolerance needs to be quite small, because it is in gps coordinates nature to only differ in decimal points for distances in meter range.
