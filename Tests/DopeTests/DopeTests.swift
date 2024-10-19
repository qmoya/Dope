import Testing
@testable import Dope

@Test func stringPath() async throws {
    let value: Value = .string("hello")
    
    let result = value.string
    
    #expect(result == "hello")
}

@Test func objectPath() async throws {
    let value: Value = .object(["hello": .number(123.4)])
    
    let result = value.object
    
    #expect(result == ["hello": .number(123.4)])
}

@Test func objectValuePath() async throws {
    let value: Value = .object(["hello": .number(123.4)])
    
    let result = value.object?["hello"]
    
    #expect(result == .number(123.4))
}

@Test func objectNumberPath() async throws {
    let value: Value = .object(["hello": .number(123.4)])
    
    let result = value.object?["hello"]?.number
    
    #expect(result == 123.4)
}

@Test func arrayString() async throws {
    let value: Value = .array([.string("hello")])
    let result = value[0]?.string

    #expect(result == "hello")
}

@Test func assignArrayString() async throws {
    var value: Value = .array([.string("hello")])
    value[0] = .number(123)
    let result = value.array?[0].number

    #expect(result == 123)
}

@Test func assignObjectString() async throws {
    var value: Value = .object(["hello": .number(123.4)])
    value["hello"] = .string("bye")
    let result = value["hello"]?.string
    #expect(result == "bye")
}
