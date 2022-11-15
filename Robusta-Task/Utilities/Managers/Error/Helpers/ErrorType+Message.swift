//
//  ErrorType+Message.swift
//
//  Created by Abdelrhman Eliwa on 19/05/2022.
//

import Foundation

extension ErrorType {
    var message: String {
        switch self {
        case .connection: return "Connection Reason"
        case .unwrappedHttpClient: return "Unwrapped HTTP Client Reason"
        case .unwrappedHttpServer: return "Unwrapped HTTP Server Reason"
        case .mapping: return "Mapping Reason"
        case .logical: return "Logical Reason"
        case .hardware: return "Hardware Reason"
        case .exception: return "Exception Reason"
        case .permission: return "Permission Reason"
        case .validation: return "Validation Reason"
        case .unexpected: return "Unexpected Reason"
        }
    }
}
