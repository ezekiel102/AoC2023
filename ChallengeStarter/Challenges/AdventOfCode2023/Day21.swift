import ChallengeBase
import Foundation

extension AdventOfCode2023 {
    class Day21 : AdventOfCode2023, Solution {
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
            let inp = rawInput.components(separatedBy: .newlines)
            var depths: [[Character]] = []
            for pattern in inp {
                depths.append(Array(pattern))
            }
            let increases = rawOutput?.integerList()[0]
            depths.removeLast()
            return (depths, increases)
        }
        
        // Step 2: Activate
        func activate(_ input: Input, algorithm: Algorithms) -> Output {
            
            switch algorithm {
            case .part01:
                return part01(input, 101, 27) - part01(input, 100, 27)
            case .part02:
                return part02(input)
            }
            
        }
        
        // MARK: - Logic Methods
        func part01(_ depthsOne: Input,_ n: Int,_ k: Int) -> Output {
            var depths: [[Character]] = []
            var depthsTwo = depthsOne
            depthsTwo[findStart(depthsOne).0][findStart(depthsOne).1] = "."
            for _ in 0..<k {
                for line in depthsTwo {
                    var lin: [Character] = []
                    for _ in 0..<k {
                        lin += line
                    }
                    depths.append(lin)
                }
            }
            print(depths.count, depths[0].count)
            if depths.count % 2 == 0 {
                depths[depths.count / 2][depths[0].count / 2] = "S"
            } else {
                depths[depths.count / 2][depths[0].count / 2] = "S"
            }
            var result = 0
            var currentPositions = [findStart(depths)]
            var previousPositions: [(Int, Int)] = []
            var steps = 0
            while steps < n {
                steps += 1
                var stepPositions: [(Int, Int)] = []
                while !currentPositions.isEmpty {
                    let pos = currentPositions.removeFirst()
                    let temp = nextStart(depths, pos)
                    for t in temp {
                        if !stepPositions.contains(where: { $0 == t }) {
                            stepPositions.append(t)
                        }
                    }
                    previousPositions.append(pos)
                }
                currentPositions = stepPositions
            }
            return currentPositions.count
        }
        
        func part02(_ depths: Input) -> Output {
            //var result = 0
            
            return 0
        }
        
        func findStart(_ depths: Input) -> (Int, Int) {
            for i in 0..<depths.count {
                for j in 0..<depths[0].count {
                    if depths[i][j] == "S" {
                        return (i, j)
                    }
                }
            }
            
            return (0, 0)
        }
        
        func nextStart(_ depths: Input,_ current: (Int, Int)) -> [(Int, Int)] {
            var positions: [(Int, Int)] = []
            
            let aT = current.0 == 0 ? 0 : current.0 - 1
            let aB = current.0 == depths.count - 1 ? current.0 : current.0 + 1
            let aL = current.1 == 0 ? 0 : current.1 - 1
            let aR = current.1 == depths[current.0].count - 1 ? current.1 : current.1 + 1
            
            if (depths[current.0][aL] == "." || depths[current.0][aL] == "S")  && (current.0, aL) != current {
                positions.append((current.0, aL))
            }
            if (depths[current.0][aR] == "." || depths[current.0][aR] == "S") && (current.0, aR) != current {
                positions.append((current.0, aR))
            }
            if (depths[aT][current.1] == "." || depths[aT][current.1] == "S") && (aT, current.1) != current {
                positions.append((aT, current.1))
            }
            if (depths[aB][current.1] == "." || depths[aB][current.1] == "S") && (aB, current.1) != current {
                positions.append((aB, current.1))
            }
            
            
            return positions
        }
    }
}
