//
//  Form.swift
//  Dope
//
//  Created by Quico Moya on 18/10/24.
//
import Parsing
import Foundation

struct FormParser: ParserPrinter {
    var body: some ParserPrinter<Substring, Form> {
        Parse {
            Whitespace()
            
            OneOf {
                VectorParser()
                    .map(.case(Form.vector))
                
                LiteralParser()
                    .map(.case(Form.literal))
                
                ListParser()
                    .map(.case(Form.list))
                
//                CharacterSet.whitespacesAndNewlines.map(.case(Form.whitespace))
            }
            
            Whitespace()
        }
    }
}
