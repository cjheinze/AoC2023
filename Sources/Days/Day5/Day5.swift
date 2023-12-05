import Foundation
import Helper
import Algorithms
public class Day5: DayProtocol {
    private let input: String

    struct AlmanacMap {
        struct Range {
            let destination: Int
            let source: Int
            let length: Int
            
            func contains(_ value: Int) -> Bool {
                value >= source && value < (source + length)
            }
        }
        
        let name: String
        let map: [Range]
    }
    
    let seeds: [Int]
    let maps: [AlmanacMap]
    
    public init() {
        input = FileHandler.getInputs(for: Bundle.module.resourcePath!, andDay: 5)
        let groups = input.split(separator: "\n\n").map(String.init)
        print(groups)
        seeds = groups[0].split(separator: " ").dropFirst().map { Int($0)! }
        let titleRegex = #/(?<source>\w+?)-to-(?<destination>\w+) map:/#
        let mapRegex = #/(?<destinationStart>\d+?) (?<sourceStart>\d+) (?<rangeLength>\d+)/#
        maps = groups.dropFirst().map { mapString in
            let rows = mapString.split(separator: "\n")
            let mapSearch = try! titleRegex.wholeMatch(in: rows[0])!
            let source = mapSearch.source
            let destination = mapSearch.destination
            let map = rows.dropFirst().map { row in
                let values = try! mapRegex.wholeMatch(in: row)!
                let destinationStart = Int(values.destinationStart)!
                let sourceStart = Int(values.sourceStart)!
                let rangeLength = Int(values.rangeLength)!

                return AlmanacMap.Range(destination: destinationStart, source: sourceStart, length: rangeLength)
            }
            return AlmanacMap(name: String(source), map: map)
        }

        print(maps)
    }

    fileprivate func locationForSeed(_ seed: Int) -> Int? {
        var value = seed
        maps.forEach { map in
            if let range = map.map.first(where: { $0.contains(value) }) {
                value = value - range.source + range.destination
            }
        }
        return value
    }
    
    public func partOne() -> String {

        let locations: [Int] = seeds.compactMap { seed in
            return locationForSeed(seed)
        }
        return String(locations.min()!)
    }
    
    public func partTwo() -> String {
        let seedRanges = seeds.chunks(ofCount: 2).map { $0.first!..<($0.first! + $0.last!) }
        let locations: [Int] = seedRanges.flatMap { seedRange in
            seedRange.compactMap { seed in
                locationForSeed(seed)
            }
        }
        return String(locations.min()!)
    }
    

}
