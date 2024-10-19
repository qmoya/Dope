import Foundation
import Lisp
import SnapshotTesting
import Testing

@Test func readTests() throws {
	let urls = Bundle.module.urls(forResourcesWithExtension: "clj", subdirectory: "Examples")!

	for url in urls {
		print(url)
		let string = try String(contentsOf: url, encoding: .utf8)
		let read = try parse(string: string)

		assertSnapshot(of: read, as: .dump, named: url.lastPathComponent.appending("-read"))

		let print = try print(file: read)

		assertSnapshot(of: print, as: .lines, named: url.lastPathComponent.appending("-print"))
	}
}
