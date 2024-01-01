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
    class Day05 : AdventOfCode2023, Solution {
        // MARK: - Type Aliases
        typealias Input = [String]
        typealias Output = Int64
        
        
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
            let depths: [String] = rawInput.components(separatedBy: "\n\n")
            let increases = Int64((rawOutput?.integerList()[0]) ?? 0)
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
            var inputNums = inputNumbers(depths[0])
            for i in 1..<depths.count {
                let tempNums = arrayNumbers(depths[i])
                for inN in 0..<inputNums.count {
                    for j in 0..<tempNums.count {
                        if inputNums[inN] >= tempNums[j][1] && inputNums[inN] < (tempNums[j][1] + tempNums[j][2]) {
                            inputNums[inN] = tempNums[j][0] + inputNums[inN] - tempNums[j][1]
                            break
                        }
                    }
                }
            }
            return inputNums.min()!
        }
        
        func part02(_ depths: Input) -> Output {
            var inputNums = inputNumbers(depths[0])
            var minimum = inputNums[0]
            var minimumTemp = inputNums[0]
            for i in 0..<inputNums.count {
                if i % 2 != 0 {
                    inputNums[i] += inputNums[i - 1] - 1
                }
            }
            if inputNums.count > 4 {
                for i in [0, 2, 4, 6, 8] {
                    for k in inputNums[i]...inputNums[i + 1] {
                        minimumTemp = k
//                        print(k)
                        for i in 1..<depths.count {
                            let tempNums = arrayNumbers(depths[i])
                            for j in 0..<tempNums.count {
                                if minimumTemp >= tempNums[j][1] && minimumTemp < (tempNums[j][1] + tempNums[j][2]) {
                                    minimumTemp = tempNums[j][0] + minimumTemp - tempNums[j][1]
                                    break
                                }
                            }
                            
                        }
                        if minimumTemp < minimum {
                            minimum = minimumTemp
                        }
                    }
                }
            } else {
                for i in [0, 2] {
                    for k in inputNums[i]...inputNums[i + 1] {
                        minimumTemp = k
                        for i in 1..<depths.count {
                            let tempNums = arrayNumbers(depths[i])
                            for j in 0..<tempNums.count {
                                if minimumTemp >= tempNums[j][1] && minimumTemp < (tempNums[j][1] + tempNums[j][2]) {
                                    minimumTemp = tempNums[j][0] + minimumTemp - tempNums[j][1]
                                    break
                                }
                            }
                            
                        }
                        if minimumTemp < minimum {
                            minimum = minimumTemp
                        }
                    }
                }
            }
            return minimum
        }
        
        func inputNumbers(_ string: String) -> [Int64] {
            var inNums: [Int64] = []
            inNums = string.components(separatedBy: ":")[1].components(separatedBy: [" ","\n"]).compactMap { Int64($0) }
            return inNums
        }
        
        func arrayNumbers(_ string: String) -> [[Int64]] {
            var inStrings: [String] = []
            var imnNums: [[Int64]] = []
//            print("string", string)
            inStrings = string.components(separatedBy: ":")[1].components(separatedBy: "\n")
            inStrings.removeFirst()
//            print("instring", inStrings)
            for i in 0..<inStrings.count {
                if inStrings[i] == "" {
                    break
                }
                imnNums.append([])
                imnNums[i].append(Int64(inStrings[i].components(separatedBy: " ")[0])!)
                imnNums[i].append(Int64(inStrings[i].components(separatedBy: " ")[1])!)
                imnNums[i].append(Int64(inStrings[i].components(separatedBy: " ")[2])!)
            }
            
            return imnNums
        }
    }
}
