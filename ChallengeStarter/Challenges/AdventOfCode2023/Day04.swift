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
    class Day04 : AdventOfCode2023, Solution {
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
            var increases: Int = 0
            for str in depths {
                let a = str.components(separatedBy: [":","|"])[1].components(separatedBy: " ").compactMap { Int($0) }
                let b = str.components(separatedBy: [":","|"])[2].components(separatedBy: " ").compactMap { Int($0) }
                var inc = 0
                for i in 0..<a.count {
                    if b.contains(a[i]) && a[i] != 0 {
                        inc += 1
                    }
                }
                if inc > 0 {
                    increases = increases + NSDecimalNumber(decimal: pow(2, inc - 1)).intValue
                } else {
                    increases += 0
                }
            }
            return increases
        }
        
        func part02(_ depths: Input) -> Output {
            var increases: Int = 0
            var instances: [Int] = [0]
            for _ in 1...depths.count {
                instances.append(1)
            }
            for j in 1...depths.count {
                let a = depths[j - 1].components(separatedBy: [":","|"])[1].components(separatedBy: " ").compactMap { Int($0) }
                let b = depths[j - 1].components(separatedBy: [":","|"])[2].components(separatedBy: " ").compactMap { Int($0) }
                var inc = 0
                for i in 0..<a.count {
                    if b.contains(a[i]) && a[i] != 0 {
                        inc += 1
                        instances[j + inc] += instances[j]
                    }
                }
            }
            for j in 1...depths.count {
                increases += instances[j]
            }
            return increases
        }
    }
}
