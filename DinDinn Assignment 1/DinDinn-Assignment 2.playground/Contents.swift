import Foundation


let startTime1 = CFAbsoluteTimeGetCurrent()
var strArray1 = ["a","b","c","d","z","y"]

print("Input array: \(strArray1)")
var num1 = 2
for i in 0..<strArray1.count{
    
    let char = strArray1[i]
    let aValue = UnicodeScalar(char)?.value
    
    var newAValue = Int(aValue!) + num1
    if(newAValue > 122){
        newAValue = newAValue - 26
    }
    strArray1[i] = String(UnicodeScalar(newAValue)!)
}

print("Result Array:\(strArray1)")

let timeElapsed1 = CFAbsoluteTimeGetCurrent() - startTime1
print("Time elapsed: \(timeElapsed1) s.")







let startTime = CFAbsoluteTimeGetCurrent()

var strArray = ["a","b","c","d","z","y"]

print("Input array: \(strArray)")
var num = 2
var dictionaryOfAlphabets = [Character:Int]()
var dictionaryOfNumbers = [Int:Character]()
var count = 0
var abc = Array("abcdefghijklmnopqrstuvwxyz")
for i in 0..<abc.count  {
    
    dictionaryOfAlphabets[abc[i]] = count
    dictionaryOfNumbers[count] = abc[i]
    count += 1
}

for i in 0..<strArray.count {
    let char = Character(strArray[i])
    
    var position = dictionaryOfAlphabets[char]
    
    position = (num + position!) % 26
    strArray[i] = String(dictionaryOfNumbers[position!]!)
    
}
print("Result Array:\(strArray)")


let timeElapsed = CFAbsoluteTimeGetCurrent() - startTime
print("Time elapsed: \(timeElapsed) s.")












