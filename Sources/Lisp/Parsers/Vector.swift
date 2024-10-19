//
//  Vector.swift
//  Dope
//
//  Created by Quico Moya on 18/10/24.
//
import Parsing

struct VectorParser: Parser {
    var body: some Parser<Substring, Vector> {
        Parse {
            "["
            FormsParser()
            "]"
        }
        .map { Vector(forms: $0) }
    }
}

