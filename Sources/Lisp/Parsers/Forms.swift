//
//  Forms.swift
//  Dope
//
//  Created by Quico Moya on 18/10/24.
//
import Parsing

struct FormsParser: ParserPrinter {
    var body: some ParserPrinter<Substring, [Form]> {
        Many {
            Whitespace()
            FormParser()
            Whitespace()
        }
    }
}
