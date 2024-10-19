import CasePaths

@CasePathable @dynamicMemberLookup
public enum Value: Equatable, Sendable, Hashable {
	case array([Self])
	case boolean(Bool)
	case null
	case number(Double)
	case object([String: Self])
	case string(String)
}

public extension Value {
	subscript(key: String) -> Value? {
		get {
			self.object?[key]
		}
		set {
			self.modify(\.object) { dict in
				dict[key] = newValue
			}
		}
	}

	subscript(index: Int) -> Value? {
		get {
			self.array?[index]
		}
		set {
			self.modify(\.array) { array in
				if let newValue {
					array[index] = newValue
				} else {
					array[index] = .null
				}
			}
		}
	}
}

// extension Value: Identifiable {
//    public var id: Value {
//        if let string: String = try? lookUp(in: self, locator: .key("id", .string)) {
//            return .string(string)
//        }
//        if let number: Double = try? lookUp(in: self, locator: .key("id", .number)) {
//            return .number(number)
//        }
//        return .null
//    }
// }

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
		case let .boolean(boolValue):
			try container.encode(boolValue)
		case let .number(numberValue):
			try container.encode(numberValue)
		case let .string(stringValue):
			try container.encode(stringValue)
		case let .array(arrayValue):
			try container.encode(arrayValue)
		case let .object(objectValue):
			try container.encode(objectValue)
		}
	}
}
