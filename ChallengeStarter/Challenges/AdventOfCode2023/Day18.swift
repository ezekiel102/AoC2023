import ChallengeBase
import Foundation

extension AdventOfCode2023 {
    class Day18 : AdventOfCode2023, Solution {
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
            var result = 0
            var input: [[String]] = []
//            for line in depths {
//                var dir = line.components(separatedBy: .whitespaces)[2].removeLast()
//                dir.removeFirst()
//                let move = dir
//                input.append(line.components(separatedBy: .whitespaces) +  + deci)
//
//            }
            for line in input {
                print(line)
            }
            let m = masMN(input).0 - masMN(input).2 - 1, n = masMN(input).1 - masMN(input).3 - 1
            print(masMN(input))
            var output: [[Character]] = []
            for i in 0...n {
                output.append([])
                for _ in 0...m {
                    output[i].append(".")
                }
            }
            print(output.count, output[0].count)
            var point = (-masMN(input).3 - 1, -masMN(input).2 - 1)
            output[point.0][point.1] = "#"
            for line in input {
                if line[0] == "R" {
//                    print(point,Int(line[1])!)
                    for j in 1...Int(line[1])! {
                        output[point.0][point.1 + j] = "#"
                    }
                    point = (point.0,point.1 + Int(line[1])!)
                }
                if line[0] == "L" {
                    //print(point)
                    for j in 1...Int(line[1])! {
                        output[point.0][point.1 - j] = "#"
                    }
                    point = (point.0,point.1 - Int(line[1])!)
                }
                if line[0] == "U" {
//                    print(point, Int(line[1])!)
                    for j in 1...Int(line[1])! {
                        output[point.0 - j][point.1] = "#"
                    }
                    point = (point.0 - Int(line[1])!,point.1)
                }
                if line[0] == "D" {
                    //print(point)
                    for j in 1...Int(line[1])! {
                        output[point.0 + j][point.1] = "#"
                    }
                    point = (point.0 + Int(line[1])!,point.1)
                }
            }
//            for line in output {
//                print(line)
//            }
            for i in 0...n {
                var j = 0
                while output[i][j] != "#" && output[i][j] != "$" && j < m {
                    output[i][j] = "$"
//                    result += 1
                    j += 1
                }
                j = m
                while output[i][j] != "#" && output[i][j] != "$" && j > -1 {
                    output[i][j] = "$"
//                    result += 1
                    j -= 1
                }
            }
            for j in 0...m {
                var i = 0
                while output[i][j] != "#" && output[i][j] != "$" && i < n {
                    output[i][j] = "$"
//                    result += 1
                    i += 1
                }
                i = n
                while output[i][j] != "#" && output[i][j] != "$" && i > -1 {
                    output[i][j] = "$"
//                    result += 1
                    i -= 1
                }
            }
            for _ in 0...300 {
                for i in 0...n {
                    for j in 0...m {
                        if output[i][j] == "." {
                            delete(&output, i: i, j: j)
                        }
                    }
                }
            }
            for i in 0...n {
                for j in 0...m {
                    if output[i][j] == "." || output[i][j] == "#" {
                        result += 1
                    }
                }
            }
//            for line in output {
//                print(line)
//            }
            return result //(m+1)*(n+1)-result
            
        }
        
        func part02(_ depths: Input) -> Output {
            var result = 0
            var input: [[Int]] = []
            for line in depths {
                print(line)
                var dir = line.components(separatedBy: .whitespaces)[2]
                dir.removeFirst()
                dir.removeFirst()
                dir.removeLast()
                let c = dir.removeLast()
                var dirC = Int(String(c))!
                let move = Int(dir, radix: 16)!
                print(dirC, move)
                input.append([dirC, move])
                
            }
            
            return result
        }
        
        func masMN(_ input: [[String]]) -> (Int, Int, Int, Int) {
            var m = 0, maxM = 0, minM = 0
            var n = 0, maxN = 0, minN = 0
            for line in input {
                if line[0] == "R" {
                    m += Int(line[1])!
                    if m > maxM {
                        maxM = m
                    }
                }
                if line[0] == "L" {
                    m -= Int(line[1])!
                    if m < minM {
                        minM = m
                    }
                }
                if line[0] == "U" {
                    n -= Int(line[1])!
                    if n < minN {
                        minN = n
                    }
                }
                if line[0] == "D" {
                    n += Int(line[1])!
                    if n > maxN {
                        maxN = n
                    }
                }
            }
            return (maxM, maxN, minM - 1, minN - 1)
        }
        
        func delete(_ output: inout [[Character]], i: Int, j: Int) {
            let aT = i == 0 ? 0 : i - 1
            let aB = i == output.count - 1 ? i : i + 1
            let aL = j == 0 ? 0 : j - 1
            let aR = j == output[i].count - 1 ? j : j + 1
            for a in aT...aB {
                for b in aL...aR {
                    if output[a][b] == "$" {
                        output[i][j] = "$"
                        break
                    }
                }
            }
            
        }
    }
}

//34229
