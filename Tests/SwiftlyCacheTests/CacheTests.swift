import XCTest

@testable import SwiftlyCache

final class CacheTests: XCTestCase {

    func test_insert_givenKeyAndValue_shouldReturnCorrectValues() {
        let cache = Cache<String, Int>()
        cache.insert(42, forKey: "Answer")
        
        let retrievedValue = cache.value(forKey: "Answer")
        XCTAssertNotNil(retrievedValue, "The value should not be nil")
        XCTAssertEqual(retrievedValue, 42, "The retrieved value should be 42")
    }
    
    func test_retrieveNonExistentValue() {
        let cache = Cache<String, Int>()
        
        let retrievedValue = cache.value(forKey: "NonExistentKey")
        XCTAssertNil(retrievedValue, "The value should be nil for a non-existent key")
    }
    
    func test_removeValue_whenRemoveAnInsertedValue_shouldNotRetrieveValues() {
        let cache = Cache<String, Int>()
        cache.insert(42, forKey: "Answer")
        cache.removeValue(forKey: "Answer")
        
        let retrievedValue = cache.value(forKey: "Answer")
        XCTAssertNil(retrievedValue, "The value should be nil after it has been removed")
    }
    
    func test_retrieveMultipleValues_whenInsertMultipleValues_shouldReturnCorrectValues() {
        let cache = Cache<String, String>()
        cache.insert("Hello", forKey: "Greeting")
        cache.insert("World", forKey: "Object")
        
        let greetingValue = cache.value(forKey: "Greeting")
        XCTAssertNotNil(greetingValue, "The value should not be nil")
        XCTAssertEqual(greetingValue, "Hello", "The retrieved value should be 'Hello'")
        
        let objectValue = cache.value(forKey: "Object")
        XCTAssertNotNil(objectValue, "The value should not be nil")
        XCTAssertEqual(objectValue, "World", "The retrieved value should be 'World'")
    }
    
    func test_overwriteValue_givenTwoValuesWithTheSameKey_shouldRetrieveOnlyTheLatestOne() {
        let cache = Cache<String, Int>()
        cache.insert(42, forKey: "Answer")
        cache.insert(43, forKey: "Answer")
        
        let retrievedValue = cache.value(forKey: "Answer")
        XCTAssertNotNil(retrievedValue, "The value should not be nil")
        XCTAssertEqual(retrievedValue, 43, "The retrieved value should be the last inserted value, which is 43")
    }
}
