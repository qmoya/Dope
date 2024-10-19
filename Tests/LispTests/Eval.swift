import Testing

@testable import Lisp

func evalAdd(args: Array<Form>.SubSequence) -> Form {
    
}

func eval(list: List) -> Form {
    guard let first = list.forms.first else {
        return .list(.init(forms: []))
    }
    switch first {
    case .literal(.symbol(.simple(.init(string: "+")))):
        let args = list.forms[1...]
        return evalAdd(args: args)
    default:
        fatalError("TODO")
    }
}

struct EvalTests {
    @Test func testAdd1() async throws {
        let list = List(
            forms: [
                .literal(.symbol(.simple(.init(string: "+")))),
                .literal(.number(.integer(1))),
                .literal(.number(.integer(2))),
            ]
        )
        
        let result = eval(list: list)
        
        #expect(result == .literal(.number(.integer(3))))
    }
    
    @Test func testAdd2() async throws {
        let list = List(
            forms: [
                .literal(.symbol(.simple(.init(string: "+")))),
                .literal(.number(.integer(2))),
                .literal(.number(.integer(2))),
            ]
        )
        
        let result = eval(list: list)
        
        #expect(result == .literal(.number(.integer(4))))
    }
}
