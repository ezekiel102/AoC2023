//
//
//  Solution00.swift
//  ChallengeStarter
//
//  Created by you on 2022-11-25.
//
//

import ChallengeBase
import Foundation

extension AdventOfCode2023 {
    class Day03 : AdventOfCode2023, Solution {
        // MARK: - Type Aliases
        typealias Input = [[String]]
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
            
            let numbersSet: Set<Character> = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "."]
            var characterSet: Array<String> = []
            
            var depths: [[String]] = [[]]
            
            for i in 1...rawInput.components(separatedBy: .newlines).count {
                depths.append([])
                for ch in rawInput.components(separatedBy: .newlines)[i - 1] {
                    depths[i].append(String(ch))
                    if !numbersSet.contains(String(ch)) && !characterSet.contains(String(ch)) {
                        characterSet.append(String(ch))
                    }
                }
            }
            
            let increases = rawOutput?.integerList()[0]
            depths.removeFirst()
            depths.removeLast()
            depths.append(characterSet)
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
            var input = depths
            let control = input.removeLast()
            let m = input[0].count
            let n = input.count
            var increases: Int = 0
            increases += firstLine(Array(input[0...1]), control, m)
            for line in 1...n - 2 {
                increases += middleLine(Array(input[line - 1...line + 1]), control, m)
            }
            increases += lastLine(Array(input[n - 2...n - 1]), control, m)
            return increases
        }
        
        func part02(_ depths: Input) -> Output {
            var input = depths
            let control = input.removeLast()
            let m = input[0].count
            let n = input.count
            var increases: Int = 0
            for i in 0..<n {
                for j in 0..<m {
                    if depths[i][j] == "*" {
                        increases += Int(multiplyCheck(input, iM: i, iN: j, control))
                    }
                }
            }
            return increases
        }
        
        func firstLine(_ depths: [ [String]], _ control: [String], _ m: Int) -> Int {
            var result: Int = 0
            let numbersSet: Set<Character> = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
            var tempNumberString = ""
            var testSymbols = 0
            var iStart = 0, iEnd = 0
            for i in 0..<m {
                if numbersSet.contains(depths[0][i]) && tempNumberString == "" {
                    iStart = i > 1 ? i - 1 : 0
                    tempNumberString.append(String(depths[0][i]))
                } else if numbersSet.contains(depths[1][i]) && tempNumberString != "" && i == m - 1 {
                    tempNumberString.append(String(depths[1][i]))
                    iEnd = i
//                    print("konec", tempNumberString)
//                    print("iStart", iStart, "iEnd", iEnd, depths[1][iEnd])
                    if control.contains(depths[1][iStart]) || control.contains(depths[1][iEnd]) {
                        testSymbols += 1
                    }
                    for iT in iStart...iEnd {
                        if control.contains(depths[1][iT]) {
                            testSymbols += 1
                        }
                    }
//                    print("test", testSymbols)
                    if testSymbols > 0 {
                        result += Int(tempNumberString)!
                        tempNumberString = ""; iStart = 0; iEnd = 0; testSymbols = 0
                    } else {
                        tempNumberString = ""; iStart = 0; iEnd = 0; testSymbols = 0
                    }
                } else if numbersSet.contains(depths[0][i]) && tempNumberString != "" {
                    tempNumberString.append(String(depths[0][i]))
                } else if !numbersSet.contains(depths[0][i]) && tempNumberString != "" {
                    iEnd = i
                    //print("temp", tempNumberString)
                    if control.contains(depths[0][iStart]) || control.contains(depths[0][iEnd]) {
                        testSymbols += 1
                    }
                    for iT in iStart...iEnd {
                        if control.contains(depths[1][iT]) {
                            testSymbols += 1
                        }
                    }
                    //print("test", testSymbols)
                    if testSymbols > 0 {
                        result += Int(tempNumberString)!
                        tempNumberString = ""; iStart = 0; iEnd = 0; testSymbols = 0
                    } else {
                        tempNumberString = ""; iStart = 0; iEnd = 0; testSymbols = 0
                    }
                }
            }
            //print("first", result)
            return result
        }
        func lastLine(_ depths: [ [String]], _ control: [String], _ m: Int) -> Int {
            var result: Int = 0
            let numbersSet: Set<Character> = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
            var tempNumberString = ""
            var testSymbols = 0
            var iStart = 0, iEnd = 0
            for i in 0..<m {
                if numbersSet.contains(depths[1][i]) && tempNumberString == "" {
                    iStart = i > 1 ? i - 1 : 0
                    tempNumberString.append(String(depths[1][i]))
                } else if numbersSet.contains(depths[1][i]) && tempNumberString != "" && i == m - 1 {
                    tempNumberString.append(String(depths[1][i]))
                    iEnd = i
//                    print("konec", tempNumberString)
//                    print("iStart", iStart, "iEnd", iEnd, depths[1][iEnd])
                    if control.contains(depths[1][iStart]) || control.contains(depths[1][iEnd]) {
                        testSymbols += 1
                    }
                    for iT in iStart...iEnd {
                        if control.contains(depths[0][iT]) {
                            testSymbols += 1
                        }
                    }
//                    print("test", testSymbols)
                    if testSymbols > 0 {
                        result += Int(tempNumberString)!
                        tempNumberString = ""; iStart = 0; iEnd = 0; testSymbols = 0
                    } else {
                        tempNumberString = ""; iStart = 0; iEnd = 0; testSymbols = 0
                    }
                } else if numbersSet.contains(depths[1][i]) && tempNumberString != "" {
                    tempNumberString.append(String(depths[1][i]))
                } else if !numbersSet.contains(depths[1][i]) && tempNumberString != "" {
                    iEnd = i
                    //print("temp", tempNumberString)
                    if control.contains(depths[1][iStart]) || control.contains(depths[1][iEnd]) {
                        testSymbols += 1
                    }
                    for iT in iStart...iEnd {
                        if control.contains(depths[0][iT]) {
                            testSymbols += 1
                        }
                    }
                    //print("test", testSymbols)
                    if testSymbols > 0 {
                        result += Int(tempNumberString)!
                        tempNumberString = ""; iStart = 0; iEnd = 0; testSymbols = 0
                    } else {
                        tempNumberString = ""; iStart = 0; iEnd = 0; testSymbols = 0
                    }
                }
            }
            //print("last", result)
            return result
        }
        func middleLine(_ depths: [ [String]], _ control: [String], _ m: Int) -> Int {
            var result: Int = 0
            let numbersSet: Set<Character> = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
            var tempNumberString = ""
            var testSymbols = 0
            var iStart = 0, iEnd = 0
            for i in 0..<m {
                if numbersSet.contains(depths[1][i]) && tempNumberString == "" {
                    iStart = i > 1 ? i - 1 : 0
                    tempNumberString.append(String(depths[1][i]))
//                    print(tempNumberString)
                } else if numbersSet.contains(depths[1][i]) && tempNumberString != "" && i == m - 1 {
                    tempNumberString.append(String(depths[1][i]))
                    iEnd = i
//                    print("konec", tempNumberString)
//                    print("iStart", iStart, "iEnd", iEnd, depths[1][iEnd])
                    if control.contains(depths[1][iStart]) || control.contains(depths[1][iEnd]) {
                        testSymbols += 1
                    }
                    for iT in iStart...iEnd {
                        if control.contains(depths[0][iT]) {
                            testSymbols += 1
                        }
                    }
                    for iT in iStart...iEnd {
                        if control.contains(depths[2][iT]) {
                            testSymbols += 1
                        }
                    }
//                    print("test", testSymbols)
                    if testSymbols > 0 {
                        result += Int(tempNumberString)!
                        tempNumberString = ""; iStart = 0; iEnd = 0; testSymbols = 0
                    } else {
                        tempNumberString = ""; iStart = 0; iEnd = 0; testSymbols = 0
                    }
                } else if numbersSet.contains(depths[1][i]) && tempNumberString != "" {
                    tempNumberString.append(String(depths[1][i]))
//                    print(tempNumberString)
                } else if !numbersSet.contains(depths[1][i]) && tempNumberString != "" {
                    iEnd = i
//                    print("temp", tempNumberString)
//                    print("iStart", iStart, "iEnd", iEnd, depths[1][iEnd])
                    if control.contains(depths[1][iStart]) || control.contains(depths[1][iEnd]) {
                        testSymbols += 1
                    }
                    for iT in iStart...iEnd {
                        if control.contains(depths[0][iT]) {
                            testSymbols += 1
                        }
                    }
                    for iT in iStart...iEnd {
                        if control.contains(depths[2][iT]) {
                            testSymbols += 1
                        }
                    }
//                    print("test", testSymbols)
                    if testSymbols > 0 {
                        result += Int(tempNumberString)!
                        tempNumberString = ""; iStart = 0; iEnd = 0; testSymbols = 0
                    } else {
                        tempNumberString = ""; iStart = 0; iEnd = 0; testSymbols = 0
                    }
                }
            }
            
//            print("middle", result)
            return result
        }
        
        
        
        func multiplyCheck(_ depths: [[String]], iM: Int, iN: Int, _ control: [String]) -> Int {
            var result: Int = 0
            var multys: [String] = []
            let numbersSet: Set<Character> = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
            var control2: CharacterSet = ["."]
            for ch in control {
                control2.insert(UnicodeScalar(ch)!)
            }
            if numbersSet.contains(depths[iM - 1][iN - 1]) && numbersSet.contains(depths[iM - 1][iN - 2]) || numbersSet.contains(depths[iM - 1][iN + 1]) && numbersSet.contains(depths[iM - 1][iN + 2]) {
                if numbersSet.contains(depths[iM - 1][iN - 1]) {
                    for ch in depths[iM - 1][iN - 3...iN].joined().components(separatedBy: control2) {
                        if ch != "" {
                            multys.append(ch)
                        }
                    }
                }
                if numbersSet.contains(depths[iM - 1][iN + 1]) {
                    for ch in depths[iM - 1][iN...iN + 3].joined().components(separatedBy: control2) {
                        if ch != "" {
                            multys.append(ch)
                        }
                    }
                }
            } else if numbersSet.contains(depths[iM - 1][iN - 1]) || numbersSet.contains(depths[iM - 1][iN + 1]) || numbersSet.contains(depths[iM - 1][iN]) {
                for ch in depths[iM - 1][iN - 1...iN + 1].joined().components(separatedBy: control2) {
                    if ch != "" {
                        multys.append(ch)
                    }
                }
            }
            if numbersSet.contains(depths[iM + 1][iN - 1]) && numbersSet.contains(depths[iM + 1][iN - 2]) || numbersSet.contains(depths[iM + 1][iN + 1]) && numbersSet.contains(depths[iM + 1][iN + 2]) {
                if numbersSet.contains(depths[iM + 1][iN - 1]) {
                    for ch in depths[iM + 1][iN - 3...iN].joined().components(separatedBy: control2) {
                        if ch != "" {
                            multys.append(ch)
                        }
                    }
                }
                if numbersSet.contains(depths[iM + 1][iN + 1]) {
                    for ch in depths[iM + 1][iN...iN + 3].joined().components(separatedBy: control2) {
                        if ch != "" {
                            multys.append(ch)
                        }
                    }
                }
            } else if numbersSet.contains(depths[iM + 1][iN - 1]) || numbersSet.contains(depths[iM + 1][iN + 1]) || numbersSet.contains(depths[iM + 1][iN]) {
                for ch in depths[iM + 1][iN - 1...iN + 1].joined().components(separatedBy: control2) {
                    if ch != "" {
                        multys.append(ch)
                    }
                }
            }
            if numbersSet.contains(depths[iM][iN + 1]) {
                for ch in depths[iM][iN + 1...iN + 3].joined().components(separatedBy: control2) {
                    if ch != "" {
                        multys.append(ch)
                    }
                }
            }
            if numbersSet.contains(depths[iM][iN - 1]) {
                for ch in depths[iM][iN - 3...iN - 1].joined().components(separatedBy: control2) {
                    if ch != "" {
                        multys.append(ch)
                    }
                }
            }
            if multys.count <= 1 {
                result = 0
            } else {
                result = Int(multys[0])! * Int(multys[1])!
            }
            return result
        }
    }
}
