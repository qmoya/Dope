//
//  Lisp.swift
//  Dope
//
//  Created by Quico Moya on 18/10/24.
//
import Parsing

public enum Number: Equatable {
    case integer(Int)
}

//: string_
//| number
//| character
//| nil_
//| BOOLEAN
//| keyword
//| symbol
//| param_name
//;
public enum Literal: Equatable {
    case number(Number)
    case string(String)
    case `nil`(Nil)
    case boolean(Boolean)
    case keyword(Keyword)
    case symbol(Symbol)
}

public struct List: Equatable {
    let forms: [Form]
}

public enum Form: Equatable {
    case literal(Literal)
    case vector(Vector)
    case map(Map)
    case list(List)
    case whitespace(DopeWhitespace)
}

public struct Vector: Equatable {
    let forms: [Form]
}

public struct File: Equatable {
    let forms: [Form]
}

public enum Nil: Equatable {
    case `nil`
}

public struct Map: Equatable {
    struct Pair: Equatable {
        let key: Form
        let value: Form
    }
    
    let pairs: [Pair]
}

//reader_macro
//    : lambda_
//    | meta_data
//    | regex
//    | var_quote
//    | host_expr
//    | set_
//    | tag
//    | discard
//    | dispatch
//    | deref
//    | quote
//    | backtick
//    | unquote
//    | unquote_splicing
//    | gensym
//    ;

public struct Set: Equatable {
    let forms: [Form]
}

public enum ReaderMacro {
    case set(Set)
}

public struct Boolean: Equatable {
    let bool: Bool
}

public struct NamespacedSymbol: Equatable {
    let namespace: Name
    let symbol: SimpleSymbol
}

public enum SimpleSymbol: Equatable {
    case dot
    case name(Name)
}

public enum Symbol: Equatable {
    case namespaced(NamespacedSymbol)
    case simple(SimpleSymbol)
}

public struct SimpleKeyword: Equatable {
    let symbol: Symbol
}

public enum Keyword: Equatable {
    case simple(SimpleKeyword)
}
