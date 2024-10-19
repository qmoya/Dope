//
//  File.swift
//  Dope
//
//  Created by Quico Moya on 18/10/24.
//
import Parsing

struct FileParser: ParserPrinter {
    func print(_ output: File, into input: inout Substring) throws {
        let printer = Parse {
            Many {
                FormParser()
            } separator: {
                "\n"
            }
            .map(.memberwise(File.init))
        }
            
        try printer.print(output, into: &input)
    }
    
	var body: some ParserPrinter<Substring, File> {
		Parse {
			Whitespace()

            Many {
                Whitespace()
                FormParser()
                Whitespace()
            }
            .map(.memberwise(File.init))

			Whitespace()
		}
	}
}
