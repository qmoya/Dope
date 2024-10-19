//
//  Number.swift
//  Dope
//
//  Created by Quico Moya on 18/10/24.
//
import Parsing

struct NumberParser: Parser {
    var body: some Parser<Substring, Number> {
        Int.parser()
            .map(Number.integer)
    }
}
