//
//  Nil.swift
//  Dope
//
//  Created by Quico Moya on 18/10/24.
//

import Parsing

struct BooleanParser: ParserPrinter {
    var body: some ParserPrinter<Substring, Boolean> {
        Bool.parser().map(.memberwise(Boolean.init))
    }
}
