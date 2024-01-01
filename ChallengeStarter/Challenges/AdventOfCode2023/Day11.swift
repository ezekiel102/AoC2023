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
    class Day11 : AdventOfCode2023, Solution {
        // MARK: - Type Aliases
        typealias Input = [[Character]]
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
            var depths: [[Character]] = []
            
            for line in rawInput.components(separatedBy: .newlines) {
                depths.append(Array(line))
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
        func part01(_ inp: Input) -> Output {
            var depths = inp
//            print(newLines(inp))
//            print(newColomns(inp))
//            print(galaxies(inp))
            inserting(&depths)
//            var increases: [(Int, Int)] = galaxies(depths)
//            print(increases)
//            for str in depths {
//                print(str)
//            }
//            print(findResult(galaxies(depths)))
//            print()
            return findResult(galaxies(depths))
        }
        
        func part02(_ depths: Input) -> Output {
            
            return findResult2(galaxies(depths), newL: newLines(depths), newC: newColomns(depths), t: 999999)
        }
        
        
        func inserting(_ depths: inout [[Character]]) {
            let newLine: [Character] = .init(repeating: ".", count: depths.count)
            var newLines: [Int] = []
            for i in 0..<depths.count {
                if !depths[i].contains("#") {
                    newLines.append(i)
                }
            }
            while newLines.count != 0 {
                depths.insert(newLine, at: newLines[0])
                newLines.removeFirst()
                for i in 0..<newLines.count {
                    newLines[i] += 1
                }
            }
            var newColomn: [Int] = []
            for j in 0..<depths[0].count {
                if depths[0][j] == "." {
                    newColomn.append(j)
                }
            }
            for i in 1..<depths.count {
                for j in 0..<depths[i].count {
                    if depths[i][j] == "#" && newColomn.contains(j) {
                        newColomn.remove(at: newColomn.firstIndex { $0 == j }!)
                    }
                }
            }
            while newColomn.count != 0 {
                for i in 0..<depths.count {
                    for j in 0..<depths[i].count {
                        if j == newColomn[0] {
                            depths[i].insert(".", at: j)
                        }
                    }
                }
                newColomn.removeFirst()
                for i in 0..<newColomn.count {
                    newColomn[i] += 1
                }
            }
        }
        
        func newLines(_ depths: [[Character]]) -> [Int] {
            var newLines: [Int] = []
            for i in 0..<depths.count {
                if !depths[i].contains("#") {
                    newLines.append(i)
                }
            }
            return newLines
        }
        
        func newColomns(_ depths: [[Character]]) -> [Int] {
            var newColomns: [Int] = []
            for j in 0..<depths[0].count {
                if depths[0][j] == "." {
                    newColomns.append(j)
                }
            }
            for i in 1..<depths.count {
                for j in 0..<depths[i].count {
                    if depths[i][j] == "#" && newColomns.contains(j) {
                        newColomns.remove(at: newColomns.firstIndex { $0 == j }!)
                    }
                }
            }
            return newColomns
        }
        
        func galaxies(_ depths: [[Character]]) -> [(Int, Int)] {
            var gax: [(Int, Int)] = []
            for i in 0..<depths.count {
                for j in 0..<depths[i].count {
                    if depths[i][j] == "#" {
                        gax.append((i,j))
                    }
                }
            }
            return gax
        }
        
        func findResult(_ inp: [(Int, Int)]) -> Int {
            var result = 0
            var k = 0
            for i in 0..<inp.count {
                for j in i + 1..<inp.count {
                    result += abs(inp[i].0 - inp[j].0) + abs(inp[i].1 - inp[j].1)
                    k += 1
                }
            }
            return result
        }
        
        func findResult2(_ inp: [(Int, Int)], newL: [Int], newC: [Int], t: Int) -> Int {
            var result = 0
            var kL = 0, kC = 0
            var e = 0
            for i in 0..<inp.count {
                for j in i + 1..<inp.count {
                    let a = inp[i].0 > inp[j].0 ? inp[j].0...inp[i].0 : inp[i].0...inp[j].0
                    let b = inp[i].1 > inp[j].1 ? inp[j].1...inp[i].1 : inp[i].1...inp[j].1
                    for i in 0..<newL.count {
                        if a.contains(newL[i])  {
                            kL += t
                            e += 1
                        }
                    }
                    for i in 0..<newC.count {
                        if b.contains(newC[i]) {
                            kC += t
                            e += 1
                        }
                    }
                    result += abs(inp[i].0 - inp[j].0) + kL + kC + abs(inp[i].1 - inp[j].1)
                    kC = 0
                    kL = 0
                }
            }
            print(e)
            return result
        }
    }
}

//9312968
