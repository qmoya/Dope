public func eval(file: File) -> Form {
	print(file)
	return .literal(.number(.integer(3)))
}

public func parse(string: String) throws -> File {
	try FileParser().parse(string)
}

public func print(file: File) throws -> String {
	try String(FileParser().print(file))
}
