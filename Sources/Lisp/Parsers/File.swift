//
//  File.swift
//  Dope
//
//  Created by Quico Moya on 18/10/24.
//
import Parsing

struct FileParser: ParserPrinter {
    var body: some ParserPrinter<Substring, File> {
        Many {
            FormParser()
        }
        .map(.memberwise(File.init))
    }
}
