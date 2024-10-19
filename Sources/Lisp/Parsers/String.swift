//
//  String.swift
//  Dope
//
//  Created by Quico Moya on 18/10/24.
//

import Parsing

struct StringParser: ParserPrinter {
    var body: some ParserPrinter<Substring, String> {
        Parse {
            "\""
            Prefix { $0 != "\"" }
            "\""
        }.map(.string)
    }
}
