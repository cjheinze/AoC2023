import Foundation
import Helper
import Algorithms

public class Day9: DayProtocol {
    private let input: String
    private let rows: [[Int]]
    public init() {
        input = FileHandler.getInputs(for: Bundle.module.resourcePath!, andDay: 9)
        print(input)
        rows = input.split(separator: "\n")
            .map({ $0.split(separator: " ")
                    .map({ Int($0)! })
            })
    }
    
    func extractDifferences(list: [Int]) -> [Int] {
        list.enumerated().compactMap { (index, value) in
            if index == list.endIndex - 1 {
                return nil
            }
            return list[index + 1] - value
        }
    }
    
    fileprivate func extrapolateNextValue(_ row: [Int]) -> Int {
        var values: [[Int]] = [row]
        var last = values[values.endIndex - 1]
        while !last.allSatisfy({ $0 == 0 }) {
            values += [extractDifferences(list: last)]
            last = values[values.endIndex - 1]
        }
        return values.compactMap(\.last).reduce(0, +)
    }
    
    public func partOne() -> String {
        var extrapolatedValues = rows.map(extrapolateNextValue(_:))
        return String(extrapolatedValues.reduce(0, +))
    }
    
    public func partTwo() -> String {
        var extrapolatedValues = rows.map({$0.reversed()}).map(extrapolateNextValue(_:))
        return String(extrapolatedValues.reduce(0, +))
    }
}
