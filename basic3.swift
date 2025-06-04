struct School {
    // Using 'static' keyword we do not create an instance of struct while performing 
    // action on it outside the struct.
    static var count = 0

    // self: current value of struct
    // Self: current type of struct
    static func add(student: String) {
        print("\(student) added to school.")
        Self.count += 1
    }
}

School.add(student: "Amish")
print(School.count)
School.add(student: "Kakka")
print(School.count)

