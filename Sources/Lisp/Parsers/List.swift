//
//  Vector.swift
//  Dope
//
//  Created by Quico Moya on 18/10/24.
//
import Parsing

struct ListParser: ParserPrinter {
    func print(_ output: List, into input: inout Substring) throws {
        let printer = Parse {
            "("

            Many {
                FormParser()
            } separator: {
                " "
            }

            ")"
        }
        .map(.memberwise(List.init))

        try printer.print(output, into: &input)
    }
    
	var body: some ParserPrinter<Substring, List> {
		Parse {
			"("

			Many {
				FormParser()
            } separator: {
                Whitespace()
            }

			")"
		}
		.map(.memberwise(List.init))
	}
}
