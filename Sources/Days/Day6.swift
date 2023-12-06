import Foundation
import Helper
import Algorithms
public class Day6: DayProtocol {
    private let input: String
    
    let races: [(time: Int, distance: Int)]
    
    public init() {
        input = FileHandler.getInputs(for: Bundle.module.resourcePath!, andDay: 6)
        let timeAndDistance = input.split(separator: "\n").map { $0.split(separator: " ").dropFirst() }
        races = zip(timeAndDistance[0], timeAndDistance[1]).map { time, distance in
            (Int(time)!, Int(distance)!)
        }
    }

    
    fileprivate func validDistances(_ time: Int, _ distance: Int) -> [Int] {
        return (0..<time).map { speed in
            speed * (time - speed)
        }.filter({ $0 > distance })
    }
    
    fileprivate func validDistancesWithMath(_ time: Int, _ distance: Int) -> Int {
        // x = (-b ± sqrt(b^2 - 4ac))/2a where ax^2 + bx + c = 0
        // (time - speed) * speed - distance = 0
        // -1 * speed^2 + time*speed - distance = 0
        // speed^2 - time*speed + distance = 0
        // speed = time ± sqrt(time*time - (4 * distance)/2
        let sqrt = sqrt(Double(time*time - 4 * distance))
        let minSpeed = (Double(time) - sqrt) / 2
        let maxSpeed = (Double(time) + sqrt) / 2
        
        return Int(ceil(maxSpeed) - floor(minSpeed + 1))
    }
    
    public func partOne() -> String {
//        let distancesPerRace = races.map(validDistances)
        let distancesPerRace = races.map(validDistancesWithMath)
        return String(distancesPerRace.reduce(1, *))
    }
    
    public func partTwo() -> String {
        let time = Int(races.map(\.time).map(String.init).reduce("", +))!
        let distance = Int(races.map(\.distance).map(String.init).reduce("", +))!
//        let distances = validDistances(time, distance)
        let distances = validDistancesWithMath(time, distance)
        return String(distances)
    }
}
