//
//  Lisp.swift
//  Dope
//
//  Created by Quico Moya on 18/10/24.
//
import Parsing

enum Number: Equatable {
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
enum Literal: Equatable {
    case number(Number)
    case string(String)
    case `nil`(Nil)
    case boolean(Boolean)
    case keyword(Keyword)
    case symbol(Symbol)
}

struct List: Equatable {
    let forms: [Form]
}

enum Form: Equatable {
    case literal(Literal)
    case vector(Vector)
    case map(Map)
    case list(List)
}

struct Vector: Equatable {
    let forms: [Form]
}

struct File: Equatable {
    let forms: [Form]
}

struct String: Equatable {
    let string: Swift.String
}

enum Nil: Equatable {
    case `nil`
}

struct Map: Equatable {
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

struct Set: Equatable {
    let forms: [Form]
}

enum ReaderMacro {
    case set(Set)
}

struct Boolean: Equatable {
    let bool: Bool
}

struct NamespacedSymbol: Equatable {
    let namespace: Swift.String
    let symbol: Swift.String
}

struct SimpleSymbol: Equatable {
    let string: Swift.String
}

enum Symbol: Equatable {
    case namespaced(NamespacedSymbol)
    case simple(SimpleSymbol)
}

struct SimpleKeyword: Equatable {
    let symbol: Symbol
}

enum Keyword: Equatable {
    case simple(SimpleKeyword)
}
