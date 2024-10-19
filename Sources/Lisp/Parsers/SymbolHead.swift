//
//  Name.swift
//  Dope
//
//  Created by Quico Moya on 18/10/24.
//
import Parsing

func isSymbolHead(_ c: UTF8.CodeUnit) -> Bool {
    let scalar = UnicodeScalar(c)
    switch scalar {
    case "0"..."9",
         "^", "`", "'", "\"", "#", "~", "@", ":", "/", "%",
         "(", ")", "[", "]", "{", "}",
         " ", "\n", "\r", "\t", ",":
        return false
    default:
        return true
    }
}

struct SymbolHeadParser: Parser {
    var body: some Parser<Substring, Swift.String> {
        Prefix(1) { isSymbolHead($0) }.map(.string)
    }
}
