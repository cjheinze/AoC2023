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
    static let day: DayProtocol = Day4()
    static func main() {
        let partOne = day.partOne()
        print("Part one solution:", partOne)
        let partTwo = day.partTwo()
        print("Part two solution:", partTwo)
    }
}
