import Foundation
import Helper
import Algorithms

public class Day7: DayProtocol {
    private let input: String
    private let handsAndBids: [String: Int]
    
    let cardValue: [String.Element: Int] = [
        "2" : 2,
        "3" : 3,
        "4" : 4,
        "5" : 5,
        "6" : 6,
        "7" : 7,
        "8" : 8,
        "9" : 9,
        "T" : 10,
        "J" : 11,
        "Q" : 12,
        "K" : 13,
        "A" : 14,
    ]
    
    let cardValuePartTwo: [String.Element: Int] = [
        "J" : 1,
        "2" : 2,
        "3" : 3,
        "4" : 4,
        "5" : 5,
        "6" : 6,
        "7" : 7,
        "8" : 8,
        "9" : 9,
        "T" : 10,
        "Q" : 12,
        "K" : 13,
        "A" : 14,
    ]
    
    enum HandType: Int, Comparable {
        case highCard = 0
        case pair
        case twoPair
        case threeKind
        case fullHouse
        case fourKind
        case fiveKind
        
        static func < (lhs: Day7.HandType, rhs: Day7.HandType) -> Bool {
            lhs.rawValue < rhs.rawValue
        }
    }
        
    public init() {
        input = FileHandler.getInputs(for: Bundle.module.resourcePath!, andDay: 7)
        handsAndBids = input.split(separator: "\n").reduce(into: [String: Int](), { partialResult, handAndBid in
            partialResult[String(handAndBid.split(separator: " ")[0])] = Int(handAndBid.split(separator: " ")[1])!
        })
        
    }
    
    private func extractHand(_ partialResult: inout [Character: Int], _ char: Character) {
        partialResult[char] = 1 + (partialResult[char] ?? 0)
    }
    
    private func getHandType(hand: [Character: Int]) -> HandType {
        switch hand.keys.count {
        case 1:
            return .fiveKind
        case 2:
            return hand.values.contains(4) ? .fourKind : .fullHouse
        case 3:
            return hand.values.contains(3) ? .threeKind : .twoPair
        case 4:
            return hand.values.contains(2) ? .pair : .highCard
        case 5:
            return .highCard
        default:
            fatalError("Should not happen")
        }
    }
    
    private func getHandTypePartTwo(hand: [Character: Int]) -> HandType {
        
        if hand["J", default: 0] == 0 {
            return getHandType(hand: hand)
        }
        
        switch hand.keys.count {
        case 1:
            return .fiveKind
        case 2:
            return hand.values.contains(4) ? .fiveKind : (hand["J"] == 3 || hand["J"] == 2) ? .fiveKind : .fullHouse
        case 3:
            return hand.values.contains(3) ? (hand["J"] == 1 || hand["J"] == 3 ? .fourKind : .threeKind) : (hand["J"] == 2 ? .fourKind : .fullHouse)
        case 4:
            return .threeKind
        case 5:
            return .pair
        default:
            fatalError("Should not happen")
        }
    }
    
    fileprivate func sortHands(cardValueMap: [String.Element: Int], handTypeRetriever: (_ hand: [Character: Int]) -> HandType) -> [(key: String, value: Int)] {
        return handsAndBids.sorted { lhs, rhs in
            let (deal1, deal2) = (lhs.key, rhs.key)
            let deal1Counted = deal1.reduce(into: [Character: Int](), extractHand(_:_:))
            let deal2Counted = deal2.reduce(into: [Character: Int](), extractHand(_:_:))
            let deal1Type = handTypeRetriever(deal1Counted)
            let deal2Type = handTypeRetriever(deal2Counted)
            if deal1Type != deal2Type {
                return deal1Type < deal2Type
            } else {
                for (card1, card2) in zip(deal1, deal2) {
                    if card1 == card2 {
                        continue
                    }
                    return cardValueMap[card1]! < cardValueMap[card2]!
                }
            }
            return false
        }
    }
    
    public func partOne() -> String {
        let sortedHands = sortHands(cardValueMap: cardValue, handTypeRetriever: getHandType(hand:))
        let winnings = sortedHands.enumerated().map { index, hand in
            (index + 1) * hand.value
        }
        return String(winnings.reduce(0, +))
    }
    
    public func partTwo() -> String {
        let sortedHands = sortHands(cardValueMap: cardValuePartTwo, handTypeRetriever: getHandTypePartTwo(hand:))
        let winnings = sortedHands.enumerated().map { index, hand in
            (index + 1) * hand.value
        }
        return String(winnings.reduce(0, +))
    }
}
