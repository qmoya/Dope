//
//  String.swift
//  Dope
//
//  Created by Quico Moya on 18/10/24.
//

import Parsing

struct StringParser: Parser {
    var body: some Parser<Substring, String> {
        Parse {
            "\""
            Prefix { $0 != "\"" }
            "\""
        }
        .map { String($0) }
    }
}
