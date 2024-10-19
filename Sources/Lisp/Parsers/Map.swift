//
//  Map.swift
//  Dope
//
//  Created by Quico Moya on 18/10/24.
//

import Parsing

struct MapParser: ParserPrinter {
    var body: some ParserPrinter<Substring, Map> {
        "{"
        
        Many {
            Parse {
                Whitespace()
                FormParser()
                Whitespace()
                FormParser()
                Whitespace()
            }
            .map(.memberwise(Map.Pair.init))
        }
        .map(.memberwise(Map.init))
        
        "}"
    }
}
