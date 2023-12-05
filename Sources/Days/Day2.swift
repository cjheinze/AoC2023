import Foundation
import Helper

public class Day2: DayProtocol {
    private let input: String
    private let rows: [String]
    
    struct Game {
        let id: Int
        let sets: [[String: Int]]
        
        public func isValid(limits: [String: Int]) -> Bool {
            sets.allSatisfy { roll in
                roll.allSatisfy { (key: String, value: Int) in
                    value <= limits[key, default: Int.max]
                }
            }
        }
        
        public func minimumSet() -> [String: Int] {
            return sets.reduce(into: [String: Int]()) { minimum, set in
                set.forEach { (color, quantity) in
                    if minimum[color] == nil {
                        minimum[color] = quantity
                    } else if let existing = minimum[color], existing < quantity {
                        minimum[color] = quantity
                    }
                }
            }
        }
    }
    
    private var games: [Game]
    
    public init() {
        input = FileHandler.getInputs(for: Bundle.module.resourcePath!, andDay: 2)
        rows = input.split(separator: "\n").map(String.init)
        print(input)
        let gameSearch = #/Game (\d+)/#
        
        games = rows.map { row in
            let gameAndSets = row.split(separator: ": ")
            let gameMatch = try! gameSearch.wholeMatch(in: gameAndSets[0])!
            let gameId = Int(gameMatch.1)!
            let sets: [[String: Int]] = gameAndSets[1].split(separator: "; ").map({ set in
                let cubes = set.split(separator: ", ")
                return cubes.reduce(into: [:]) { map, cube in
                    let quantity = cube.split(separator: " ")[0]
                    let color = String(cube.split(separator: " ")[1])
                    map[color] = Int(quantity)!
                }
            })
            return Game(id: gameId, sets: sets)
        }
    }

    public func partOne() -> String {
        let limits = [ "red": 12,
                       "green": 13,
                       "blue": 14 ]
        let validGames = games.filter({ $0.isValid(limits: limits )})
        return String(validGames.reduce(0, { $0 + $1.id }))
    }
    

    public func partTwo() -> String {
        let minimumSetPowers = games.map({ $0.minimumSet().values.reduce(1, *) })
        return String(minimumSetPowers.reduce(0, +))
    }
    
}
