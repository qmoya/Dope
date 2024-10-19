//
//  Test.swift
//  Dope
//
//  Created by Quico Moya on 18/10/24.
//

import Testing
@testable import Lisp

struct Test {
    @Test func testVectorFile() async throws {
        var file: Substring = """
        [1]
        """

        let expected = File(forms: [.vector(Vector(forms: [.literal(.number(.integer(1)))]))])
        let parser = FileParser()
        let result: File = try parser.parse(&file)
        
        #expect(result == expected)
        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
    }

    @Test func testEmptyFile() async throws {
        var file: Substring = "   "

        let expected = File(forms: [])
        let parser = FileParser()
        let result: File = try parser.parse(&file)
        
        #expect(result == expected)
        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
    }
    
    @Test func testNumberParsing() async throws {
        var s: Substring = "1"
        let parser = NumberParser()
        let result = try parser.parse(&s)
        #expect(result == Number.integer(1))
    }
    
    @Test func testVectorParsing() async throws {
        var s: Substring = "[1]"
        let parser = VectorParser()
        let result = try parser.parse(&s)
        #expect(result == Vector(forms: [.literal(.number(.integer(1)))]))
    }
    
    @Test func testTwoIntegersVectorParsing() async throws {
        var s: Substring = "[1 2]"
        let parser = VectorParser()
        let result = try parser.parse(&s)
        #expect(result == Vector(forms: [.literal(.number(.integer(1))), .literal(.number(.integer(2)))]))
    }
    
    @Test func testNestedVectors() async throws {
        var s: Substring = "[1 [2 3]]"
        let parser = VectorParser()
        let result = try parser.parse(&s)
        #expect(result == Vector(forms: [Lisp.Form.literal(Lisp.Literal.number(Lisp.Number.integer(1))), Lisp.Form.vector(Lisp.Vector(forms: [Lisp.Form.literal(Lisp.Literal.number(Lisp.Number.integer(2))), Lisp.Form.literal(Lisp.Literal.number(Lisp.Number.integer(3)))]))]))
    }
    
    @Test func testFormVectorParsing() async throws {
        var s: Substring = "[1]"
        let parser = FormParser()
        let result = try parser.parse(&s)
        #expect(result == Form.vector(Vector(forms: [.literal(.number(.integer(1)))])))
    }
    
    @Test func testStringParsing() async throws {
        var s: Substring = "\"foo\""
        let parser = StringParser()
        let result = try parser.parse(&s)
        #expect(result == String(string: "foo"))
    }
    
    @Test func testHeterogeneusVectorParsing() async throws {
        var s: Substring = #"[1 "two"]"#
        let parser = VectorParser()
        let result = try parser.parse(&s)
        #expect(result == Vector(forms: [.literal(.number(.integer(1))), .literal(.string(String(string: "two")))]))
    }
    
    @Test func testHeterogeneusVectorParsingWithComma() async throws {
        var s: Substring = #"[1, "two"]"#
        let parser = VectorParser()
        let result = try parser.parse(&s)
        #expect(result == Vector(forms: [.literal(.number(.integer(1))), .literal(.string(String(string: "two")))]))
    }
    
    @Test func testComma() async throws {
        var s: Substring = #",,,,, ,,,,"#
        let parser = Whitespace()
        let result: Void = try parser.parse(&s)
        #expect(result == ())
    }
    
    @Test func testEmptyList() async throws {
        var s: Substring = #"()"#
        let parser = Whitespace()
        let result: Void = try parser.parse(&s)
        #expect(result == ())
    }
    
    @Test func testNil() async throws {
        var s: Substring = #"nil"#
        let parser = NilParser()
        let result = try parser.parse(&s)
        #expect(result == Nil.nil)
    }
    
    @Test func testMap() async throws {
        var s: Substring = #"{"foo" 1}"#
        let parser = MapParser()
        let result = try parser.parse(&s)
        #expect(result == Map(pairs: [.init(key: .literal(.string(.init(string: "foo"))), value: .literal(.number(.integer(1))))]))
    }
    
    @Test func testList() async throws {
        var s: Substring = #"(1 "two")"#
        let parser = ListParser()
        let result = try parser.parse(&s)
        #expect(result == List(forms: [.literal(.number(.integer(1))), .literal(.string(String(string: "two")))]))
    }
    
    @Test func testSet() async throws {
        var s: Substring = #"#{1 "two"}"#
        let parser = SetParser()
        let result = try parser.parse(&s)
        #expect(result == Set(forms: [.literal(.number(.integer(1))), .literal(.string(String(string: "two")))]))
    }
    
    @Test func testTrue() async throws {
        var s: Substring = #"true"#
        let parser = BooleanParser()
        let result = try parser.parse(&s)
        #expect(result == Boolean(bool: true))
    }
    
    @Test func testFalse() async throws {
        var s: Substring = #"false"#
        let parser = BooleanParser()
        let result = try parser.parse(&s)
        #expect(result == Boolean(bool: false))
    }
    
    @Test func testName() async throws {
        var s: Substring = "foo:bar.baz:qux"
        let parser = NameParser()
        let result = try parser.parse(&s)
        #expect(result == "foo:bar.baz:qux")
    }
    
    @Test func testSimpleSymbol() async throws {
        var s: Substring = "foo:bar.baz:qux"
        let parser = SimpleSymbolParser()
        let result = try parser.parse(&s)
        #expect(result == SimpleSymbol(string :"foo:bar.baz:qux"))
    }
    
    @Test func testNamespacedSymbol() async throws {
        var s: Substring = "clojure/foo:bar.baz:qux"
        let parser = NamespacedSymbolParser()
        let result = try parser.parse(&s)
        #expect(result == NamespacedSymbol(namespace: "clojure", symbol: "foo:bar.baz:qux"))
    }
    
    @Test func testSymbolNamespacedSymbol() async throws {
        var s: Substring = "clojure/foo:bar.baz:qux"
        let parser = SymbolParser()
        let result = try parser.parse(&s)
        #expect(result == Symbol.namespaced(NamespacedSymbol(namespace: "clojure", symbol: "foo:bar.baz:qux")))
    }
    
    @Test func testSymbolSimpleSymbol() async throws {
        var s: Substring = "foo:bar.baz:qux"
        let parser = SymbolParser()
        let result = try parser.parse(&s)
        #expect(result == Symbol.simple(SimpleSymbol(string :"foo:bar.baz:qux")))
    }
}
