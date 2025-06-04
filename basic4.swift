class Employee {
    var name: String
    var age: Int

    init(name: String) {
        self.name = name
        self.age = Int.random(in: 21...30)
    }

    func printInfo() {
        print("Name: \(self.name)   Age: \(self.age)")
    }
}

class Manager: Employee {
    func info() {
        print("Manager name: \(name)")
    }
}

class Developer: Employee {
    func info() {
        print("Developer name: \(name)")
    }
    // 'override' keyword is used when you want to modify the exact function defined
    // in the parent class for your child class.
    override func printInfo() {
        print("Developer Name: \(name)")
    }
}

let robert = Manager(name: "Robert Hendricks")
print(robert.age)
let ray = Developer(name: "Ray Dalio")
ray.printInfo()