import Foundation

var a = 44
let b = 55

// print("a+b = \(a+b)")

// For loop example - 
// for i in 0...10 {
//     if i % 2 == 0 {
//         print("\(i) is even")
//     } else {
//         print("\(i) is odd")
//     }
// }

func add(_ x: Int,_ y: Int) -> Int {
    return x + y
}
// print(add(2, 2))

var list = [100, 487894, 1, -22, 890, 0]
var reversesortedList = list.sorted() {$0 > $1}
// print(reversesortedList)

var actors = Set(["RDJ", "Sam Jackson", "Jake Gyllenhal", "Tom Cruise"])
print(actors)
actors.insert("RDJ")
print(actors)