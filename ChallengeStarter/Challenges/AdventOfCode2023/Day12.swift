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
    class Day12 : AdventOfCode2023, Solution {
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
            var depths = rawInput.components(separatedBy: .newlines)
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
            for i in depths {
                var massiveR: [String] = []
                let initString = rLine(i).0
                print(initString)
                var count = 0
                for ch in initString {
                    if ch == "?" {
                        count += 1
                    }
                }
                var combi = Int(pow(Double(2.0), Double(count)))
                print(combi)
                while combi != 1 {
                    for i in 0...(combi / 2) {
//                        massiveR.append[String("#")]
                    }
                    
                    
                }
                print(check(rLine(i).0, rLine(i).1))
            }
            
            return 0
        }
        
        func part02(_ depths: Input) -> Output {
            
            return 0
        }
        
        func rLine(_ string: String) -> (String, [Int]) {
            let str = string.components(separatedBy: " ")[0]
            let numbers: [Int] = string.components(separatedBy: " ")[1].components(separatedBy: ",").compactMap({ Int($0) })
            
            return (str, numbers)
        }
        
        func check(_ string: String,_ numbers: [Int]) -> Bool {
            let items = string.components(separatedBy: ".").filter({ $0 > "" })
            return checkArray(items, numbers)
        }
        
        func checkArray(_ str: [String], _ numbers: [Int]) -> Bool {
            var result = true
            if str.count == numbers.count {
                for i in 0..<str.count {
                    if str[i].count == numbers[i] {
                        result = result && true
                    } else {
                        result = result && false
                    }
                }
            } else {
                result = result && false
            }
            return result
        }
    }
}
