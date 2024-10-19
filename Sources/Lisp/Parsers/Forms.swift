//
//  Forms.swift
//  Dope
//
//  Created by Quico Moya on 18/10/24.
//
import Parsing

struct FormsParser: Parser {
    var body: some Parser<Substring, [Form]> {
        Many {
            FormParser()
        }
    }
}
