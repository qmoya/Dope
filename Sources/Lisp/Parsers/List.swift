//
//  Vector.swift
//  Dope
//
//  Created by Quico Moya on 18/10/24.
//
import Parsing

struct ListParser: ParserPrinter {
	var body: some ParserPrinter<Substring, List> {
		Parse {
			"("

			Many {
				Whitespace()
				FormParser()
			}

			")"
		}
		.map(.memberwise(List.init))
	}
}
