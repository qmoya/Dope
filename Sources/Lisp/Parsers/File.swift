//
//  File.swift
//  Dope
//
//  Created by Quico Moya on 18/10/24.
//
import Parsing

struct FileParser: ParserPrinter {
	var body: some ParserPrinter<Substring, File> {
		Parse {
			Whitespace()

			Many {
				Whitespace()
				FormParser()
                Whitespace()
            } separator: {
                " "
            }
			.map(.memberwise(File.init))

			Whitespace()
		}
	}
}
