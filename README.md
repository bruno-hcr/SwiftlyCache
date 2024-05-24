# SwiftlyCache

SwiftlyCache is a lightweight, generic wrapper for `NSCache` in Swift, designed to be reusable for any Swift types. It provides automatic memory management, thread safety, and the ability to convert the cache to and from a Swift dictionary.

## Features

- Generic wrapper for `NSCache` to support any Swift types.
- Automatic memory management and eviction policies of `NSCache`.
- Thread-safe operations.
- Conversion to and from a Swift dictionary.
- Persistence of cache state when the app transitions to background.

## Requirements

- iOS 16.0+ / macOS 14+ / tvOS 17.0+ / watchOS 10.0+
- Xcode 15+
- Swift 5.0+

## Installation

### Swift Package Manager

To integrate SwiftlyCache into your project using Swift Package Manager, add the following dependency in your `Package.swift` file:

```swift
dependencies: [
    .package(url: "https://github.com/bruno-hcr/SwiftlyCache", from: "1.0.0")
]
```

Then, include `"SwiftlyCache"` as a dependency in your target:

```swift
.target(
    name: "YourTargetName",
    dependencies: ["SwiftlyCache"]),
```

## Usage

### Basic Usage

Here's an example of how to use SwiftlyCache:

```swift
import SwiftlyCache

// Create an instance of the cache
let cache = Cache<String, Int>()

// Insert items into the cache
cache.insert(42, forKey: "Answer")
cache.insert(100, forKey: "Score")

// Retrieve items from the cache
if let answer = cache.value(forKey: "Answer") {
    print("The value for 'Answer' is \(answer)")  // Output: The value for 'Answer' is 42
}

// Convert cache to dictionary
let dictionary = cache.toDictionary()
print(dictionary)  // Output: ["Answer": 42, "Score": 100]
```

### Initializing with a Dictionary

You can initialize the cache with an existing dictionary:

```swift
let initialDictionary: [String: Int] = ["Answer": 42, "Score": 100]
let cache = Cache(dictionary: initialDictionary)
```

### Persistence Across App States

To save and restore the cache state when the app transitions to background and foreground:

```swift
import UIKit
import SwiftlyCache

let cache = Cache<String, Int>()

// Save the cache state when the app goes to the background
NotificationCenter.default.addObserver(forName: UIApplication.didEnterBackgroundNotification, object: nil, queue: nil) { _ in
    cache.saveState()
}

// Restore the cache state when the app comes to the foreground
NotificationCenter.default.addObserver(forName: UIApplication.willEnterForegroundNotification, object: nil, queue: nil) { _ in
    cache.restoreState()
}
```

## License

SwiftlyCache is released under the MIT license. See [LICENSE](LICENSE) for details.