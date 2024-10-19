//
//  Name.swift
//  Dope
//
//  Created by Quico Moya on 18/10/24.
//
import Parsing

struct NameParser: Parser {
    struct TailParser: Parser {
        var body: some Parser<Substring, Swift.String> {
            Many {
                SymbolRestParser()
            } separator: {
                ":"
            }
            .map { $0.joined(separator: ":") }
        }
    }
    
    var body: some Parser<Substring, Swift.String> {
        Parse {
            Parse {
                SymbolHeadParser()
                SymbolRestParser()
            }
            .map { $0 + $1 }
            
            Optionally {
                ":"
                
                TailParser()
            }
        }
        .map { (first: Swift.String, rest: Swift.String?) in
            guard let rest else {
                return first
            }
            
            return [first, rest].joined(separator: ":")
        }
    }
}
