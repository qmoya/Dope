//
//  String.swift
//  Dope
//
//  Created by Quico Moya on 18/10/24.
//

import Parsing

struct SimpleKeywordParser: ParserPrinter {
    var body: some ParserPrinter<Substring, SimpleKeyword> {
        Parse {
            ":"
            SymbolParser()

        }
        .map(.memberwise(SimpleKeyword.init))
    }
}

struct KeywordParser: ParserPrinter {
    var body: some ParserPrinter<Substring, Keyword> {
        OneOf {
            SimpleKeywordParser().map(.case(Keyword.simple))
        }
    }
}
