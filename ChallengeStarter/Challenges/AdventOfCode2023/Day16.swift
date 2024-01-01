import ChallengeBase
import Foundation

extension AdventOfCode2023 {
    class Day16 : AdventOfCode2023, Solution {
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
                return part01(input, (0,0,2))
            case .part02:
                return part02(input)
            }
            
        }
        
        // MARK: - Logic Methods
        func part01(_ depths: Input, _ startPoint: (Int, Int, Int)) -> Output {
            var result = 0
            var m = depths
//            for line in depths {
//                print(line)
//            }
            var i = 0
            var routs: [[(Int, Int, Int)]] = [[startPoint]]
            if depths[0][0] == "/" && routs[0].last!.2 == 1 {
                routs[0][0].2 = 2
            } else if depths[0][0] == "/" && routs[0].last!.2 == 4 {
                routs[0][0].2 = 3
            } else if depths[0][0] == "/" && routs[0].last!.2 == 3 {
                routs[0][0].2 = 4
            } else if depths[0][0] == "/" && routs[0].last!.2 == 2 {
                routs[0][0].2 = 1
            } else if depths[0][0] == "\\" && routs[0].last!.2 == 2 {
                routs[0][0].2 = 3
            } else if depths[0][0] == "\\" && routs[0].last!.2 == 1 {
                routs[0][0].2 = 4
            } else if depths[0][0] == "\\" && routs[0].last!.2 == 3 {
                routs[0][0].2 = 2
            } else if depths[0][0] == "\\" && routs[0].last!.2 == 4 {
                routs[0][0].2 = 1
            } else if depths[0][0] == "-" && (routs[0].last!.2 == 1 || routs[0].last!.2 == 3) {
                routs[0][0].2 = 4
                routs.append([(routs[0].last!.0, routs[0].last!.1, 2)])
            } else if depths[0][0] == "|" && (routs[0].last!.2 == 2 || routs[0].last!.2 == 4) {
                routs[0][0].2 = 1
                routs.append([(routs[0].last!.0, routs[0].last!.1, 3)])
            }
            while i != routs.count {
                while checkBoard(depths, routs[i].last!, routs[i]) {
                    nextStep(depths, &routs, i)
                }
                i += 1
            }
            for line in routs {
                for point in line {
                    m[point.0][point.1] = "#"
                }
            }
            for line in m {
                for point in line {
                    if point == "#" {
                        result += 1
                    }
                }
            }
//            print("good")
//            for line in m {
//                print(line)
//            }
            return result
        }
        
        func part02(_ depths: Input) -> Output {
            var result = 0
            var startingPoints = [(0,0,2), (0,0,3),
                                  (0,depths[0].count - 1,4), (0,depths[0].count - 1,3),
                                  (depths.count - 1,depths[0].count - 1,1), (depths.count - 1,depths[0].count - 1,4),
                                  (depths.count - 1,0,1), (depths.count - 1,0,2)]
            for i in 1..<depths[0].count - 2 {
                startingPoints.append((0,i,3))
                startingPoints.append((depths.count - 1,i,1))
            }
            for i in 1..<depths.count - 2 {
                startingPoints.append((i,0,2))
                startingPoints.append((i,depths[i].count - 1,4))
            }
            for point in startingPoints {
                let a = part01(depths, point)
                print(a, point)
                if a > result {
                    result = a
                }
            }
            return result
        }
        
        func checkBoard(_ depths: Input,_ point: (Int, Int, Int),_ rout: [(Int, Int, Int)]) -> Bool {
            if point.0 == 0 && point.2 == 1 {
                return false
            }
            if point.0 == depths.count - 1 && point.2 == 3 {
                return false
            }
            if point.1 == 0 && point.2 == 4 {
                return false
            }
            if point.1 == depths[0].count - 1 && point.2 == 2 {
                return false
            }
            var pointNext = (0, 0, 0)
            if point.2 == 1 {
                pointNext = (rout.last!.0 - 1, rout.last!.1, rout.last!.2)
            } else if point.2 == 2 {
                pointNext = (rout.last!.0, rout.last!.1 + 1, rout.last!.2)
            } else if point.2 == 3 {
                pointNext = (rout.last!.0 + 1, rout.last!.1, rout.last!.2)
            } else if point.2 == 4 {
                pointNext = (rout.last!.0 , rout.last!.1 - 1, rout.last!.2)
            }
            
            if depths[pointNext.0][pointNext.1] == "/" && pointNext.2 == 1 {
//                print(1)
                pointNext.2 = 2
            } else if depths[pointNext.0][pointNext.1] == "/" && pointNext.2 == 4 {
//                print(2)
                pointNext.2 = 3
            } else if depths[pointNext.0][pointNext.1] == "/" && pointNext.2 == 3 {
//                print(3)
                pointNext.2 = 4
            } else if depths[pointNext.0][pointNext.1] == "/" && pointNext.2 == 2 {
//                print(4)
                pointNext.2 = 1
            } else if depths[pointNext.0][pointNext.1] == "\\" && pointNext.2 == 2 {
//                print(5)
                pointNext.2 = 3
            } else if depths[pointNext.0][pointNext.1] == "\\" && pointNext.2 == 1 {
//                print(6)
                pointNext.2 = 4
            } else if depths[pointNext.0][pointNext.1] == "\\" && pointNext.2 == 3 {
//                print(7)
                pointNext.2 = 2
            } else if depths[pointNext.0][pointNext.1] == "\\" && pointNext.2 == 4 {
//                print(8)
                pointNext.2 = 1
            } else if depths[pointNext.0][pointNext.1] == "-" && (pointNext.2 == 1 || pointNext.2 == 3) {
//                print(9)
                pointNext.2 = 4
            } else if depths[pointNext.0][pointNext.1] == "|" && (pointNext.2 == 2 || pointNext.2 == 4) {
//                print(10)
                pointNext.2 = 1
            }
//            print(pointNext)
//            print(rout)
            if rout.contains(where: { $0 == pointNext }) {
                return false
            }
                
            return true
        }
        
        func nextStep(_ depths: Input, _ beam: inout [[(Int, Int, Int)]], _ n: Int) {
            if checkBoard(depths, beam[n].last!, beam[n]) {
                nextPoint(depths, &beam, n)
            }
            
        }
        
        func nextPoint(_ depths: Input, _ beam: inout [[(Int, Int, Int)]], _ n: Int) {
            if beam[n].last!.2 == 1 {
                beam[n].append((beam[n].last!.0 - 1, beam[n].last!.1, beam[n].last!.2))
            } else if beam[n].last!.2 == 2 {
                beam[n].append((beam[n].last!.0, beam[n].last!.1 + 1, beam[n].last!.2))
            } else if beam[n].last!.2 == 3 {
                beam[n].append((beam[n].last!.0 + 1, beam[n].last!.1, beam[n].last!.2))
            } else if beam[n].last!.2 == 4 {
                beam[n].append((beam[n].last!.0, beam[n].last!.1 - 1, beam[n].last!.2))
            }
            
//            for line in beam {
//                print("nextP", line)
//            }
            
//            print("p",depths[beam[n].last!.0][beam[n].last!.1], beam[n].last!)
            let p = depths[beam[n].last!.0][beam[n].last!.1]
            
            if p == "/" && beam[n].last!.2 == 1 {
//                print(1)
                beam[n][beam[n].count - 1].2 = 2
            } else if p == "/" && beam[n].last!.2 == 4 {
//                print(2)
                beam[n][beam[n].count - 1].2 = 3
            } else if p == "/" && beam[n].last!.2 == 3 {
//                print(3)
                beam[n][beam[n].count - 1].2 = 4
            } else if p == "/" && beam[n].last!.2 == 2 {
//                print(4)
                beam[n][beam[n].count - 1].2 = 1
            } else if p == "\\" && beam[n].last!.2 == 2 {
//                print(5)
                beam[n][beam[n].count - 1].2 = 3
            } else if p == "\\" && beam[n].last!.2 == 1 {
//                print(6)
                beam[n][beam[n].count - 1].2 = 4
            } else if p == "\\" && beam[n].last!.2 == 3 {
//                print(7)
                beam[n][beam[n].count - 1].2 = 2
            } else if p == "\\" && beam[n].last!.2 == 4 {
//                print(8)
                beam[n][beam[n].count - 1].2 = 1
            } else if p == "-" && (beam[n].last!.2 == 1 || beam[n].last!.2 == 3) {
//                print(9)
                beam[n][beam[n].count - 1].2 = 4
//                beam.append([(beam[n].last!.0, beam[n].last!.1, 2)])
                if !beam.contains(where: { $0[0] == (beam[n].last!.0, beam[n].last!.1, 2) }) {
                    beam.append([(beam[n].last!.0, beam[n].last!.1, 2)])
                }
                if !beam.contains(where: { $0[0] == (beam[n].last!.0, beam[n].last!.1, 4) }) {
                    beam.append([(beam[n].last!.0, beam[n].last!.1, 4)])
                }
            } else if p == "|" && (beam[n].last!.2 == 2 || beam[n].last!.2 == 4) {
//                print(10)
                beam[n][beam[n].count - 1].2 = 1
//                beam.append([(beam[n].last!.0, beam[n].last!.1, 3)])
                if !beam.contains(where: { $0[0] == (beam[n].last!.0, beam[n].last!.1, 3) }) {
                    beam.append([(beam[n].last!.0, beam[n].last!.1, 3)])
                }
                if !beam.contains(where: { $0[0] == (beam[n].last!.0, beam[n].last!.1, 1) }) {
                    beam.append([(beam[n].last!.0, beam[n].last!.1, 1)])
                }
            }
            
//            print("ch",depths[beam[n].last!.0][beam[n].last!.1], beam[n].last!)
            
//            for line in beam {
//                print("nextCh", line)
//            }
            
        }
    }
}

//2351
//7307
//7429
