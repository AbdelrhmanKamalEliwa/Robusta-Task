//
//  ErrorType+Code.swift
//
//  Created by Abdelrhman Eliwa on 19/05/2022.
//

import Foundation

extension ErrorType {
    var code: Int {
        switch self {
        case .connection: return ErrorConstants.Code.connectionCode
        case .unwrappedHttpClient: return ErrorConstants.Code.unwrappedHttpClientCode
        case .unwrappedHttpServer: return ErrorConstants.Code.unwrappedHttpServerCode
        case .mapping: return ErrorConstants.Code.mappingCode
        case .logical: return ErrorConstants.Code.logicalCode
        case .hardware: return ErrorConstants.Code.hardwareCode
        case .exception: return ErrorConstants.Code.exceptionCode
        case .permission: return ErrorConstants.Code.permissionCode
        case .validation: return ErrorConstants.Code.validationCode
        case .unexpected: return ErrorConstants.Code.unexpectedCode
        }
    }
}
