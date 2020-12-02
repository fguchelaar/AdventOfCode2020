# 02 Password Philosophy

Getting characters on a specific position in Swift is done by using 
`String.Index`. While working great, this gets tedious really fast during AoC.
So I've introduced an overload for `subscript` that reduces verbosity.

```swift
extension StringProtocol {
    public subscript(offset: Int) -> Character {
        self[index(startIndex, offsetBy: offset)]
    }
}
```

🔐 🧐
