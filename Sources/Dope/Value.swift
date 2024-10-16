public enum Value: Equatable, Sendable, Hashable {
    case array([Self])
    case boolean(Bool)
    case null
    case number(Double)
    case object([String: Self])
    case string(String)
}

extension Value: Identifiable {
    public var id: Value {
        if let string: String = try? locate(.key("id", .string), in: self) {
            return .string(string)
        }
        if let number: Double = try? locate(.key("id", .number), in: self) {
            return .number(number)
        }
        return .null
    }
}

extension Value: Decodable {
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
                debugDescription: "Unable to decode Value from JSON."
            )
        )
    }
}
