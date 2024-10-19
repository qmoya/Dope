//
//  Whitespace.swift
//  Dope
//
//  Created by Quico Moya on 18/10/24.
//

import Parsing

struct Whitespace: Parser {
    var body: some Parser<Substring, Void> {
        Parsing.Whitespace()
        Skip {
            Prefix { $0 == "," }
        }
    }
}
