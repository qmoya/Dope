//
//  Name.swift
//  Dope
//
//  Created by Quico Moya on 18/10/24.
//
import Parsing

struct SimpleSymbolParser: Parser {
    var body: some Parser<Substring, SimpleSymbol> {
        OneOf {
            ".".map { "." }
            
            NameParser()
        }
        .map { SimpleSymbol(string: $0)}
    }
}
