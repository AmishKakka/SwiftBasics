import Cocoa

/*
    Issue : Currently, the text is first encoded as UTF-16 (UTF-8 works, it's just a experiment).
            In the 'addNewTokens' function we add a new token, whose numeric value goes beyond UTF-16 i.e - 
            replacing the most frequent token with a new value all-together. 
            But as in the current code, i get an error saying i cannot pass a value more than the range of 
            UTF-16 to a variable which is conformed to Int (here 'newValue'). Happens the same if we define everything with 
            UInt8 and then try to add a new token with value 256, which is beyond UInt8.
    Date : 05 Jun' 25

    Solution : Instead of keeping the String.UTF8View thorughout the code for the tokens i initially change it Int format, so that
    later on there no type conversion issues. The '.map {Int($0)}' converts each element in the array of type String.UTF8View.Element 
    to Int. Now, we get UTF-8 View for the text and then, convert it into Int. 
    Note :- Symbols and characters that are out of scope (beyond the value of 255), will be represented as a collection of UTF-8 elements.
    Example -   let flowermoji = "💐"
                for v in flowermoji.utf8 {
                    print(v)
                }
                // 240
                // 159
                // 146
                // 144
    Date : 06 Jun' 25
*/

let text = "Ｕｎｉｃｏｄｅ! 🅤🅝🅘🅒🅞🅓🅔‽ 🇺‌🇳‌🇮‌🇨‌🇴‌🇩‌🇪! 😄 The very name strikes fear and awe into the hearts of programmers worldwide. We all know we ought to “support Unicode” in our software (whatever that means—like using wchar_t for all the strings, right?). But Unicode can be abstruse, and diving into the thousand-page Unicode Standard plus its dozens of supplementary annexes, reports, and notes can be more than a little intimidating. I don't blame programmers for still finding the whole thing mysterious, even 30 years after Unicode's inception."

let utfTokens: [String.UTF8View.Element] = Array(text.utf8)

print("Text count: \(text.count)")
print("UTF-8 Tokenized text count: \(utfTokens.count)")

let tokens = utfTokens.map {Int($0)}
print("Int Tokenized text count: \(tokens.count)")
// print(tokens)

func createPairs(for ids: [Int]) -> [[Int]: Int] { 
    var countPair = [[Int]: Int]()

    for i in 0..<ids.count - 1 {
        let pair: [Int] = [ids[i], ids[i+1]]
        countPair[pair, default: 0] += 1
    }
    return countPair
}

// let pairs = createPairs(for: tokens)
// print("Token pairs: \(pairs)")
// print("Token pairs count: \(pairs.count)")

func topPair(from pairs: [[Int]: Int]) -> [Int] { 
    let (maxPair, maxValue) = pairs.max(by: { $0.value < $1.value }) ?? ([0,0],0)
    print("Token occurring most: \(maxPair)   count: \(maxValue)")
    return maxPair
}
// let top = topPair(from: pairs) 

func addNewTokens(in ids: [Int], add newPair: [Int], newValue: Int) -> [Int] {
    var newIds: [Int] = [] 
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
// let nTokens = addNewTokens(in: tokens, add: top, newValue: 256)
// print("New Tokens count: \(nTokens.count)")
// print(nTokens)


func mergeNTimes(n: Int, textTokens: [Int]) -> [Int] {
    var newTokens: [Int] = textTokens
    for i in 1...n {
        // Keep on merging tokens for n times.
        let pairs = createPairs(for: newTokens)
        let top = topPair(from: pairs) 
        newTokens = addNewTokens(in: newTokens, add: top, newValue: Int(255+i))
    }
    return newTokens
}

let nTokens = mergeNTimes(n: 5, textTokens: tokens)
print("Final tokenized text: \(nTokens)")
print("Final tokenized text count: \(nTokens.count)")