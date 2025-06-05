import Cocoa

/*
    Issue : Currently, the text is first encoded as UTF-16 (UTF-8 works, it's just a experiment).
            In the 'addNewTokens' function we add a new token, whose numeric value goes beyond UTF-16 i.e - 
            replacing the most frequent token with a new value all-together. 
            But as in the current code, i get an error saying i cannot pass a value more than the range of 
            UTF-16 to a variable which is conformed to UInt16 (here 'newValue'). Happens the same if we define everything with 
            UInt8 and then try to add a new token with value 256, which is beyond UInt8.
    Date : 05 Jun' 25
*/

let text = "Ｕｎｉｃｏｄｅ! 🅤🅝🅘🅒🅞🅓🅔‽ 🇺‌🇳‌🇮‌🇨‌🇴‌🇩‌🇪! 😄 The very name strikes fear and awe into the hearts of programmers worldwide. We all know we ought to “support Unicode” in our software (whatever that means—like using wchar_t for all the strings, right?). But Unicode can be abstruse, and diving into the thousand-page Unicode Standard plus its dozens of supplementary annexes, reports, and notes can be more than a little intimidating. I don't blame programmers for still finding the whole thing mysterious, even 30 years after Unicode's inception."

var tokens = Array(text.utf16)

print("Text count: \(text.count)")
print("Tokens count: \(tokens.count)")


func createPairs(for ids: [UInt16]) -> [[UInt16]: Int] { 
    var countPair = [[UInt16]: Int]()

    for i in 0..<ids.count - 1 {
        let pair: [UInt16] = [ids[i], ids[i+1]]
        countPair[pair, default: 0] += 1
    }
    return countPair
}

let pairs = createPairs(for: tokens)
print("Token pairs: \(pairs)")
print("Token pairs count: \(pairs.count)")

func topPair(from pairs: [[UInt16]: Int]) -> [UInt16] { 
    let (maxPair, maxValue) = pairs.max(by: { $0.value < $1.value }) ?? ([0,0],0)
    print("Token occurring most: \(maxPair)   count: \(maxValue)")
    return maxPair
}

let top = topPair(from: pairs) 

func addNewTokens(in ids: [UInt16], add newPair: [UInt16], newValue: UInt16) -> [UInt16] {
    var newIds: [UInt16] = [] 
    var i = 0

    while i < ids.count {
        if i < ids.count - 1 && ids[i] == newPair[0] && ids[i+1] == newPair[1] {
            newIds.append(newValue)
            i += 2
        } else {
            newIds.append(ids[i])
            i += 1
        }
    }
    return newIds
}

let nTokens = addNewTokens(in: tokens, add: top, newValue: 65536)
print("New Tokens count: \(nTokens.count)")
print(nTokens)