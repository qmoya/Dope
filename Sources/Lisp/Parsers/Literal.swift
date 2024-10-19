//
//  Literal.swift
//  Dope
//
//  Created by Quico Moya on 18/10/24.
//
import Parsing

struct LiteralParser: Parser {
    var body: some Parser<Substring, Literal> {
        OneOf {
            NumberParser()
                .map(Literal.number)
            
            StringParser()
                .map(Literal.string)
            
            NilParser()
                .map(Literal.nil)
            
            BooleanParser()
                .map(Literal.boolean)
            
            SymbolParser()
                .map(Literal.symbol)
            
            KeywordParser()
                .map(Literal.keyword)
        }
    }
}
