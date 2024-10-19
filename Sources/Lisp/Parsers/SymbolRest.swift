//
//  File 2.swift
//  Dope
//
//  Created by Quico Moya on 18/10/24.
//

import Foundation
import Parsing

func isSymbolRest(_ c: UTF8.CodeUnit) -> Bool {
    let scalar = UnicodeScalar(c)
    return isSymbolHead(c) || ("0"..."9").contains(scalar) || scalar == "."
}


struct SymbolRestParser: ParserPrinter {
    var body: some ParserPrinter<Substring, Swift.String> {
        Prefix { isSymbolRest($0) }.map(.string)
    }
}
