//
//
//  Day04.swift
//  ChallengeStarter
//
//  Created by you on 2022-11-25.
//
//

import ChallengeBase
import Foundation

extension AdventOfCode2023 {
    class Day10 : AdventOfCode2023, Solution {
        // MARK: - Type Aliases
        typealias Input = [[Character]]
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
            var depths: [[Character]] = []
            
            for line in rawInput.components(separatedBy: .newlines) {
                depths.append(Array(line))
            }
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
            var steps = 0
            let start = startPosition(depths)
            print("start", start)
            var previousPosition = (0,0)
            var currentPosition = start
            var nextPosition = (0,0)
            nextPosition = nextPositions(depths, start)[0]
            previousPosition = currentPosition
            currentPosition = nextPosition
            steps += 1
            while currentPosition != start {
                let poses = nextPositions(depths, currentPosition)
                if poses.count == 2 && poses[0] == previousPosition  {
                    nextPosition = poses[1]
                    previousPosition = currentPosition
//                    depths[previousPosition.0][previousPosition.1] = "*"
                    currentPosition = nextPosition
                    steps += 1
                } else if poses.count == 2 {
                    nextPosition = poses[0]
                    previousPosition = currentPosition
//                    depths[previousPosition.0][previousPosition.1] = "*"
                    currentPosition = nextPosition
                    steps += 1
                } else if poses.count == 1 {
                    nextPosition = poses[0]
                    previousPosition = currentPosition
//                    depths[previousPosition.0][previousPosition.1] = "*"
                    currentPosition = nextPosition
                    steps += 1
                }
                for i in depths {
                    print(i)
                }
                print(steps, currentPosition)
            }
//            for i in depths {
//                print(i)
//            }
            return steps / 2
        }
        
        func part02(_ depthsIN: Input) -> Output {
            
            
            
            var result = 0
            var depths = depthsIN
            
//            for i in depths {
//                print(i)
//            }
            
            let start = startPosition(depths)
//            print("start", start)
            var previousPosition = (0,0)
            var currentPosition = start
            var nextPosition = (0,0)
            nextPosition = nextPositions(depths, start)[0]
            previousPosition = currentPosition
            currentPosition = nextPosition
            while currentPosition != start {
                let poses = nextPositions(depths, currentPosition)
                if poses.count == 2 && poses[0] == previousPosition  {
                    nextPosition = poses[1]
                    previousPosition = currentPosition
                    depths[previousPosition.0][previousPosition.1] = "*"
                    currentPosition = nextPosition
                } else if poses.count == 2 {
                    nextPosition = poses[0]
                    previousPosition = currentPosition
                    depths[previousPosition.0][previousPosition.1] = "*"
                    currentPosition = nextPosition
                } else if poses.count == 1 {
                    nextPosition = poses[0]
                    previousPosition = currentPosition
                    depths[previousPosition.0][previousPosition.1] = "*"
                    currentPosition = nextPosition
                }
//                for i in depths {
//                    print(i)
//                }
            }
            var ggg: [Character] = []
            for _ in 0..<(depths[0].count * 2) {
                ggg.append("?")
            }
            var depths2: [[Character]] = []
            for i in 0..<depths.count {
                var depths2Line: [Character] = []
                for j in 0..<depths[i].count {
                    depths2Line.append(depthsIN[i][j])
                    depths2Line.append("?")
                }
                depths2.append(depths2Line)
                depths2.append(ggg)
            }
            for i in 0..<depths2.count {
                for j in 0..<depths2[0].count {
                    if depths2[i][j] == "?" {
                        delete2(&depths2, (i, j), depthsIN)
                    }
                }
            }
//            for i in depths2 {
//                print(i)
//            }
            for i in 0..<depths.count {
                for j in 0..<depths[0].count {
                    if depths[i][j] == "*" {
                        depths2[i * 2][j * 2] = "*"
                    }
                }
            }
//            print(2)
//            for i in depths2 {
//                print(i)
//            }
            for i in 0..<depths2.count {
                var j = 0
                while !["*", "$","S"].contains(depths2[i][j]) {
                    depths2[i][j] = "0"
                    j += 1
                    if j == depths2[0].count {
                        break
                    }
                }
                j = depths2[i].count - 1
                while !["*", "$","S"].contains(depths2[i][j]) {
                    depths2[i][j] = "0"
                    j -= 1
                    if j == -1 {
                        break
                    }
                }
            }
            for i in 0..<depths2[0].count {
                var j = 0
                while !["*", "$","S"].contains(depths2[j][i]) {
                    depths2[j][i] = "0"
                    j += 1
                    if j == depths2.count {
                        break
                    }
                }
                j = depths2.count - 1
                while !["*", "$","S"].contains(depths2[j][i]) {
                    depths2[j][i] = "0"
                    j -= 1
                    if j == -1 {
                        break
                    }
                }
            }
            //print("g")
            var result1 = 0, result2 = 1
            for i in 0..<depths2.count {
                for j in 0..<depths2[0].count {
                    if !["?", "*", "0", "S", "$"].contains(depths2[i][j]) && i % 2 == 0 && j % 2 == 0 {
                        result1 += 1
                    }
                }
            }
//            for i in depths2 {
//                    print(i)
//                }
            print(result1)
            while result2 != 4 {
                result1 = result2
                result2 = 0
                for i in 0..<depths2.count {
                    for j in 0..<depths2[i].count {
                        if !["*", "0", "S", "$"].contains(depths2[i][j]) {
                            delete(&depths2, (i, j))
                        }
                    }
                }
                for i in 0..<depths2.count {
                    for j in 0..<depths2[0].count {
                        if !["?", "*", "0", "S", "$"].contains(depths2[i][j]) && i % 2 == 0 && j % 2 == 0 {
                            result2 += 1
                        }
                    }
                }
                print(result1, result2)
            }
            for i in 0..<depths2.count {
                for j in 0..<depths2[i].count {
                    if !["*", "0", "S", "$"].contains(depths2[i][j]) {
                        delete(&depths2, (i, j))
                    }
                }
            }
            for i in 0..<depths2.count {
                for j in 0..<depths2[i].count {
                    if !["*", "0", "S", "$"].contains(depths2[i][j]) {
                        delete(&depths2, (i, j))
                    }
                }
            }
            for i in 0..<depths2.count {
                for j in 0..<depths2[i].count {
                    if !["*", "0", "S", "$"].contains(depths2[i][j]) {
                        delete(&depths2, (i, j))
                    }
                }
            }
            for i in 0..<depths2.count {
                for j in 0..<depths2[i].count {
                    if !["*", "0", "S", "$"].contains(depths2[i][j]) {
                        delete(&depths2, (i, j))
                    }
                }
            }
            
            for i in 0..<depths2.count {
                for j in 0..<depths2[0].count {
                    if !["?", "*", "0", "S", "$"].contains(depths2[i][j]) && i % 2 == 0 && j % 2 == 0 {
                        result += 1
                    }
                }
            }
//            for i in depths2 {
//                print(i)
//            }
            return result
        }
        
        func startPosition(_ depths: [[Character]]) -> (Int, Int) {
            for i in 0..<depths.count {
                for j in 0..<depths[0].count {
                    if depths[i][j] == "S" {
                        return (i, j)
                    }
                }
            }
            return (0, 0)
        }
        
        func nextPositions(_ depths: [[Character]], _ current: (Int, Int)) -> [(Int, Int)] {
            var near: [(Int, Int)] = []
//            print("cur", current)
            let aT = current.0 == 0 ? 0 : current.0 - 1
            let aB = current.0 == depths.count - 1 ? current.0 : current.0 + 1
            let aL = current.1 == 0 ? 0 : current.1 - 1
            let aR = current.1 == depths[current.0].count - 1 ? current.1 : current.1 + 1
//            for i in aT...aB {
//                print(depths[i][aL...aR])
//            }
//            print(aT, "aT", depths[aT][current.1])
//            print(aB, "aB", depths[aB][current.1])
//            print(aL, "aL", depths[current.0][aL])
//            print(aR, "aR", depths[current.0][aR])
            if ["|","F","7","S"].contains(depths[aT][current.1]) && ["|","L","S","J"].contains(depths[current.0][current.1]) && aT != current.0 {
                near.append((aT, current.1))
//                print(1)
            }
            if ["|","L","J","S"].contains(depths[aB][current.1]) && ["|","F","S","7"].contains(depths[current.0][current.1]) && aB != current.0 {
                near.append((aB, current.1))
//                print(2)
            }
            if ["-","L","F","S"].contains(depths[current.0][aL]) && ["-","J","S","7"].contains(depths[current.0][current.1]) && aL != current.1 {
                near.append((current.0, aL))
//                print(3)
            }
            if ["-","J","7","S"].contains(depths[current.0][aR]) && ["-","F","S","L"].contains(depths[current.0][current.1]) && aR != current.1 {
                near.append((current.0, aR))
//                print(4)
            }
//            print(near)
            return near
        }
        
        func delete(_ depths: inout [[Character]], _ current: (Int, Int)) {
            let aT = current.0 == 0 ? 0 : current.0 - 1
            let aB = current.0 == depths.count - 1 ? current.0 : current.0 + 1
            let aL = current.1 == 0 ? 0 : current.1 - 1
            let aR = current.1 == depths[current.0].count - 1 ? current.1 : current.1 + 1
            for i in aT...aB {
                for j in aL...aR {
                    if depths[i][j] == "0" {
                        depths[current.0][current.1] = "0"
                    }
                }
            }
        }
        
        func delete2(_ depths: inout [[Character]], _ current: (Int, Int), _ control: [[Character]]) {
            if current.0 == 0 && current.1 == 0 {
                return
            } else if current.0 == 0 && current.1 == depths[0].count - 1 {
                 return
            } else if current.1 == 0 && current.0 == depths.count - 1 {
                return
            } else if current.0 == depths.count - 1 && current.1 == depths[0].count - 1 {
                return
            } else if current.0 == 0 || current.0 == depths.count - 1 {
                let aL = current.1 - 1
                let aR = current.1 + 1
                if ["-","L","F","S"].contains(depths[current.0][aL]) && ["-","7","J","S"].contains(depths[current.0][aR]) {
                    depths[current.0][current.1] = "$"
                }
            } else if current.1 == 0 || current.1 == depths[0].count - 1 {
                let aT = current.0 - 1
                let aB = current.0 + 1
                if ["|","7","F","S"].contains(depths[aT][current.1]) && ["|","L","J","S"].contains(depths[aB][current.1]) {
                    depths[current.0][current.1] = "$"
                }
            } else {
                let aT = current.0 - 1
                let aB = current.0 + 1
                let aL = current.1 - 1
                let aR = current.1 + 1
                
                if ["-","L","F","S"].contains(depths[current.0][aL]) && ["-","7","J","S"].contains(depths[current.0][aR]) {
                    depths[current.0][current.1] = "$"
                }
                if ["|","7","F","S"].contains(depths[aT][current.1]) && ["|","L","J","S"].contains(depths[aB][current.1]) {
                    depths[current.0][current.1] = "$"
                }
            }
        }
        
    }
}

