import ChallengeBase
import Foundation

extension AdventOfCode2023 {
    class Day24 : AdventOfCode2023, Solution {
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
                return part01(input, 200000000000000, 400000000000000)
            case .part02:
                return part02(input)
            }
            
        }
        
        // MARK: - Logic Methods
        func part01(_ depths: Input, _ x: Int64, _ y: Int64) -> Output {
            var result = 0
            let beams = readInput(depths)
//            print(beams)
            for i in 0..<beams.count - 1 {
                for j in i + 1..<beams.count {
                    if !check0(beams[i], beams[j]) {
                    } else {
                        print(beams[i],beams[j])
                        print(cross(beams[i], beams[j]), boards(beams[i], beams[j], x, y, cross(beams[i], beams[j])))
                        let crossTime = cross(beams[i], beams[j])
                        if crossTime.0 > 0 && crossTime.1 > 0 {
                            if boards(beams[i], beams[j], x, y, cross(beams[i], beams[j])) {
                                result += 1
                            }
                        }
                    }
                }
            }
            return result
        }
        
        func part02(_ depths: Input) -> Output {
            
            return 0
        }
        
        func readInput(_ depths: Input) -> [((Double, Double, Double), (Double, Double, Double))] {
            var beams: [((Double, Double, Double), (Double, Double, Double))] = []
            for line in depths {
                let string = line.components(separatedBy: [" ", ",", "@"]).filter {$0 > ""}
                beams.append(((Double(string[0])!, Double(string[1])!, Double(string[2])!),
                              (Double(string[3])!, Double(string[4])!, Double(string[5])!)))
            }
            return beams
        }
        
        func check0(_ beam1: ((Double, Double, Double), (Double, Double, Double)),
                    _ beam2: ((Double, Double, Double), (Double, Double, Double)) ) -> Bool {
            if beam1.1.1 * beam2.1.0 / beam1.1.0 - beam2.1.1 == 0 {
                return false
            }
            if beam1.1.0 == 0 {
                return false
            }
            return true
        }
        
        func cross(_ beam1: ((Double, Double, Double), (Double, Double, Double)),
                    _ beam2: ((Double, Double, Double), (Double, Double, Double)) ) -> (Double, Double) {
            let t211 = Double(beam1.1.1) * (beam2.0.0 - beam1.0.0)
            let t21 = beam2.0.1 - beam1.0.1 - t211 / Double(beam1.1.0)
            let t22 = (beam1.1.1 * beam2.1.0 / beam1.1.0 - beam2.1.1)
            let t2 = t21 / Double(t22)
            let t11 = Double(beam2.1.0) * t2
            let t1 = (t11 + beam2.0.0 - beam1.0.0) / Double(beam1.1.0)
            return (t1, t2)
        }
        
        func boards(_ beam1: ((Double, Double, Double), (Double, Double, Double)),
                    _ beam2: ((Double, Double, Double), (Double, Double, Double)), _ x: Int64, _ y: Int64,
                    _ time: (Double, Double)) -> Bool {
            let x1 = Double(round(1000 * (beam1.0.0 + beam1.1.0 * time.0)) / 1000)
            let y1 = Double(round(1000 * (beam1.0.1 + beam1.1.1 * time.0)) / 1000)
            let x2 = Double(round(1000 * (beam2.0.0 + beam2.1.0 * time.1)) / 1000)
            let y2 = Double(round(1000 * (beam2.0.1 + beam2.1.1 * time.1)) / 1000)
            print(x1, x2, y1, y2)
            if x1 >= Double(x) && x2 >= Double(x) && y1 >= Double(x) && y2 >= Double(x) &&
                x1 <= Double(y) && x2 <= Double(y) && y1 <= Double(y) && y2 <= Double(y) {
                return true
            } else {
                return false
            }
        }
        
        func readInput2(_ depths: Input) -> [((Int64, Int64, Int64), (Int64, Int64, Int64))] {
            var beams: [((Int64, Int64, Int64), (Int64, Int64, Int64))] = []
            for line in depths {
                let string = line.components(separatedBy: [" ", ",", "@"]).filter {$0 > ""}
                beams.append(((Int64(string[0])!, Int64(string[1])!, Int64(string[2])!),
                              (Int64(string[3])!, Int64(string[4])!, Int64(string[5])!)))
            }
            return beams
        }
    }
}
