////
////  Whitespace.swift
////  Dope
////
////  Created by Quico Moya on 18/10/24.
////
//
// import Parsing
//
// struct Whitespace: Equatable {
//    init(string: String) {
//        self.string = string
//    }
//
//    let string: String
// }
//
// struct WhitespaceParser: ParserPrinter {
//    var body: some ParserPrinter<Substring, Whitespace> {
//        Parse {
//            Parsing.Whitespace()
//            Prefix { $0 == "," }.map(.string)
//        }
//        .map(.memberwise(Whitespace.init))
//    }
// }
//
// enum DopeWhitespace {
//    case betweenForms
// }
