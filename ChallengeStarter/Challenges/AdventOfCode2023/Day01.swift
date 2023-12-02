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
    class Day01 : AdventOfCode2023, Solution {
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
            return part01(input)
        }
        
        
        // MARK: - Logic Methods
        func part01(_ depths: Input) -> Output {
            var increases: Int = 0
            for line in depths {
                print(numbers(line), line)
                increases += Int(numbers(line))!
            }
            print("my result in \(depths.count) is", increases)
            return increases
        }
        
        func numbers(_ string: String) -> String {
            var numbersForward: String = ""
            var numbersBehind: String = ""
            let numbersSet: Set<Character> = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
            var tempString = ""
            var i: Int = 0
            while i < string.count {
                if numbersSet.contains(string[string.index(string.startIndex, offsetBy: i)]) {
                    numbersForward.append(String(string[string.index(string.startIndex, offsetBy: i)]))
                    break
                }
                else if string.count - 5 >= i {
                    tempString = String(string[string.index(string.startIndex, offsetBy: i)...string.index(string.startIndex, offsetBy: i + 4)])
                    if tempString == "three" {
                        numbersForward.append("3")
                        break
                    } else if tempString == "seven" {
                        numbersForward.append("7")
                        break
                    } else if tempString == "eight" {
                        numbersForward.append("8")
                        break
                    } else if tempString[tempString.index(tempString.startIndex, offsetBy: 0)...tempString.index(tempString.startIndex, offsetBy: 3)] == "four" {
                        numbersForward.append("4")
                        break
                    } else if tempString[tempString.index(tempString.startIndex, offsetBy: 0)...tempString.index(tempString.startIndex, offsetBy: 3)] == "five" {
                        numbersForward.append("5")
                        break
                    } else if tempString[tempString.index(tempString.startIndex, offsetBy: 0)...tempString.index(tempString.startIndex, offsetBy: 3)] == "nine" {
                        numbersForward.append("9")
                        break
                    } else if tempString[tempString.index(tempString.startIndex, offsetBy: 0)...tempString.index(tempString.startIndex, offsetBy: 2)] == "one" {
                        numbersForward.append("1")
                        break
                    } else if tempString[tempString.index(tempString.startIndex, offsetBy: 0)...tempString.index(tempString.startIndex, offsetBy: 2)] == "two" {
                        numbersForward.append("2")
                        break
                    } else if tempString[tempString.index(tempString.startIndex, offsetBy: 0)...tempString.index(tempString.startIndex, offsetBy: 2)] == "six" {
                        numbersForward.append("6")
                        break
                    } else {
                        i += 1
                    }
                }
                else if string.count - 4 >= i {
                    tempString = String(string[string.index(string.startIndex, offsetBy: i)...string.index(string.startIndex, offsetBy: i + 3)])
                    if tempString == "four" {
                        numbersForward.append("4")
                        break
                    } else if tempString == "five" {
                        numbersForward.append("5")
                        break
                    } else if tempString == "nine" {
                        numbersForward.append("9")
                        break
                    } else if tempString[tempString.index(tempString.startIndex, offsetBy: 0)...tempString.index(tempString.startIndex, offsetBy: 2)] == "one" {
                        numbersForward.append("1")
                        break
                    } else if tempString[tempString.index(tempString.startIndex, offsetBy: 0)...tempString.index(tempString.startIndex, offsetBy: 2)] == "two" {
                        numbersForward.append("2")
                        break
                    } else if tempString[tempString.index(tempString.startIndex, offsetBy: 0)...tempString.index(tempString.startIndex, offsetBy: 2)] == "six" {
                        numbersForward.append("6")
                        break
                    } else {
                        i += 1
                    }
                }
                else if string.count - 3 >= i {
                    tempString = String(string[string.index(string.startIndex, offsetBy: i)...string.index(string.startIndex, offsetBy: i + 2)])
                    if tempString == "one" {
                        numbersForward.append("1")
                        break
                    } else if tempString == "two" {
                        numbersForward.append("2")
                        break
                    } else if tempString == "six" {
                        numbersForward.append("6")
                        break
                    } else {
                        i += 1
                    }
                } else {
                    i += 1
                }
            }
            i = string.count - 1
            while i > -1 {
                if numbersSet.contains(string[string.index(string.startIndex, offsetBy: i)]) {
                    numbersBehind.append(String(string[string.index(string.startIndex, offsetBy: i)]))
                    break
                }
                else if i >= 4 {
                    if String(string[string.index(string.startIndex, offsetBy: i - 2)...string.index(string.startIndex, offsetBy: i)]) == "one" {
                        numbersBehind.append("1")
                        break
                    } else if String(string[string.index(string.startIndex, offsetBy: i - 2)...string.index(string.startIndex, offsetBy: i)]) == "two" {
                        numbersBehind.append("2")
                        break
                    } else if String(string[string.index(string.startIndex, offsetBy: i - 2)...string.index(string.startIndex, offsetBy: i)]) == "six" {
                        numbersBehind.append("6")
                        break
                    } else if  String(string[string.index(string.startIndex, offsetBy: i - 3)...string.index(string.startIndex, offsetBy: i)]) == "four" {
                        numbersBehind.append("4")
                        break
                    } else if String(string[string.index(string.startIndex, offsetBy: i - 3)...string.index(string.startIndex, offsetBy: i)]) == "five" {
                        numbersBehind.append("5")
                        break
                    } else if String(string[string.index(string.startIndex, offsetBy: i - 3)...string.index(string.startIndex, offsetBy: i)]) == "nine" {
                        numbersBehind.append("9")
                        break
                    } else if String(string[string.index(string.startIndex, offsetBy: i - 4)...string.index(string.startIndex, offsetBy: i)]) == "three" {
                        numbersBehind.append("3")
                        break
                    } else if String(string[string.index(string.startIndex, offsetBy: i - 4)...string.index(string.startIndex, offsetBy: i)]) == "seven" {
                        numbersBehind.append("7")
                        break
                    } else if String(string[string.index(string.startIndex, offsetBy: i - 4)...string.index(string.startIndex, offsetBy: i)]) == "eight" {
                        numbersBehind.append("8")
                        break
                    } else {
                        i -= 1
                    }
                }
                else if i >= 3 {
                    tempString = String(string[string.index(string.startIndex, offsetBy: i - 2)...string.index(string.startIndex, offsetBy: i)])
                    if String(string[string.index(string.startIndex, offsetBy: i - 2)...string.index(string.startIndex, offsetBy: i)]) == "one" {
                        numbersBehind.append("1")
                        break
                    } else if String(string[string.index(string.startIndex, offsetBy: i - 2)...string.index(string.startIndex, offsetBy: i)]) == "two" {
                        numbersBehind.append("2")
                        break
                    } else if String(string[string.index(string.startIndex, offsetBy: i - 2)...string.index(string.startIndex, offsetBy: i)]) == "six" {
                        numbersBehind.append("6")
                        break
                    } else if String(string[string.index(string.startIndex, offsetBy: i - 3)...string.index(string.startIndex, offsetBy: i)]) == "four" {
                        numbersBehind.append("4")
                        break
                    } else if String(string[string.index(string.startIndex, offsetBy: i - 3)...string.index(string.startIndex, offsetBy: i)]) == "five" {
                        numbersBehind.append("5")
                        break
                    } else if String(string[string.index(string.startIndex, offsetBy: i - 3)...string.index(string.startIndex, offsetBy: i)]) == "nine" {
                        numbersBehind.append("9")
                        break
                    } else {
                        i -= 1
                    }
                }
                else if i >= 2 {
                    tempString = String(string[string.index(string.startIndex, offsetBy: i - 2)...string.index(string.startIndex, offsetBy: i)])
                    if tempString == "one" {
                        numbersBehind.append("1")
                        break
                    } else if tempString == "two" {
                        numbersBehind.append("2")
                        break
                    } else if tempString == "six" {
                        numbersBehind.append("6")
                        break
                    } else {
                        i -= 1
                    }
                }
                else {
                    i -= 1
                }
            }
        return "\(numbersForward[numbersForward.startIndex])\(numbersBehind[numbersBehind.startIndex])"
            
        }
    }
}
