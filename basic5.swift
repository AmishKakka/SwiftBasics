import Cocoa

var quote = " Today is a good day   "

extension String {
    mutating func trimmed() -> String {
        self.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    var lines: [String] {
        self.components(separatedBy: .newlines)
    }
}

print(quote.trimmed())

let lines = """
    this
    is 
a multi-line
comment
"""

print(lines.lines)
print(lines.lines.count)
