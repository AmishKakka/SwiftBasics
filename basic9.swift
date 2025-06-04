enum PasswordError: Error {
    case tooShort, tooEasy
}

func checkPassword(_ password: String) throws -> String {
    if password.count < 8 { throw PasswordError.tooShort }
    if password == "12345678" { throw PasswordError.tooEasy }   

    return "OK"
}

let password = "123nnkm45"

do {
    let check = try checkPassword(password)
    print("Password \(check)")
} catch {
    print("Error: \(error)")
}
