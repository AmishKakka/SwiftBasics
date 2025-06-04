var a = 100_000
var b = 0
var c: Int? = nil

if let unwrapped = c {
    print(unwrapped*unwrapped)
}

// What 'guard' here does is that if the condition results are not what
// we expected then it will just return without executing the else clause (early return).
// Whereas, in the above 'if' condition it runs the code inside the bracket even if
// the condition is not satisfied.
func squared(of number: Int?) {
    guard let unwrapped = number else {
        print("No value!")
        return
    }
    print("Square is: \(unwrapped*unwrapped)")
}

squared(of: nil)