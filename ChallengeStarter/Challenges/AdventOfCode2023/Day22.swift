import ChallengeBase
import Foundation

extension AdventOfCode2023 {
    class Day22 : AdventOfCode2023, Solution {
        // MARK: - Type Aliases
        typealias Input = [String]
        typealias Output = Int
        
        
        // MARK: - Properties
        var testCases: [TestCase<Input, Output>] = []
        var selectedResourceSets: [String] = []
        var selectedAlgorithms: [Algorithms] = []
        
        
        // MARK: - Initializers
        init(datasets: [String] = [], algorithms: [Algorithms] = []) {
            self.selectedResourceSets = datasets
            self.selectedAlgorithms = algorithms
        }
        
        
        // MARK: - Solution Methods
        // Step 1: Assemble
        func assemble(_ rawInput: String, _ rawOutput: String? = nil) -> (Input, Output?) {
            var depths: [String] = rawInput.components(separatedBy: .newlines)
            let increases = rawOutput?.integerList()[0]
            depths.removeLast()
            return (depths, increases)
        }
        
        // Step 2: Activate
        func activate(_ input: Input, algorithm: Algorithms) -> Output {
            
            switch algorithm {
            case .part01:
                return part01(input)
            case .part02:
                return part02(input)
            }
            
        }
        
        // MARK: - Logic Methods
        func part01(_ depths: Input) -> Output {
            var result = 0
            var bricks: [((Int, Int, Int), (Int, Int, Int))] = readBricks(depths)
            sortBricks(&bricks)
            for line in bricks {
                print(line)
            }
            print("xside")
            for line in xSide(bricks) {
                print(line)
            }
            print("yside")
            for line in ySide(bricks) {
                print(line)
            }
            return result
        }
        
        func part02(_ depths: Input) -> Output {
            var result = 0
            
            return result
        }
        
        func readBricks(_ depths: Input) -> [((Int, Int, Int), (Int, Int, Int))] {
            var bricks: [((Int, Int, Int), (Int, Int, Int))] = []
            for line in depths {
                let temp = line.components(separatedBy: [",", "~"]).compactMap { Int($0) }
                bricks.append(((temp[0], temp[1], temp[2]), (temp[3], temp[4], temp[5])))
            }
            
            return bricks
        }
        
        func sortBricks(_ bricks: inout [((Int, Int, Int), (Int, Int, Int))]) {
            for i in 0..<bricks.count - 2 {
                for j in i + 1..<bricks.count - 1 {
                    if bricks[i].0.2 > bricks[j].0.2 {
                        let temp = bricks[j]
                        bricks[j] = bricks[i]
                        bricks[i] = temp
                    }
                }
            }
        }
        
        func xSide(_ bricks: [((Int, Int, Int), (Int, Int, Int))]) -> [[Character]] {
            var result: [[Character]] = []
            let maxSides = maxSides(bricks)
            for i in 0...maxSides.2 {
                result.append([])
                for j in 0...maxSides.0 {
                    result[i].append(".")
                }
            }
            for line in bricks {
                for i in line.0.2...line.1.2 {
                    for j in line.0.0...line.1.0 {
                    result[i][j] = "#"
                    }
                }
            }
//            for line in result {
//                print(line)
//            }
            return result
        }
        
        func ySide(_ bricks: [((Int, Int, Int), (Int, Int, Int))]) -> [[Character]] {
            var result: [[Character]] = []
            let maxSides = maxSides(bricks)
            for i in 0...maxSides.2 {
                result.append([])
                for j in 0...maxSides.1 {
                    result[i].append(".")
                }
            }
            for line in bricks {
                for i in line.0.2...line.1.2 {
                    for j in line.0.1...line.1.1 {
                    result[i][j] = "#"
                    }
                }
            }
//            for line in result {
//                print(line)
//            }
            return result
        }
        
        func fallingDown(_ bricks: inout [((Int, Int, Int), (Int, Int, Int))]) {
            for i in 1..<bricks.count - 1 {
                let floor = bricks[i]
                let previousFloor = bricks[i - 1]
//                if floor.0.2 > previousFloor.1.2 {
//                    if [previousFloor.0.0...previousFloor.1.0].contains(floor.0.0) &&
//                        [previousFloor.0.1...previousFloor.1.1].contains(floor.0.1)
//                }
            }
        }
        
        func maxSides(_ bricks: [((Int, Int, Int), (Int, Int, Int))]) -> (Int, Int, Int) {
            var result = (0, 0, 0)
            for line in bricks {
                if line.0.0 > result.0 {
                    result.0 = line.0.0
                }
                if line.1.0 > result.0 {
                    result.0 = line.1.0
                }
                if line.0.1 > result.1 {
                    result.1 = line.0.1
                }
                if line.1.1 > result.1 {
                    result.1 = line.1.1
                }
                if line.0.2 > result.2 {
                    result.2 = line.0.2
                }
                if line.1.2 > result.2 {
                    result.2 = line.1.2
                }
            }
            return result
        }
        
    }
}
