import Cocoa

extension Collection {
    var isNotEmpty: Bool {
        isEmpty == false
    }
}

let people = ["Mario", "Luigi", "Kurt"]
if people.isNotEmpty {
    print("People: \(people.count)")
    
}

let colors = [1: "Red", 2: "Blue", 3: "Yellow"]
if colors.isNotEmpty {
    print("Colors: \(colors.count)")
    print(colors.sorted {a, b in 
    a.value > b.value})
}