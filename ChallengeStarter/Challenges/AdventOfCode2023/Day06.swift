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
    class Day06 : AdventOfCode2023, Solution {
        // MARK: - Type Aliases
        typealias Input = [[Any]]
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
            var depths: [[Any]] = []
            for i in rawInput.components(separatedBy: .newlines) {
                if i != "" {
                    let temp = i.components(separatedBy: " ")
//                    print("temp", temp)
                    depths.append([
                        Int(temp[1])!,
                        diff(temp[0]),
                        check(diff(temp[0])),
                        checkValue(String(temp[0][temp[0].startIndex])),
                        checkValue(String(temp[0][temp[0].index(temp[0].startIndex, offsetBy: 1)])),
                        checkValue(String(temp[0][temp[0].index(temp[0].startIndex, offsetBy: 2)])),
                        checkValue(String(temp[0][temp[0].index(temp[0].startIndex, offsetBy: 3)])),
                        checkValue(String(temp[0][temp[0].index(temp[0].startIndex, offsetBy: 4)])),
                        temp[0]
                                          ])
                }
            }
            let increases = rawOutput?.integerList()[0]
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
            let inputSorted = depths.sorted(by:{ (diff0, diff1) -> Bool in
                if diff1[2] as! Int == diff0[2] as! Int {
                    if diff1[3] as! Int == diff0[3] as! Int {
                        if diff1[4] as! Int == diff0[4] as! Int {
                            if diff1[5] as! Int == diff0[5] as! Int {
                                if diff1[6] as! Int == diff0[6] as! Int {
                                    return diff1[7] as! Int > diff0[7] as! Int
                                }
                                return diff1[6] as! Int > diff0[6] as! Int
                            }
                            return diff1[5] as! Int > diff0[5] as! Int
                        }
                        return diff1[4] as! Int > diff0[4] as! Int
                    }
                    return diff1[3] as! Int > diff0[3] as! Int
                }
                return diff1[2] as! Int > diff0[2] as! Int
            })
            for i in 0..<inputSorted.count {
                increases += (i + 1) * (inputSorted[i][0] as! Int)
            }
                    
            return increases
        }
        
        func part02(_ depths: Input) -> Output {
            var increases = 0
            let inputSorted = depths.sorted(by:{ (diff0, diff1) -> Bool in
                if diff1[2] as! Int == diff0[2] as! Int {
                    if diff1[3] as! Int == diff0[3] as! Int {
                        if diff1[4] as! Int == diff0[4] as! Int {
                            if diff1[5] as! Int == diff0[5] as! Int {
                                if diff1[6] as! Int == diff0[6] as! Int {
                                    return diff1[7] as! Int > diff0[7] as! Int
                                }
                                return diff1[6] as! Int > diff0[6] as! Int
                            }
                            return diff1[5] as! Int > diff0[5] as! Int
                        }
                        return diff1[4] as! Int > diff0[4] as! Int
                    }
                    return diff1[3] as! Int > diff0[3] as! Int
                }
                return diff1[2] as! Int > diff0[2] as! Int
            })
            for hand in inputSorted {
                print(hand)
            }
            for i in 0..<inputSorted.count {
                increases += (i + 1) * (inputSorted[i][0] as! Int)
            }
                    
            return increases
        }
        
        func diff(_ string: String) -> Array<(key: Int, value: Int)> {
            var diff: [Int:Int] = [:]
            for ch in string {
                switch ch {
                case "A":
                    if diff.keys.contains(14) {
                        diff[14]! += 1
                    } else {
                        diff[14] = 1
                    }
                case "K":
                    if diff.keys.contains(13) {
                        diff[13]! += 1
                    } else {
                        diff[13] = 1
                    }
                case "Q":
                    if diff.keys.contains(12) {
                        diff[12]! += 1
                    } else {
                        diff[12] = 1
                    }
                case "J":
                    if diff.keys.contains(11) {
                        diff[11]! += 1
                    } else {
                        diff[11] = 1
                    }
                case "T":
                    if diff.keys.contains(10) {
                        diff[10]! += 1
                    } else {
                        diff[10] = 1
                    }
                case "9":
                    if diff.keys.contains(9) {
                        diff[9]! += 1
                    } else {
                        diff[9] = 1
                    }
                case "8":
                    if diff.keys.contains(8) {
                        diff[8]! += 1
                    } else {
                        diff[8] = 1
                    }
                case "7":
                    if diff.keys.contains(7) {
                        diff[7]! += 1
                    } else {
                        diff[7] = 1
                    }
                case "6":
                    if diff.keys.contains(6) {
                        diff[6]! += 1
                    } else {
                        diff[6] = 1
                    }
                case "5":
                    if diff.keys.contains(5) {
                        diff[5]! += 1
                    } else {
                        diff[5] = 1
                    }
                case "4":
                    if diff.keys.contains(4) {
                        diff[4]! += 1
                    } else {
                        diff[4] = 1
                    }
                case "3":
                    if diff.keys.contains(3) {
                        diff[3]! += 1
                    } else {
                        diff[3] = 1
                    }
                case "2":
                    if diff.keys.contains(2) {
                        diff[2]! += 1
                    } else {
                        diff[2] = 1
                    }
                default:
                    0
                }
                
            }
            return diff.sorted { $0.value > $1.value }
        }
        func checkValue(_ ch: String) -> Int {
            switch ch {
                case "A":
                    return 14
                case "K":
                    return 13
                case "Q":
                    return 12
                case "J":
                    return 1
                case "T":
                    return 10
                case "9":
                    return 9
                case "8":
                    return 8
                case "7":
                    return 7
                case "6":
                    return 6
                case "5":
                    return 5
                case "4":
                    return 4
                case "3":
                    return 3
                case "2":
                    return 2
                default:
                    return 0
                }
        }
        
        
        func check (_ diff: Array<(key: Int, value: Int)>) -> Int {
            var input = diff
            for item in (0..<input.count).reversed() {
                if input[item].key == 11 && input[item].value != 5 {
                    let a = input[item].key
                    let b = input[item].value
                    input.remove(at: item)
                    input.append((key: a, value: b))
                    input[0].value += b
                }
            }
            if input[0].value == 5 {
                return 10000000
            }
            else if input[0].value == 4 {
                return 1000000
            }
            else if input[0].value == 3 && input[1].value == 2 {
                return 100000
            }
            else if input[0].value == 3 {
                return 10000
            }
            else if input[0].value == 2 && input[1].value == 2 {
                return 1000
            }
            else if input[0].value == 2 {
                return 100
            }
            else {
                return 1
            }
        }
    }
}
