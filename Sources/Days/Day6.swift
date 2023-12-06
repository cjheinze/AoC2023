import Foundation
import Helper
import Algorithms
public class Day6: DayProtocol {
    private let input: String
    
    let races: [(time: Int, distance: Int)]
    
    public init() {
        input = FileHandler.getInputs(for: Bundle.module.resourcePath!, andDay: 6)
        print(input)
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
    
    public func partOne() -> String {
        let distancesPerRace = races.map(validDistances)
        return String(distancesPerRace.map(\.count).reduce(1, *))
    }
    
    public func partTwo() -> String {
        let time = Int(races.map(\.time).map(String.init).reduce("", +))!
        let distance = Int(races.map(\.distance).map(String.init).reduce("", +))!
        let distances = validDistances(time, distance)
        return String(distances.count)
    }
}
