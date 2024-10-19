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

            Whitespace()

			Many {
				FormParser()
			} separator: {
                " "
            }
            
            Whitespace()

			"]"
		}
		.map(.memberwise(Vector.init))
	}
}
