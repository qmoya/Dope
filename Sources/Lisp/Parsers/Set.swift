//
//  Vector.swift
//  Dope
//
//  Created by Quico Moya on 18/10/24.
//
import Parsing

struct SetParser: Parser {
	var body: some Parser<Substring, Set> {
		Parse {
			"#{"

			Many {
				Whitespace()
				FormParser()
			}

			"}"
		}
		.map { Set(forms: $0) }
	}
}
