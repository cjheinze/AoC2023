//
//  Runner.swift
//
//
//  Created by Carl-Johan Heinze on 2023-11-24.
//

import Foundation
import Days
import Helper
@main
struct Runner {
    
    static func main() async {

        let day: DayProtocol = Day9()
        
        let startPartOne = Date()
        print("Start part one")
        let partOne = day.partOne()
        let durationPartOne = Date().timeIntervalSince(startPartOne)
        print("Part one solution:", partOne, "time: \(String(format: "%.5f", durationPartOne))s (\(String(format: "%.2f", durationPartOne * 1000))ms)")
        let startPartTwo = Date()
        print("Start part two")
        let partTwo = day.partTwo()
        let durationPartTwo = Date().timeIntervalSince(startPartTwo)
        print("Part two solution:", partTwo, "time: \(String(format: "%.5f", durationPartTwo))s (\(String(format: "%.2f", durationPartTwo * 1000))ms)")
    }
}
