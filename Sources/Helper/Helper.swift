//
//  File.swift
//  
//
//  Created by Carl-Johan Heinze on 2022-12-05.
//

import Foundation

public struct FileHandler {
    
    public static func getInputs(for path: String, andDay day: Int) -> String {
        let contents = try? String(contentsOfFile: path.appending("/Day\(day).txt"))
        return contents ?? ""
    }
}

public extension StringProtocol {
    subscript(offset: Int) -> Character {
        self[index(startIndex, offsetBy: offset)]
    }
}

public protocol DayProtocol {
    func partOne() -> String
    func partTwo() -> String
}

public extension Int {
    func mod(_ other: Int) -> Int {
        guard other != 0 else { return 0 }
        let m = self % other
        return m < 0 ? m + other : m
    }
}
