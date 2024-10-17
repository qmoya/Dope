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

extension Value {
    public subscript<T>(_ locator: Locator) -> T? {
        try? lookUp(in: self, locator: locator)
    }

    public subscript<T>(_ locator: Locator, default defaultValue: T) -> T {
        guard let value: T = try? lookUp(in: self, locator: locator) else {
            return defaultValue
        }
        return value
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
