import Foundation

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
// print("Text count: \(text.count)")
// print("UTF-8 Tokenized text count: \(utfTokens.count)")

let tokens = utfTokens.map {Int($0)}
// print("Int Tokenized text count: \(tokens.count)")
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


func mergeNTimes(n: Int, textTokens: [Int]) -> [[Int]: Int] {
    var newTokens: [Int] = textTokens
    var merges = [[Int]: Int]()
    for i in 1...n {
        // Keep on merging tokens for n times.
        let pairs = createPairs(for: newTokens)
        let top = topPair(from: pairs)  
        newTokens = addNewTokens(in: newTokens, add: top, newValue: Int(255+i))
        merges[top] = Int(255+i)
    }
    return merges
}
let merges = mergeNTimes(n: 20, textTokens: tokens)
let sortedMerges = merges.sorted { $0.value < $1.value}


func createVocab(merges: [Dictionary<[Int], Int>.Element]) -> [Dictionary<Int, String>.Element] {
    var byteDictionary: [Int : String] = Dictionary(uniqueKeysWithValues: (0...255).map { 
        ($0, String(Character(UnicodeScalar(uint8($0))))) 
    }) 

     for (key, value) in merges {
        if let value1 = byteDictionary[key[0]], let value2 = byteDictionary[key[1]] {
            byteDictionary[value] = value1 + value2
        } else {
            print("Cannot add this!")
        }
    }

    let sortedDictionary: [Dictionary<Int, String>.Element] = byteDictionary.sorted { $0.key < $1.key }
    return sortedDictionary
}

let vocab: [Dictionary<Int, String>.Element] = createVocab(merges: sortedMerges)
print(vocab)


func encodeText(inputText: String, merges: [Dictionary<[Int], Int>.Element]) -> [Int] {
    let utf8view = Array(inputText.utf8)
    var intView = utf8view.map {Int($0)}
    print("Length hugeText encoded in UTF8 view: \(intView.count)")
    var i = 0

    while intView.count >= 2 {
        if i == merges.count-1 {
            break
        }
        let newPair = merges[i].key
        let newId = merges[i].value
        intView = addNewTokens(in: intView, add: newPair, newValue: newId)
        i += 1
    }
    return intView
}


func decodeText(tokens: [Int]) -> String{
    var output: String = ""
    for t in tokens  {
        output += vocab[t].value
    }
    return output
}

let hugeText = """
Ｕｎｉｃｏｄｅ! 🅤🅝🅘🅒🅞🅓🅔‽ 🇺‌🇳‌🇮‌🇨‌🇴‌🇩‌🇪! 😄 The very name strikes fear and awe into the hearts of programmers worldwide. We all know we ought to “support Unicode” in our software (whatever that means—like using wchar_t for all the strings, right?). But Unicode can be abstruse, and diving into the thousand-page Unicode Standard plus its dozens of supplementary annexes, reports, and notes can be more than a little intimidating. I don't blame programmers for still finding the whole thing mysterious, even 30 years after Unicode's inception. \
  \
A few months ago, I got interested in Unicode and decided to spend some time learning more about it in detail. In this article, I'll give an introduction to it from a programmer's point of view. \
 \
I'm going to focus on the character set and what's involved in working with strings and files of Unicode text. However, in this article I'm not going to talk about fonts, text layout/shaping/rendering, or localization in detail—those are separate issues, beyond my scope (and knowledge) here.
"""

let encodedText = encodeText(inputText: hugeText, merges: sortedMerges)
print("Tokenized text: \(encodedText.count)")
print(encodedText)

let textOutput = decodeText(tokens: encodedText)
print(textOutput)