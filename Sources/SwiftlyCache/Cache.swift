//
//  Cache.swift
//  
//
//  Created by Bruno Ramos on 24/05/24.
//

import Foundation

/// A generic wrapper for NSCache that can be reused for any Swift types.
public final class Cache<Key: Hashable, Value> {
    
    /// Internal NSCache instance to hold cached items.
    private let cache = NSCache<WrappedKey, Entry>()
    
    /// Set of keys to keep track of inserted keys
    private var keys = Set<Key>()
    
    public init() {}
    
    /// Initializes the cache with a dictionary.
    ///
    /// - Parameter dictionary: The dictionary to populate the cache with.
    public init(dictionary: [Key: Value]) {
        for (key, value) in dictionary {
            insert(value, forKey: key)
        }
    }
    
    /// Inserts a value into the cache with a specified key.
    ///
    /// - Parameters:
    ///   - value: The value to be cached.
    ///   - key: The key with which to associate the value.
    func insert(_ value: Value, forKey key: Key) {
        let entry = Entry(value: value)
        cache.setObject(entry, forKey: WrappedKey(key))
        keys.insert(key)
    }
    
    /// Retrieves a value from the cache for a specified key.
    ///
    /// - Parameter key: The key associated with the value to be retrieved.
    /// - Returns: The value if it exists in the cache, otherwise `nil`.
    func value(forKey key: Key) -> Value? {
        let entry = cache.object(forKey: WrappedKey(key))
        return entry?.value
    }
    
    /// Removes a value from the cache for a specified key.
    ///
    /// - Parameter key: The key associated with the value to be removed.
    func removeValue(forKey key: Key) {
        cache.removeObject(forKey: WrappedKey(key))
        keys.remove(key)
    }
    
    /// A wrapper class for the key to be used with NSCache.
    private class WrappedKey: NSObject {
        let key: Key
        
        /// Initializes a WrappedKey instance with the provided key.
        ///
        /// - Parameter key: The key to be wrapped.
        init(_ key: Key) {
            self.key = key
        }
        
        /// Returns the hash value of the wrapped key.
        override var hash: Int {
            key.hashValue
        }
        
        /// Compares the wrapped key with another object for equality.
        ///
        /// - Parameter object: The object to be compared with.
        /// - Returns: `true` if the object is a WrappedKey and contains the same key, otherwise `false`.
        override func isEqual(_ object: Any?) -> Bool {
            guard let value = object as? WrappedKey else {
                return false
            }
            return value.key == key
        }
    }
    
    /// A class to store the value in the cache.
    private class Entry {
        let value: Value
        
        /// Initializes an Entry instance with the provided value.
        ///
        /// - Parameter value: The value to be stored in the cache.
        init(value: Value) {
            self.value = value
        }
    }
}

// MARK: - Cache Extension to Dictionary

extension Cache {
    
    /// Converts the cache into a Swift Dictionary.
    ///
    /// - Returns: A dictionary containing all the key-value pairs in the cache.
    public func toDictionary() -> [Key: Value] {
        var dictionary = [Key: Value]()
        
        for key in keys {
            if let value = self.value(forKey: key) {
                dictionary[key] = value
            }
        }
        
        return dictionary
    }
}

