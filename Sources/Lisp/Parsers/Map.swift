//
//  Map.swift
//  Dope
//
//  Created by Quico Moya on 18/10/24.
//

import Parsing

struct MapParser: Parser {
    var body: some Parser<Substring, Map> {
        "{"
        Many {
            Parse {
                FormParser()
                Whitespace()
                FormParser()
            }
            .map(Map.Pair.init)
        }
        .map(Map.init)
        "}"
    }
}
