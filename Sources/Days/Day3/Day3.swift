import Foundation
import Helper

public class Day3: DayProtocol {
    private let input: String
    private let rows: [String]
    
    public init() {
        input = FileHandler.getInputs(for: Bundle.module.resourcePath!, andDay: 3)
        rows = input.split(separator: "\n").map(String.init)
        print(rows)
    }
    
    public func partOne() -> String {
        let anySymbolButNotDigitOrDot = #/[^.^\d]/#
        let something = rows.enumerated().flatMap { index, row in
            let ranges = row.ranges(of: #/(\d+)/#)
            let validRanges = ranges.filter { range in
                var symbolFound = false
                let lowerBound = row.startIndex < range.lowerBound ? row.index(before: range.lowerBound) : range.lowerBound
                let upperBound = range.upperBound < row.endIndex ? row.index(after: range.upperBound) : range.upperBound
                let searchRange = lowerBound..<upperBound
                
                if row[searchRange].contains(anySymbolButNotDigitOrDot) {
                    return true
                }
                
                if (0 < index) {
                    symbolFound = symbolFound || rows[index - 1][searchRange].contains(anySymbolButNotDigitOrDot)
                }
                if (index < rows.endIndex - 1) {
                    symbolFound = symbolFound || rows[index + 1][searchRange].contains(anySymbolButNotDigitOrDot)
                }
                
                return symbolFound
            }
            return validRanges.map({ row[$0] })
        }
            .compactMap({ Int($0)})
        return String(something.reduce(0,+))
    }
    
    public func partTwo() -> String {
        var rangesOfDigitsPerRow: [Int: [Range<String.Index>]] = [:]
        rows.enumerated().forEach { index, row in
            rangesOfDigitsPerRow[index] = row.ranges(of: #/(\d+)/#)
        }
        let pairs = rows.enumerated().flatMap { index, row in
            let rangesOfAsterisk = row.ranges(of: #/(\*)/#)
            let validRanges = rangesOfAsterisk.compactMap { range in
                let lowerBound = row.startIndex < range.lowerBound ? row.index(before: range.lowerBound) : range.lowerBound
                let upperBound = range.upperBound < row.endIndex ? row.index(after: range.upperBound) : range.upperBound
                let searchRange = lowerBound..<upperBound
                
                let rowDigits = rangesOfDigitsPerRow[index, default: []]
                
                var rowsToSearch: [(String, [Range<String.Index>])] = [(row, rowDigits)]
                if index > 0 {
                    rowsToSearch.append((rows[index - 1], rangesOfDigitsPerRow[index - 1, default: []]))
                }
                if index < rows.endIndex - 1 {
                    rowsToSearch.append((rows[index + 1], rangesOfDigitsPerRow[index + 1, default: []]))
                }
                
                let matches: [any StringProtocol] = rowsToSearch.flatMap { (row, rowDigits) in
                    rowDigits.compactMap { rowDigitRange in
                        guard rowDigitRange.overlaps(searchRange) else {
                            return nil
                        }
                        return row[rowDigitRange]
                    }
                }
                
                return matches
            }
            return validRanges.filter({ $0.count == 2 })
        }
        
        return String(pairs.map({ Int($0[0])! * Int($0[1])! }).reduce(0, +))
    }
    
}
