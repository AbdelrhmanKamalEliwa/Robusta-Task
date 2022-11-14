//
//  debugPrint+Logger.swift
//
//  Created by Abdelrhman Eliwa on 03/01/2022.
//

import Foundation

public func debugPrint(
    _ items: String...,
    separator: String = " ",
    terminator: String = "\n",
    event: LogEvent = .information,
    function: String = #function,
    filename: String = #file,
    line: Int = #line,
    column: Int = #column
) {
    let output = items.joined(separator: separator)
    Logger.shared.print(
        output,
        event: event,
        filename: filename,
        line: line,
        column: column,
        function: function
    )
}

public func debugPrint<T>(
    _ items: T...,
    separator: String = " ",
    terminator: String = "\n",
    event: LogEvent = .information,
    function: String = #function,
    filename: String = #file,
    line: Int = #line,
    column: Int = #column
) {
    let output = items.map { "\($0)" }.joined(separator: separator)
    Logger.shared.print(
        output,
        event: event,
        filename: filename,
        line: line,
        column: column,
        function: function
    )
}

public func debugPrint<T>(
    _ items: T?...,
    separator: String = " ",
    terminator: String = "\n",
    event: LogEvent = .information,
    function: String = #function,
    filename: String = #file,
    line: Int = #line,
    column: Int = #column
) {
    let output = items.map { item in
        if let item = item { return "\(item)" } else { return "(nil)" }
    }.joined(separator: separator)
    
    Logger.shared.print(
        output,
        event: event,
        filename: filename,
        line: line,
        column: column,
        function: function
    )
}

public func debugPrint(
    _ items: Any...,
    separator: String = " ",
    terminator: String = "\n"
) {
    let output = items.map { "\($0)" }.joined(separator: separator)
    Logger.shared.print(
        output,
        event: .information,
        filename: #file,
        line: #line,
        column: #column,
        function: #function)
}
