//
//  Literal.swift
//  Dope
//
//  Created by Quico Moya on 18/10/24.
//
import Parsing

struct ReaderMacroParser: Parser {
    var body: some Parser<Substring, Set> {
        OneOf {
            SetParser()
        }
    }
}
