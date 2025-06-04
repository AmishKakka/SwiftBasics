let sayHello = {(name: String) -> String in
    "Name is \(name)"
}

print(sayHello("amish"))

var people = ["Alice", "Bob", "Charlie", "Diana", "Charles"]
var oneSorted = people.sorted() {a, b in
    if a == "Diana" {
        return true
    } else {
        return false
    }
}
print(oneSorted)

// '$0', '$1' are called shorthand syntax (syntactic sugar) which helps write clean
// and efficient code. 
// Also, here Closures are used as we see to change the working of filter function 
// for the 'people' array.
let cOnly = people.filter { $0.hasPrefix("C") }
print(cOnly)

let caps = people.map {$0.uppercased()}
print(caps)
