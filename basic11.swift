import Cocoa

struct App {
    var contacts = [String]() {
        willSet {
            print("Current value: \(contacts)")
            print("New value: \(newValue)")
        }

        didSet {
            print("There are now \(contacts.count) contacts")
            print("Old values: \(oldValue)")
        }
    }
}

var app = App()
app.contacts.append(contentsOf: ["Adrian"])
