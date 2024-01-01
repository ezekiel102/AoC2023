import ChallengeBase
import Foundation

extension AdventOfCode2023 {
    class Day23 : AdventOfCode2023, Solution {
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
            let labirint = readInput(depths)
            var startRoad = [(0, 1), (1, 1)]
            while checkEndRoad(labirint, point: startRoad.last!) == nil {
                startRoad.append(nextPoint(labirint, startRoad.last!, startRoad))
            }
            startRoad += checkEndRoad(labirint, point: startRoad.last!)!
            print(startRoad, startRoad.count)
            var endPoint = (labirint.count - 1, labirint[0].count - 2)
            var leftRoads: [[(Int, Int)]] = []
            for i in 1..<labirint.count - 1 {
                for j in 1..<labirint[i].count - 1 {
                    if leftRoad(labirint, point: (i, j)) != nil {
                        leftRoads.append(leftRoad(labirint, point: (i, j))!)
                    }
                }
            }
            var downRoads: [[(Int, Int)]] = []
            for i in 1..<labirint.count - 1 {
                for j in 1..<labirint[i].count - 1 {
                    if downRoad(labirint, point: (i, j)) != nil {
                        downRoads.append(downRoad(labirint, point: (i, j))!)
                        
                    }
                }
            }
            var endRoad = downRoads.removeLast()
            while endRoad.last!.0 != labirint.count - 1 && endRoad.last!.1 != labirint[0].count - 2 {
                endRoad.append(nextPoint(labirint, endRoad.last!, endRoad))
            }
            print(endRoad, endRoad.count)
            
            for i in 0..<leftRoads.count {
                while checkEndRoad(labirint, point: leftRoads[i].last!) == nil {
                    leftRoads[i].append(nextPoint(labirint, leftRoads[i].last!, leftRoads[i]))
                }
                leftRoads[i] += checkEndRoad(labirint, point: leftRoads[i].last!)!
            }
            for i in 0..<downRoads.count {
                while checkEndRoad(labirint, point: downRoads[i].last!) == nil {
                    downRoads[i].append(nextPoint(labirint, downRoads[i].last!, downRoads[i]))
                }
                downRoads[i] += checkEndRoad(labirint, point: downRoads[i].last!)!
            }
            for road in downRoads {
                print(road.first, road.last, road.count)
            }
            for road in leftRoads {
                print(road.first, road.last, road.count)
            }
            return 94
        }
        
        func part02(_ depths: Input) -> Output {
            var result = 0
            
            return result
        }
        
        func readInput(_ depths: Input) -> [[Character]] {
            var labirint: [[Character]] = []
            for line in depths {
                labirint.append(Array(line))
            }
            return labirint
        }
        
        func leftRoad(_ depths: [[Character]], point: (Int, Int)) -> [(Int, Int)]? {
            if depths[point.0][point.1] == "." &&
                depths[point.0][point.1 + 1] == ">" &&
                depths[point.0][point.1 + 2] == "." &&
                (depths[point.0 - 1][point.1 + 2] == "." ||
                 depths[point.0][point.1 + 3] == "." ||
                 depths[point.0 + 1][point.1 + 2]  == ".") {
                return [(point.0, point.1), (point.0, point.1 + 1), (point.0, point.1 + 2)]
            }
            return nil
        }
        
        func downRoad(_ depths: [[Character]], point: (Int, Int)) -> [(Int, Int)]? {
            if depths[point.0][point.1] == "." &&
                depths[point.0 + 1][point.1] == "v" &&
                depths[point.0 + 2][point.1] == "." &&
                (depths[point.0 + 2][point.1 - 1] == "." ||
                 depths[point.0 + 3][point.1] == "." ||
                 depths[point.0 + 2][point.1 + 1]  == ".") {
                return [(point.0, point.1), (point.0 + 1, point.1), (point.0 + 2, point.1)]
            }
            return nil
        }
        
        func checkEndRoad(_ depths: [[Character]], point: (Int, Int)) -> [(Int, Int)]? {
            if depths[point.0][point.1] == "." &&
                depths[point.0][point.1 + 1] == ">" &&
                depths[point.0][point.1 + 2] == "." {
                return [(point.0, point.1), (point.0, point.1 + 1), (point.0, point.1 + 2)]
            }
            if depths[point.0][point.1] == "." &&
                depths[point.0 + 1][point.1] == "v" &&
                depths[point.0 + 2][point.1] == "." {
                return [(point.0, point.1), (point.0 + 1, point.1), (point.0 + 2, point.1)]
            }
            return nil
        }
        
        func nextPoint(_ depths: [[Character]],_ current: (Int, Int),_ road: [(Int, Int)] ) -> (Int, Int) {
            var position: (Int, Int) = (0, 0)
            
            let aT = current.0 == 0 ? 0 : current.0 - 1
            let aB = current.0 == depths.count - 1 ? current.0 : current.0 + 1
            let aL = current.1 == 0 ? 0 : current.1 - 1
            let aR = current.1 == depths[current.0].count - 1 ? current.1 : current.1 + 1
            
            if depths[current.0][aL] == "." && !road.contains(where: { $0 == (current.0, aL) }) {
                return (current.0, aL)
            }
            if depths[current.0][aR] == "." && !road.contains(where: { $0 == (current.0, aR) }) {
                return (current.0, aR)
            }
            if depths[aT][current.1] == "." && !road.contains(where: { $0 == (aT, current.1) }) {
                return (aT, current.1)
            }
            if depths[aB][current.1] == "." && !road.contains(where: { $0 == (aB, current.1) }) {
                return (aB, current.1)
            }
            
            
            return position
        }
    }
}
