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
    class Day08 : AdventOfCode2023, Solution {
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
            var depths = rawInput.components(separatedBy: .newlines)
            let increases = Int64((rawOutput?.integerList()[0]) ?? 0)
            depths.remove(at: 1)
            depths.removeLast()
            return (depths, increases)
        }
        
        // Step 2: Activate
        func activate(_ input: Input, algorithm: Algorithms) -> Output {
            
            switch algorithm {
            case .part01:
                return part01(input, "AAA")
            case .part02:
                return part02(input)
            }
            
        }
        
        // MARK: - Logic Methods
        func part01(_ depths: Input, _ pointA: String) -> Output {
            var instructions = Array(depths[0])
            var roadDestinations: [[String]] = []
            for i in 1..<depths.count {
                roadDestinations.append(depths[i].components(separatedBy: [" ", "=", "(", ")", ","]).filter({ $0 != "" }))
            }
            var steps = 0
            var nextStep = ""
            var point = pointA
            while !point.contains("Z") {
                steps += 1
                nextStep = String(instructions.removeFirst())
                for road in roadDestinations {
                    if road[0] == point {
                        if nextStep == "L" {
                            point = road[1]
                            break
                        } else {
                            point = road[2]
                            break
                        }
                    }
                }
                instructions += nextStep
            }
            return Int64(steps)
        }
        
        func part02(_ depths: Input) -> Output {
            var steps: Int64 = 1
            var roadDestinations: [[String]] = []
            for i in 1..<depths.count {
                roadDestinations.append(depths[i].components(separatedBy: [" ", "=", "(", ")", ","]).filter({ $0 != "" }))
            }
            var point: [Int] = []
            for road in roadDestinations {
                if road[0].contains("A") {
                    point.append(Int(part01(depths, road[0])))
                }
            }
            var nok: Set<Int> = []
            for step in point {
                var res = step
                var t = step / 2 + 1
                while t != 1 {
                    if res % t == 0 {
                        nok.insert(t)
                        nok.insert(res / t)
                        t -= 1
                        res = res / t
                    } else {
                        t -= 1
                    }
                }
            }
            for n in nok {
                steps = steps * Int64(exactly: n)!
            }
            
            return steps
        }
        
        func check(_ array: [String]) -> Bool {
            var i = 0
            for ch in array {
                if ch.contains("Z") {
                    i += 1
                }
            }
            return i == array.count
        }
        
        
    }
}
