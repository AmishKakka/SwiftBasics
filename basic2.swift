struct Employee {
    var name: String
    var age: Int
    let salary = 2000
    
    init(name: String) {
        self.name = name
        self.age = Int.random(in: 1...50)
    }

    // If we want to change the value of somethign defined using the 'let' keyword,
    // we define the function using 'mutating' to modify it.
    mutating func balance(amount: Int) {
        salary += amount
    }

    func displayInfo() {
        print("Name: \(name), Age: \(age), Salary: \(salary)")
    }
}

var alice = Employee(name: "Pam Alice")
print(alice.age)
alice.balance(amount: 50)
print(alice.salary)
