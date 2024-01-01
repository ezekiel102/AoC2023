//
//
//  Solution00.swift
//  ChallengeStarter
//
//  Created by you on 2022-11-25.
//
//

import ChallengeBase

extension AdventOfCode2023 {
    class Day02 : AdventOfCode2023, Solution {
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
            var increases: Int = 0
            for line in 1...depths.count {
                let a = readGameResults(depths[line - 1])
                if a[line]!["red"]! <= 12 && a[line]!["green"]! <= 13 && a[line]!["blue"]! <= 14 {
                 increases += line
                }
            }
            print(increases)
            return increases
        }
        
        func part02(_ depths: Input) -> Output {
            var increases: Int = 0
            for line in 1...depths.count {
                let a = readGameResults2(depths[line - 1])
                increases += a[line]!["red"]! * a[line]!["green"]! * a[line]!["blue"]!
            }
            print(increases)
            return increases
        }
        
        func readGameResults (_ string: String) -> [ Int : [ String : Int] ] {
            var gameN: Int,
                red: String = "red", redCount: Int = 0,
                green: String = "green", greenCount: Int = 0,
                blue: String = "blue", blueCount: Int = 0
            let separatedString = string.components(separatedBy: ":")
            gameN = Int(separatedString[0].components(separatedBy: " ")[1])!
            let games = separatedString[1].components(separatedBy: ";")
            for game in games {
                let gamesNN = game.components(separatedBy: " ")
                for i in 0..<gamesNN.count {
                    if gamesNN[i].contains("red") {
                        redCount = max(Int(gamesNN[i - 1])!, redCount)
                    }
                    if gamesNN[i].contains("green") {
                        greenCount = max(Int(gamesNN[i - 1])!, greenCount)
                    }
                    if gamesNN[i].contains("blue") {
                        blueCount = max(Int(gamesNN[i - 1])!, blueCount)
                    }
                }
            }
            return [ gameN : [ red : redCount, green : greenCount, blue : blueCount ] ]
        }
        
        func readGameResults2 (_ string: String) -> [ Int : [ String : Int] ] {
            var gameN: Int,
                red: String = "red", redCount: Int = 0,
                green: String = "green", greenCount: Int = 0,
                blue: String = "blue", blueCount: Int = 0
            let separatedString = string.components(separatedBy: ":")
            gameN = Int(separatedString[0].components(separatedBy: " ")[1])!
            let games = separatedString[1].components(separatedBy: ";")
            for game in games {
                let gamesNN = game.components(separatedBy: " ")
                for i in 0..<gamesNN.count {
                    if gamesNN[i].contains("red") {
                        redCount = max(Int(gamesNN[i - 1])!, redCount)
                    }
                    if gamesNN[i].contains("green") {
                        greenCount = max(Int(gamesNN[i - 1])!, greenCount)
                    }
                    if gamesNN[i].contains("blue") {
                        blueCount = max(Int(gamesNN[i - 1])!, blueCount)
                    }
                }
            }
            return [ gameN : [ red : redCount, green : greenCount, blue : blueCount ] ]
        }
        
    }
}
