//
//  main.swift
//  ChallengeStarter
//
//  Created by you on 2022-11-25.
//

import Foundation

let resourceSets = ["example"]

// MARK: - Direct Declaration
// Invoke using direct declarations
//var day01 = AdventOfCode2023.Day01(datasets: resourceSets, algorithms: [.part01])
//day01.execute()

//var day02 = AdventOfCode2023.Day02(datasets: resourceSets, algorithms: [.part01, .part02])
//day02.execute()

//var day03 = AdventOfCode2023.Day03(datasets: resourceSets, algorithms: [.part01, .part02])
//day03.execute()

var day04 = AdventOfCode2023.Day04(datasets: resourceSets, algorithms: [.part01, .part02])
day04.execute()
