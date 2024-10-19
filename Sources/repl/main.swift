import Foundation
import SwiftSyntax
import SwiftParser
import Lisp

enum REPLError: Error {
    case compilation(String?)
    case execution(String?)
}

func evaluateSwiftCode(_ code: String, directory tempDirURL: URL) throws(REPLError) -> String {
    // Create a temporary directory
    try? FileManager.default.createDirectory(at: tempDirURL, withIntermediateDirectories: true, attributes: nil)
    
    let sourceFileURL = tempDirURL.appendingPathComponent("UserCode.swift")
    let executableURL = tempDirURL.appendingPathComponent("UserCode")
        
    // Write the code to the source file
    do {
        try code.write(to: sourceFileURL, atomically: true, encoding: .utf8)
    } catch {
        return "Error writing code to file: \(error)"
    }
    
    // Compile the code
    let compileProcess = Process()
    compileProcess.executableURL = URL(fileURLWithPath: "/usr/bin/env")
    compileProcess.arguments = ["swiftc", sourceFileURL.path, "-o", executableURL.path]
    
    let compilePipe = Pipe()
    compileProcess.standardError = compilePipe
    
    do {
        try compileProcess.run()
        compileProcess.waitUntilExit()
    } catch {
        return "Error during compilation: \(error)"
    }
    
    // Check compilation status
    if compileProcess.terminationStatus != 0 {
        let errorData = compilePipe.fileHandleForReading.readDataToEndOfFile()
        let errorMessage = String(data: errorData, encoding: .utf8)
        throw .compilation(errorMessage)
    }
    
    // Execute the compiled binary
    let executeProcess = Process()
    executeProcess.executableURL = executableURL
    let executePipe = Pipe()
    executeProcess.standardOutput = executePipe
    executeProcess.standardError = executePipe
    
    do {
        try executeProcess.run()
        executeProcess.waitUntilExit()
    } catch {
        throw .execution(nil)
    }
    
    // Capture the output
    let outputData = executePipe.fileHandleForReading.readDataToEndOfFile()
    let output = String(data: outputData, encoding: .utf8) ?? "No output"
    
    return output
}

// Function to start the CLI loop
func startCLI(fileManager: FileManager = .default) {
    let tempDirURL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(UUID().uuidString)
    print("\(tempDirURL)")

    var statements: [String] = []
    
    while true {
        // Display the prompt without a newline
        print("> ", terminator: "")
        fflush(stdout) // Ensure the prompt is displayed immediately

        // Read user input
        if let input = readLine() {
            let nextStatements = statements + [input]
            do {
                let parsed = try parse(string: nextStatements.joined(separator: "\n"))
                let result = eval(file: parsed)
                print(try print(file: parsed))
                statements.append(input)
            } catch {
                print(error)
            }
        } else {
            // If readLine() returns nil, exit the loop
            break
        }
    }
}

// Start the CLI
startCLI()
