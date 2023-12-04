import Cocoa
import Foundation

extension String {
  var lines: [String] {
    self.components(separatedBy: .newlines)
  }
}

func getCalibrationValues(from lines: [String]) -> Int {
  var result = 0
  for line in lines {
    let line = line.filter { $0.isNumber }
    let first = String(line.first ?? "0")
    let last = String(line.last ?? "0")
    let wholeNumberAsString = first + last
    let numAsInt = Int(wholeNumberAsString)
    print(numAsInt!)
    result += numAsInt ?? 0
  }
  return result
}

//getCalibrationValues(from: test1.lines)
//getCalibrationValues(from: input.lines)

func replaceDigits(in lines: [String]) -> [String] {
  let dict = [
    "one": "1",
    "two": "2",
    "three": "3",
    "four": "4",
    "five": "5",
    "six": "6",
    "seven": "7",
    "eight": "8",
    "nine": "9",
  ]

  var newLines = [String]()

  for line in lines {
    var line = line
    findFirstDigit: for i in 1...line.count {
      let s = line.prefix(i)
      for number in dict {
        if s.contains(number.key) {
          line.replace(number.key, with: number.value)
          break findFirstDigit
        }
      }
    }

    findLastDigit: for i in 1...line.count {
      let s = line.suffix(i)
      for number in dict {
        if s.contains(number.key) {
          line.replace(number.key, with: number.value)
          break findLastDigit
        }
      }
    }
    newLines.append(line)
  }

  return newLines
}

//let rd = replaceDigits(in: input.lines)
//getCalibrationValues(from: rd)

func altReplaceDigits(in lines: [String]) -> Int {
  let dict = [
    "one": "1",
    "two": "2",
    "three": "3",
    "four": "4",
    "five": "5",
    "six": "6",
    "seven": "7",
    "eight": "8",
    "nine": "9",
  ]

  var tuples = [(Character?, Character?)]()

  for line in lines {
    let line = line
    var res: (Character?, Character?) = (nil, nil)

    findFirstDigit: for i in 1...(line.count) {
      var substr = line.prefix(i)
      let substrChar = substr[substr.index(substr.startIndex, offsetBy: i - 1)]

      if substrChar.isNumber {
        res.0 = substrChar
        break findFirstDigit
      }

      for number in dict {
        if substr.contains(number.key) {
          res.0 = Character(number.value)
          break findFirstDigit
        }
      }
    }

    findSecDigit: for i in 1...(line.count) {
      var substr = line.suffix(i)

        if substr.first!.isNumber {
          res.1 = substr.first
        break findSecDigit
      }

      for number in dict {
        if substr.contains(number.key) {
          res.1 = Character(number.value)
          break findSecDigit
        }
      }
    }
    tuples.append(res)

  }

  var result = 0
    
  for tuple in tuples {
      let sum = "\(tuple.0!)\(tuple.1!)"
      result += Int(sum) ?? 0
  }
  return result
}

//altReplaceDigits(in: input.lines)
