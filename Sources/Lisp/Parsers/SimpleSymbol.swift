//
//  Name.swift
//  Dope
//
//  Created by Quico Moya on 18/10/24.
//
import Parsing

struct SimpleSymbolParser: ParserPrinter {
    var body: some ParserPrinter<Substring, SimpleSymbol> {
        OneOf {
            ".".map(.case(SimpleSymbol.dot))
            
            NameParser().map(.case(SimpleSymbol.name))
        }
    }
}
