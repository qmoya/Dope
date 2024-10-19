//
//  Nil.swift
//  Dope
//
//  Created by Quico Moya on 18/10/24.
//

import Parsing

struct BooleanParser: Parser {
    var body: some Parser<Substring, Boolean> {
        Bool.parser().map { Boolean(bool: $0) }
    }
}
