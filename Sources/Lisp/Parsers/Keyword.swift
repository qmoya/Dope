//
//  String.swift
//  Dope
//
//  Created by Quico Moya on 18/10/24.
//

import Parsing

struct SimpleKeywordParser: Parser {
    var body: some Parser<Substring, SimpleKeyword> {
        Parse {
            ":"
            SymbolParser()

        }
        .map { SimpleKeyword(symbol: $0) }
    }
}

struct KeywordParser: Parser {
    var body: some Parser<Substring, Keyword> {
        OneOf {
            SimpleKeywordParser().map(Keyword.simple)
        }
    }
}