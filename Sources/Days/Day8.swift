import Foundation
import Helper
import Algorithms

public class Day8: DayProtocol {
    private let input: String
    
    let instructions: [Character]
    let map: [String: (String, String)]
    
    public init() {
        input = FileHandler.getInputs(for: Bundle.module.resourcePath!, andDay: 8)
        instructions = Array(String(input.split(separator: "\n\n")[0]))
        let mapString = input.split(separator: "\n\n")[1]
        map = mapString.split(separator: "\n").reduce(into: [String: (String, String)]()) { partialResult, row in
            let node = row.split(separator: " = ")
            let destinations = node[1].dropFirst().dropLast().split(separator: ", ")
            partialResult[String(node[0])] = (String(destinations[0]), String(destinations[1]))
        }
    }
    
    fileprivate func countSteps(_ start: String, startSuffix: String, finishSuffix: String) -> Int {
        var stepsTaken = 0
        var currentPosition = start
        while !currentPosition.hasSuffix(finishSuffix) {
            let currentLeftRight = map[currentPosition]!
            let instruction = instructions[stepsTaken % instructions.count]
            currentPosition = instruction == "L" ? currentLeftRight.0 : currentLeftRight.1
            stepsTaken += 1
        }
        return stepsTaken
    }
    
    public func partOne() -> String {
        let start = "AAA"
        let finish = "ZZZ"
        var stepsTaken = countSteps(start, startSuffix: start, finishSuffix: finish)
        return String(stepsTaken)
    }
    
    public func partTwo() -> String {
        let startSuffix = "A"
        let finishSuffix = "Z"
        let startPositions = map.keys.filter({ $0.hasSuffix(startSuffix) })
        let test = startPositions.map { countSteps($0, startSuffix: startSuffix, finishSuffix: finishSuffix) }
        return String(lcm(test))
    }
}
