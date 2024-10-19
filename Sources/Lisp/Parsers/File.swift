//
//  File.swift
//  Dope
//
//  Created by Quico Moya on 18/10/24.
//
import Parsing

struct FileParser: Parser {
    init() {}
    
    var body: some Parser<Substring, File> {
        Many {
            FormParser()
        }
        .map { File(forms: $0) }
    }
}
