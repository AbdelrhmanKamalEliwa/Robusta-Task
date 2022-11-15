//
//  MockData.swift
//  Robusta-TaskTests
//
//  Created by Abdelrhman Eliwa on 15/11/2022.
//

import Foundation
@testable import Robusta_Task

struct MockData {
    static func repos() -> [ReposResponse] {
        Array(repeating: .init(), count: 10)
    }
    
    static let unexpectedError: BaseError = ErrorResolver.shared.getError(for: ErrorType.unexpected)
}

// MARK: - MOCK ReposResponse
extension ReposResponse {
    init() {
        self.init(id: 1, name: "Name", fullName: "Full Name", isPrivate: false, owner: .init(id: 1, avatarURL: ""))
    }
}
