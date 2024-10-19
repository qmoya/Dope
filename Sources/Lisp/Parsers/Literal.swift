//
//  Literal.swift
//  Dope
//
//  Created by Quico Moya on 18/10/24.
//
import Parsing

struct LiteralParser: ParserPrinter {
    var body: some ParserPrinter<Substring, Literal> {
        OneOf {
            NumberParser()
                .map(.case(Literal.number))
            
            StringParser()
                .map(.case(Literal.string))

            NilParser()
                .map(.case(Literal.nil))

            BooleanParser()
                .map(.case(Literal.boolean))

            SymbolParser()
                .map(.case(Literal.symbol))

            KeywordParser()
                .map(.case(Literal.keyword))
        }
    }
}
