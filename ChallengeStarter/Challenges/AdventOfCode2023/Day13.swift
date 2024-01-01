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
    class Day13 : AdventOfCode2023, Solution {
        // MARK: - Type Aliases
        typealias Input = [[String]]
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
            let inp = rawInput.components(separatedBy: "\n\n")
            var depths: [[String]] = []
            for pattern in inp {
                depths.append(pattern.components(separatedBy: .newlines).filter ({$0 > ""}))
            }
            let increases = rawOutput?.integerList()[0]
            //depths.removeLast()
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
//            print(depths)
            
            for j in 0..<depths.count {
                for line in depths[j] {
                    print(line)
                }
                for i in 0..<depths[j].count - 1 {
                    print("lines", i, "i", checkLines(depths[j], i + 1))
                    if checkLines(depths[j], i + 1) != 0 && (checkLines(depths[j], i + 1) == i + 1 || checkLines(depths[j], i + 1) == depths[j].count - i - 1)  {
//                        print(i, "i", checkLines(depths[j], i + 1))
                        result += (i + 1) * 100
                        print((i + 1) * 100)
                    }
                }
                for i in 0..<depths[j][0].count {
                    print("columns", i, "i", checkColumns(depths[j], i + 1))
                    if checkColumns(depths[j], i + 1) != 0 &&
                        (checkColumns(depths[j], i + 1) == i + 1 || checkColumns(depths[j], i + 1) == depths[j][0].count - i - 1) {
                        result += i + 1
                        print(i + 1)
                    }
                }
//                if maxLines[j].0 == 0 {
//                    maxLines[j].1 = 0
//                }
//                if maxColumn[j].0 == 0 {
//                    maxColumn[j].1 = 0
//                }
            }
            
//            var maxLines: [(Int, Int)] = []
//            var maxColumn: [(Int, Int)] = []
//            for _ in depths {
//                maxLines.append((0, 0))
//                maxColumn.append((0, 0))
//            }
//
//            for j in 0..<depths.count {
//                for i in 0..<depths[j].count {
//                    if checkLines(depths[j], i + 1) > maxLines[j].0 {
//                        let a = checkLines(depths[j], i + 1)
//                        let b = i + 1
//                        maxLines[j] = (a, b)
//                    }
//                }
//                for i in 0..<depths[j][0].count {
//                    if checkColumns(depths[j], i + 1) >
//                        maxColumn[j].0 {
//                        let a = checkColumns(depths[j], i + 1)
//                        let b = i + 1
//                        maxColumn[j] = (a, b)
//                    }
//                }
//                if maxLines[j].0 == 0 {
//                    maxLines[j].1 = 0
//                }
//                if maxColumn[j].0 == 0 {
//                    maxColumn[j].1 = 0
//                }
//            }
//
//            for i in 0..<depths.count {
//                if maxLines[i].0 >= maxColumn[i].0 {
//                    result += maxLines[i].1 * 100
//                    for j in depths[i] {
//                        print(j)
//                    }
//                    print("line", maxLines[i].1 * 100)
//                } else {
//                    result += maxColumn[i].1
//                    for j in depths[i] {
//                        print(j)
//                    }
//                    print("column", maxColumn[i].1)
//                }
//            }
            return result
        }
        
        func part02(_ depths: Input) -> Output {
            
            return 0
        }
        
        func rLine(_ string: String) -> (String, [Int]) {
            let str = string.components(separatedBy: " ")[0]
            let numbers: [Int] = string.components(separatedBy: " ")[1].components(separatedBy: ",").compactMap({ Int($0) })
            
            return (str, numbers)
        }
        
        func checkLines(_ strings: [String],_ number: Int) -> Int {
            var result = 0
            for i in 0..<min(number, strings.count - number) {
                if strings[number - 1 - i] == strings[number + i] {
                    result += 1
                } else if result == 0 {
                    //break
                }
            }
            return result
        }
        
        func checkColumns(_ strings: [String],_ number: Int) -> Int {
            var result = 0
            for i in 0..<min(number, strings[0].count - number) {
                var checkC = true
                for j in 0..<strings.count {
                    if strings[j][strings[j].index(strings[j].startIndex, offsetBy: number - 1 - i)] == strings[j][strings[j].index(strings[j].startIndex, offsetBy: number + i)] {
                        checkC = checkC && true
                    } else {
                        checkC = checkC && false
                    }
                }
                if checkC {
                    result += 1
                }
            }
            return result
        }
    }
}

//30116
//33116
//33149
//32281

//32371?
