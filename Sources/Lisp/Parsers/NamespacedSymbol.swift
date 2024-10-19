//
//  Name.swift
//  Dope
//
//  Created by Quico Moya on 18/10/24.
//
import Parsing

struct NamespacedSymbolParser: Parser {
    var body: some Parser<Substring, NamespacedSymbol> {
        Parse {
            NameParser()
            
            "/"
            
            SimpleSymbolParser().map { $0.string }
        }
        .map { (namespace, symbol) in
            NamespacedSymbol(namespace: namespace, symbol: symbol)
        }
    }
}
