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
    class Day09 : AdventOfCode2023, Solution {
        // MARK: - Type Aliases
        typealias Input = [[Int]]
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
            var depths: [[Int]] = []
            
            for line in rawInput.components(separatedBy: .newlines) {
                depths.append(line.components(separatedBy: " ").compactMap{ Int($0) })
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
            var increases = 0
            for str in depths {
                increases += stringSum(str)
            }
            return increases
        }
        
        func part02(_ depths: Input) -> Output {
            var increases = 0
            for str in depths {
                increases += stringDelta(str)
            }
            return increases
        }
        
        func stringDelta(_ string: [Int] ) -> Int {
            var input = string
            var result = input.first!
            var j = 1
            while input.count != 1 {
                print(input)
                for i in (1..<input.count).reversed() {
                    input[i] = input[i] - input[i - 1]
                }
                input.removeFirst()
                print(input.first!)
                j += 1
                if j % 2 == 0 {
                    result -= input.first!
                } else {
                    result += input.first!
                }
                print(result)
            }
            print(result)
            return result
        }
        
        
        func stringSum(_ string: [Int] ) -> Int {
            var input = string
            var increases = input.last!
            while input.count != 1 {
                for i in (1..<input.count).reversed() {
                    input[i] = input[i] - input[i - 1]
                }
                input.removeFirst()
                increases += input.last!
            }
            return increases
        }
        
        
    }
}
