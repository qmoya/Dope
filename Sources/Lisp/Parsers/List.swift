//
//  Vector.swift
//  Dope
//
//  Created by Quico Moya on 18/10/24.
//
import Parsing

struct ListParser: Parser {
    var body: some Parser<Substring, List> {
        Parse {
            "("
            FormsParser()
            ")"
        }
        .map { List(forms: $0) }
    }
}

