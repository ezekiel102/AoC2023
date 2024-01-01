import ChallengeBase
import Foundation

extension AdventOfCode2023 {
    class Day19 : AdventOfCode2023, Solution {
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
            var A: [[String : Int]] = []
            var instrustions = readInstructions(depths)
            var input = readInput(depths)
            var inIndex = 0
            for i in 0..<instrustions.count {
                if instrustions[i][0] == "in" {
                    inIndex = i
                }
            }
            var tempIndex = inIndex
            for line in input {
                var nextKey = "in"
                while nextKey != "A" || nextKey != "R" {
                    var i = 1
                    var logicBool: Bool = false
                    while logicBool != true {
                        let logic = readLogic(instrustions[tempIndex][i])
                        if logic[1] == ">" {
                            logicBool = Int(exactly: line[logic[0]]!)! > Int(logic[2])!
                        } else {
                            logicBool = Int(exactly: line[logic[0]]!)! < Int(logic[2])!
                        }
                        if logicBool {
                            nextKey = logic[3]
                        } else {
                            if i <= instrustions[tempIndex].count - 3 {
                                i += 1
                            } else {
                                logicBool = true
                                nextKey = instrustions[tempIndex].last!
                            }
                        }
                    }
                    if nextKey == "A" {
                        print(line)
                        A.append(line)
                        tempIndex = inIndex
                        break
                    } else if nextKey == "R" {
                        tempIndex = inIndex
                        break
                    } else {
                        for i in 0..<instrustions.count {
                            if instrustions[i][0] == nextKey {
                                tempIndex = i
                            }
                        }
                    }
                }
            }
            
            for line in A {
                result += line["x"]! + line["m"]! + line["s"]! + line["a"]!
            }
            
            return result
        }
        
        func part02(_ depths: Input) -> Output {
            var result = 0
            var instrustions = readInstructions(depths)
            
            var inIndex = 0
            for i in 0..<instrustions.count {
                if instrustions[i][0] == "in" {
                    inIndex = i
                }
            }
            
            var tempIndex = inIndex
            
            for x in 1...4000 {
                print("x", x)
                for m in 1...4000 {
                    print("mmmmmmmm", m)
                    for a in 1...4000 {
                        for s in 1...4000 {
                                let line = [
                                    "x" : x,
                                    "m" : m,
                                    "a" : a,
                                    "s" : s,
                                ]
                                var nextKey = "in"
                                while nextKey != "A" || nextKey != "R" {
                                    var i = 1
                                    var logicBool: Bool = false
                                    while logicBool != true {
                                        let logic = readLogic(instrustions[tempIndex][i])
                                        if logic[1] == ">" {
                                            logicBool = Int(exactly: line[logic[0]]!)! > Int(logic[2])!
                                        } else {
                                            logicBool = Int(exactly: line[logic[0]]!)! < Int(logic[2])!
                                        }
                                        if logicBool {
                                            nextKey = logic[3]
                                        } else {
                                            if i <= instrustions[tempIndex].count - 3 {
                                                i += 1
                                            } else {
                                                logicBool = true
                                                nextKey = instrustions[tempIndex].last!
                                            }
                                        }
                                    }
                                    if nextKey == "A" {
                                        result += 1
                                        tempIndex = inIndex
                                        break
                                    } else if nextKey == "R" {
                                        tempIndex = inIndex
                                        break
                                    } else {
                                        for i in 0..<instrustions.count {
                                            if instrustions[i][0] == nextKey {
                                                tempIndex = i
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            
            
            return result
        }
        
        func readInstructions(_ depths: Input) -> [[String]] {
            var instuctions: [[String]] = []
            for line in depths {
                if line == "" {
                    break
                } else {
                    let temp = line.components(separatedBy: ["{", "}", ","]).filter({ $0 > "" })
                    instuctions.append(temp)
                }
            }
            
            return instuctions
        }
        
        func readInput(_ depths: Input) -> [[String : Int]] {
            var input: [[String : Int]] = []
            for line in depths.reversed() {
                if line == "" {
                    break
                } else {
                    input.append(
                        [
                            "x" : Int(line.components(separatedBy: ["{", "}", ",", "=" ]).filter({ $0 > "" })[1])!,
                            "m" : Int(line.components(separatedBy: ["{", "}", ",", "=" ]).filter({ $0 > "" })[3])!,
                            "a" : Int(line.components(separatedBy: ["{", "}", ",", "=" ]).filter({ $0 > "" })[5])!,
                            "s" : Int(line.components(separatedBy: ["{", "}", ",", "=" ]).filter({ $0 > "" })[7])!,
                        ]
                    )
                }
            }
            
            return input
        }
        
        func readLogic(_ string: String) -> [String] {
            var logic: [String] = []
            logic.append(String(string[string.startIndex..<string.index(string.startIndex, offsetBy: 1)]))
            logic.append(String(string[string.index(string.startIndex, offsetBy: 1)..<string.index(string.startIndex, offsetBy: 2)]))
            logic.append(String(string[string.index(string.startIndex, offsetBy: 2)..<string.firstIndex(where: { $0 == ":" })!]))
            logic.append(String(string[string.index(string.firstIndex(where: { $0 == ":" })!, offsetBy: 1)..<string.endIndex]))
            return logic
        }
        
    }
}
