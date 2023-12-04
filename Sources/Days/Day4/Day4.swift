import Foundation
import Helper

public class Day4: DayProtocol {
    
    struct Card {
        let cardId: Int
        let scratched: [Int]
        let winning: [Int]
        
        var matches: Int {
            Set(winning).intersection(scratched).count
        }
        
        var points: Int {
            1 << (matches - 1)
        }
    }
    
    private let input: String
    private let rows: [String]
    let cards: [Card]
    
    public init() {
        input = FileHandler.getInputs(for: Bundle.module.resourcePath!, andDay: 4)
        rows = input.split(separator: "\n").map(String.init)
        let cardIdSearch = #/Card\s+(\d+): /#
        cards = rows.map { row in
            let result = try! cardIdSearch.firstMatch(in: row)!
            let cardId = Int(result.1)!
            let range = row.firstRange(of: #/Card\s+(\d+): /#)
            let numbers = row[range!.upperBound..<row.endIndex].split(separator: " | ")
            let scratched = numbers[0].split(separator: " ").compactMap({ Int($0) })
            let winning = numbers[1].split(separator: " ").compactMap({ Int($0) })
            return Card(cardId: cardId, scratched: scratched, winning: winning)
        }
    }
    
    public func partOne() -> String {
        let winningPoints: [Int] = cards.map(\.points)
        
        return String(winningPoints.reduce(0, +))
    }
    
    public func partTwo() -> String {
    
        var cardMatches = Array(repeating: 1, count: cards.count)
        
        cards.enumerated().forEach { index, card in
            for i in (index + 1)..<index + 1 + card.matches {
                cardMatches[i] += cardMatches[index]
            }
        }
        
        return String(cardMatches.reduce(0, +))
    }
    
}
