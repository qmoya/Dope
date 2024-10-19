//
//  Nil.swift
//  Dope
//
//  Created by Quico Moya on 18/10/24.
//

import Parsing

struct NilParser: ParserPrinter {
    var body: some ParserPrinter<Substring, Nil> {
        "nil".map(.case(Nil.nil))
    }
}
