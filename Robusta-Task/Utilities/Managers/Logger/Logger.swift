//
//  Logger.swift
//  Repositories
//
//  Created by Abdelrhman Eliwa on 09/11/2022.
//

import Foundation

public enum LogEvent: String {
    case error = "‼️"
    case information = "ℹ️"
    case debug = "💬"
    case verbose = "🔬"
    case warning = "⚠️"
    case critical = "🔥"
}

public final class Logger {
    static let shared = Logger()
    
    private var date: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd hh:mm:ss a"
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone.current
        
        return formatter.string(from: Date())
    }
    
    // MARK: - Properties
    private init() {}
    
    func error(
        _ object: Any,
        filename: String = #file,
        line: Int = #line,
        column: Int = #column,
        function: String = #function
    ) {
        print(
            object,
            event: .error,
            filename: filename,
            line: line,
            column: column,
            function: function
        )
    }
    
    func information(
        _ object: Any,
        filename: String = #file,
        line: Int = #line,
        column: Int = #column,
        function: String = #function
    ) {
        print(
            object,
            event: .information,
            filename: filename,
            line: line,
            column: column,
            function: function
        )
    }
    
    func debug(
        _ object: Any,
        filename: String = #file,
        line: Int = #line,
        column: Int = #column,
        function: String = #function
    ) {
        print(
            object,
            event: .debug,
            filename: filename,
            line: line,
            column: column,
            function: function
        )
    }
    
    func verbose(
        _ object: Any,
        filename: String = #file,
        line: Int = #line,
        column: Int = #column,
        function: String = #function
    ) {
        print(
            object,
            event: .verbose,
            filename: filename,
            line: line,
            column: column,
            function: function
        )
    }
    
    func warning(
        _ object: Any,
        filename: String = #file,
        line: Int = #line,
        column: Int = #column,
        function: String = #function
    ) {
        print(
            object,
            event: .warning,
            filename: filename,
            line: line,
            column: column,
            function: function
        )
    }
    
    func critical(
        _ object: Any,
        filename: String = #file,
        line: Int = #line,
        column: Int = #column,
        function: String = #function
    ) {
        print(
            object,
            event: .critical,
            filename: filename,
            line: line,
            column: column,
            function: function
        )
    }
    
    private func sourceFileName(filePath: String) -> String {
        let components = filePath.components(separatedBy: "/")
        return components.isEmpty ? "" : (components.last ?? "")
    }
    
    func print(
        _ object: Any,
        event: LogEvent,
        filename: String,
        line: Int,
        column: Int,
        function: String
    ) {
        #if DEBUG
        Swift.print("""
            \(event.rawValue): [
                Date: \(date),
                File: \(sourceFileName(filePath: filename)),
                Line: \(line),
                Column: \(column),
                Function: \(function),
                Output: \(object)
            ]
            """
        )
        #endif
    }
}

