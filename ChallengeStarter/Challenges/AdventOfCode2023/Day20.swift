import ChallengeBase
import Foundation

extension AdventOfCode2023 {
    class Day20 : AdventOfCode2023, Solution {
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
            var ins = readInstructions(depths)
            print(ins)
            var insStack: [(String, String)] = []
            for ch in ins["broadcaster"]! {
                insStack.append((String(ch), String("low")))
            }
            var highLow = ["low"]
            for i in 0..<insStack.count {
                let stack = insStack.removeFirst()
                highLow.append("high")
                print(stack)
                let next = 1
            }
            return result
        }
        
        func part02(_ depths: Input) -> Output {
            var result = 0
            
            return result
        }
        
        func readInstructions(_ depths: Input) -> [String : [String]] {
            var instructions: [String : [String]] = [:]
            for line in depths {
                var temp = line.components(separatedBy: [" ", ",", "-", ">"]).filter { $0 > "" }
                if temp[0] == "broadcaster" {
                    temp.removeFirst()
                    instructions["broadcaster"] = temp
                } else  {
                    if temp[0].first == "%" {
                        temp[0].removeFirst()
                        instructions[temp[0]] = ["0"] + [temp[1]]
                    } else if temp[0].first == "&" {
                        temp[0].removeFirst()
                        instructions[temp[0]] = [""] + [temp[1]]
                    }
                }
            }
            
            return instructions
        }
    }
}
