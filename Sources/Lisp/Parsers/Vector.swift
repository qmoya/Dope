//
//  Vector.swift
//  Dope
//
//  Created by Quico Moya on 18/10/24.
//
import Parsing

struct VectorParser: ParserPrinter {
    var body: some ParserPrinter<Substring, Vector> {
        Parse {
            "["
            
            Many {
                Whitespace()
                FormParser()
                Whitespace()
            }
            
            "]"
        }
        .map(.memberwise(Vector.init))
    }
}

