import Cocoa

enum UserError: Error {
    case badID, networkFailed
}

func getUser(id: Int) throws -> String {
    throw UserError.networkFailed
}

if let user = try? getUser(id: 23) {
    print("User \(user)")
}

let names = ["Arya", "Stark", "Robb", "Sansa"]

// The nil coalescing operator "??", unwraps and returns an optional's value
// here a name from the array otherwise returns a default value, here "No one".
// Below is an example of option chaining, where first we check if we get an element 
// from the array and then when we get it, we return the uppercased value to 'chosen'
let chosen = names.randomElement()?.uppercased() ?? "No one"
// print("Next in line: \(chosen)")

struct Book {
    let title: String
    let author: String?
}

var book: Book? = nil
let author = book?.author?.first?.uppercased() ?? "Anonymous"
print(author)
