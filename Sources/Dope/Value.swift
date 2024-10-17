import CasePaths

@CasePathable
public enum Value: Equatable, Sendable, Hashable {
    case array([Self])
    case boolean(Bool)
    case null
    case number(Double)
    case object([String: Self])
    case string(String)
}

//extension Value: Identifiable {
//    public var id: Value {
//        if let string: String = try? lookUp(in: self, locator: .key("id", .string)) {
//            return .string(string)
//        }
//        if let number: Double = try? lookUp(in: self, locator: .key("id", .number)) {
//            return .number(number)
//        }
//        return .null
//    }
//}

extension Value: Codable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        
        // Check for null
        if container.decodeNil() {
            self = .null
            return
        }
        
        // Attempt to decode as Bool
        if let boolValue = try? container.decode(Bool.self) {
            self = .boolean(boolValue)
            return
        }
        
        // Attempt to decode as Double
        if let doubleValue = try? container.decode(Double.self) {
            self = .number(doubleValue)
            return
        }
        
        // Attempt to decode as String
        if let stringValue = try? container.decode(String.self) {
            self = .string(stringValue)
            return
        }
        
        // Attempt to decode as Array of Values
        if let arrayValue = try? container.decode([Value].self) {
            self = .array(arrayValue)
            return
        }
        
        // Attempt to decode as Dictionary with String keys and Value values
        if let objectValue = try? container.decode([String: Value].self) {
            self = .object(objectValue)
            return
        }
        
        // If none of the above succeeded, throw a decoding error
        throw DecodingError.typeMismatch(
            Value.self,
            DecodingError.Context(
                codingPath: decoder.codingPath,
                debugDescription: "Unable to decode Value from JSON"
            )
        )
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        
        switch self {
        case .null:
            try container.encodeNil()
        case .boolean(let boolValue):
            try container.encode(boolValue)
        case .number(let numberValue):
            try container.encode(numberValue)
        case .string(let stringValue):
            try container.encode(stringValue)
        case .array(let arrayValue):
            try container.encode(arrayValue)
        case .object(let objectValue):
            try container.encode(objectValue)
        }
    }
}
