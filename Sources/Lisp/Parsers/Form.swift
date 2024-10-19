//
//  Form.swift
//  Dope
//
//  Created by Quico Moya on 18/10/24.
//
import Parsing

struct FormParser: Parser {
    var body: some Parser<Substring, Form> {
        Whitespace()

        OneOf {
            VectorParser()
                .map(Form.vector)
            
            LiteralParser()
                .map(Form.literal)
            
            ListParser()
                .map(Form.list)
        }
        
        Whitespace()
    }
}
