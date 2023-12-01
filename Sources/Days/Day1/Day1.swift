//
//  File.swift
//  
//
//  Created by Carl-Johan Heinze on 2022-12-05.
//

import Foundation
import Helper
import RegexBuilder

public class Day1: DayProtocol {
    private let input: String
    private let rows: [String]
    
    public init() {
        input = FileHandler.getInputs(for: Bundle.module.resourcePath!, andDay: 1)
        rows = input.split(separator: "\n").map(String.init)
    }

    public func partOne() -> String {
        let numbers: [Int] = rows.compactMap { command in
            let rowNumberRanges = command
                .ranges(of: #/[0-9]/#)
            
            let first = command[rowNumberRanges.first!]
            let last = command[rowNumberRanges.last!]
            
             if let value = Int(first + last) {
                return value
            }
            return nil
        }
        
        return String(numbers.reduce(0, +))
    }
    
    let numberMap = [
        "one": "1",
        "two": "2",
        "three": "3",
        "four": "4",
        "five": "5",
        "six": "6",
        "seven": "7",
        "eight": "8",
        "nine": "9",
    ]
    
    public func partTwo() -> String {
        
        let numbers: [Int] = rows.compactMap { command in
            let rowNumberRanges = command
                .ranges(of: #/[0-9]/#)
            let writtenRanges = numberMap.keys.flatMap { number in
                command.ranges(of: number)
            }

            guard let firstRange = (writtenRanges + rowNumberRanges).min(by: { $0.lowerBound < $1.lowerBound }) else { return nil }
            guard let lastRange = (writtenRanges + rowNumberRanges).max(by: { $0.upperBound < $1.upperBound }) else { return nil }
            
            var first: String = String(command[firstRange])
            var last: String = String(command[lastRange])

            if Int(first) == nil {
                first = numberMap[first, default: ""]
            }
            if Int(last) == nil {
                last = numberMap[last, default: ""]
            }
            
            if let value = Int(first + last) {
                return value
            }
            return nil
        }
        
        return String(numbers.reduce(0, +))
    }
    
}
