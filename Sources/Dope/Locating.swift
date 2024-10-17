public struct LocatingError: Error, Sendable {
    public let locator: Locator
}

public indirect enum Locator: Equatable, Sendable {
    case string
    case number
    case object
    case array
    case boolean
    case index(Int, Locator)
    case key(String, Locator)
}

let value: Value = .object(["hello": .number(123)])

extension Value {
    public subscript<T>(_ locator: Locator) -> T? {
        try? lookUp(in: self, locator: locator)
    }

    public subscript<T>(_ locator: Locator, default defaultValue: T) -> T {
        get {
            guard let value: T = try? lookUp(in: self, locator: locator) else {
                return defaultValue
            }
            return value
        }
        set {
            self = update(in: self, locator: locator, newValue: newValue)
        }
    }
}

private func update<T>(in value: Value, locator: Locator, newValue: T) -> Value {
    var newValueToSet = value
    
    switch locator {
    case .number:
        if newValue is Double {
            return .number(newValue as! Double)
        }
    case .string:
        if newValue is String {
            return .string(newValue as! String)
        }
    case .boolean:
        if newValue is Bool {
            return .boolean(newValue as! Bool)
        }
    case .object:
        if let dict = newValue as? [String: Value] {
            return .object(dict)
        }
    case .array:
        if let array = newValue as? [Value] {
            return .array(array)
        }
    case let .index(index, innerLocator):
        if case var .array(array) = newValueToSet {
            if index >= 0 && index < array.count {
                array[index] = update(in: array[index], locator: innerLocator, newValue: newValue)
                return .array(array)
            }
        }
    case let .key(key, innerLocator):
        if case var .object(object) = newValueToSet {
            if let existingValue = object[key] {
                object[key] = update(in: existingValue, locator: innerLocator, newValue: newValue)
            } else {
                object[key] = Value(newValue: newValue, for: innerLocator)
            }
            return .object(object)
        }
    }
    
    return value // If nothing is modified, return the original value
}

extension Value {
    init<T>(newValue: T, for locator: Locator) {
        switch locator {
        case .number:
            self = .number(newValue as? Double ?? 0.0)
        case .string:
            self = .string(newValue as? String ?? "")
        case .boolean:
            self = .boolean(newValue as? Bool ?? false)
        case .object:
            self = .object(newValue as? [String: Value] ?? [:])
        case .array:
            self = .array(newValue as? [Value] ?? [])
        default:
            self = .null
        }
    }
}

func lookUp<T>(in value: Value, locator: Locator) throws(LocatingError) -> T {
    switch locator {
    case .number:
        guard case let .number(double) = value, let v = double as? T else {
            throw LocatingError(locator: locator)
        }
        return v
    case .string:
        guard case let .string(string) = value, let v = string as? T else {
            throw LocatingError(locator: locator)
        }
        return v
    case .object:
        guard case .object = value, let v = value as? T else {
            throw LocatingError(locator: locator)
        }
        return v
    case .array:
        guard case let .array(array) = value, let array = array as? T else {
            throw LocatingError(locator: locator)
        }
        return array
    case .boolean:
        guard case let .boolean(boolean) = value, let v = boolean as? T else {
            throw LocatingError(locator: locator)
        }
        return v
    case let .index(index, innerLocator):
        guard case let .array(array) = value else {
            throw LocatingError(locator: locator)
        }
        return try lookUp(in: array[index], locator: innerLocator)
    case let .key(key, innerLocator):
        guard case let .object(object) = value,
            let dictionaryValue = object[key]
        else {
            throw LocatingError(locator: locator)
        }
        return try lookUp(in: dictionaryValue, locator: innerLocator)
    }
}

// alternate syntax?
func get<T>(in value: Value, locator: Locator) -> T? {
    try? lookUp(in: value, locator: locator)
}
