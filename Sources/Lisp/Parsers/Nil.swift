//
//  Nil.swift
//  Dope
//
//  Created by Quico Moya on 18/10/24.
//

import Parsing

struct NilParser: Parser {
    var body: some Parser<Substring, Nil> {
        "nil".map { Nil.nil }
    }
}
