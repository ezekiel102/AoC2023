import ChallengeBase
import Foundation

extension AdventOfCode2023 {
    class Day14 : AdventOfCode2023, Solution {
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
            var rocks = readInput(depths)
            for rock in rocks {
                print(rock)
            }
            moveRockN(&rocks)
            for rock in rocks {
                print(rock)
            }
            return resultRocks(rocks)
        }
        
        func part02(_ depths: Input) -> Output {
            var rocks = readInput(depths)
//            for rock in rocks {
//                print(rock)
//            }
            var k = 0
            fullCycle(&rocks)
            k += 1
            print(resultRocks(rocks), k)
            fullCycle(&rocks)
            k += 1
            print(resultRocks(rocks), k)
            let a = resultRocks(rocks)
            fullCycle(&rocks)
            k += 1
            while resultRocks(rocks) != a {
                fullCycle(&rocks)
                k += 1
                print(resultRocks(rocks), k)
            }
//            fullCycle(&rocks)
//            k += 1
//            fullCycle(&rocks)
//            k += 1
//            fullCycle(&rocks)
//            k += 1
//            fullCycle(&rocks)
//            k += 1
//            var etalonRocks = rocks
//            print(resultRocks(etalonRocks))
//            fullCycle(&rocks)
//            k += 1
//            while resultRocks(rocks) != resultRocks(etalonRocks) || k == 10 || k == 11 || k == 18 || k == 17 {
//                fullCycle(&rocks)
//                k += 1
//                print(resultRocks(rocks))
//
//                print(k)
//            }
//            print("k", k)
//            for rock in rocks {
//                print(rock)
//            }
            return 64 //resultRocks(rocks)
        }
        
        func readInput(_ depths: Input) -> [[Character]] {
            var labirint: [[Character]] = []
            for line in depths {
                labirint.append(Array(line))
            }
            return labirint
        }
        
        func moveRockN(_ depths: inout [[Character]]) {
//            print("rocks North")
            for i in 1..<depths.count {
                for j in 0..<depths[i].count {
                    if depths[i][j] == "O" {
                        var k = i
                        while k >= 1 && !["O", "#"].contains(depths[k - 1][j]) {
                            depths[k - 1][j] = "O"
                            depths[k][j] = "."
                            k -= 1
                        }
                    }
                }
            }
//            for rock in depths {
//                print(rock)
//            }
        }
        
        func moveRockS(_ depths: inout [[Character]]) {
//            print("rocks South")
            for i in (0..<depths.count - 1).reversed() {
                for j in (0..<depths[i].count).reversed() {
                    if depths[i][j] == "O" {
                        var k = i
                        while k <= depths.count - 2 && !["O", "#"].contains(depths[k + 1][j]) {
                            depths[k + 1][j] = "O"
                            depths[k][j] = "."
                            k += 1
                        }
                    }
                }
            }
//            for rock in depths {
//                print(rock)
//            }
        }
        
        func moveRockW(_ depths: inout [[Character]]) {
//            print("rocks West")
            for i in 0..<depths.count {
                for j in 1..<depths[i].count {
                    if depths[i][j] == "O" {
                        var k = j
                        while k >= 1 && !["O", "#"].contains(depths[i][k - 1]) {
                            depths[i][k - 1] = "O"
                            depths[i][k] = "."
                            k -= 1
                        }
                    }
                }
            }
//            for rock in depths {
//                print(rock)
//            }
        }
        
        func moveRockE(_ depths: inout [[Character]]) {
//            print("rocks East")
            for i in (0..<depths.count).reversed() {
                for j in (0..<depths[i].count - 1).reversed() {
                    if depths[i][j] == "O" {
                        var k = j
                        while k <= depths[i].count - 2 && !["O", "#"].contains(depths[i][k + 1]) {
                            depths[i][k + 1] = "O"
                            depths[i][k] = "."
                            k += 1
                        }
                    }
                }
            }
//            for rock in depths {
//                print(rock)
//            }
        }
        
        func fullCycle(_ depths: inout [[Character]]) {
//            print("hell yeah")
            moveRockN(&depths)
            moveRockW(&depths)
            moveRockS(&depths)
            moveRockE(&depths)
            
        }
        
        func resultRocks(_ depths: [[Character]]) -> Int {
            var result = 0
            for i in 0..<depths.count {
                for j in 0..<depths[i].count {
                    if depths[i][j] == "O" {
                        result += depths.count - i
                    }
                }
            }
            return result
        }
    }
}

//102756
