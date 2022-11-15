//
//  FetchReposUseCaseTest.swift
//  Robusta-TaskTests
//
//  Created by Abdelrhman Eliwa on 15/11/2022.
//

import XCTest
import Combine
@testable import Robusta_Task

final class FetchReposUseCaseTest: XCTestCase {
    
    // MARK: - PROPERTIES
    private var sut: FetchReposUseCase!
    private var validRepository: ReposRepositoryContract!
    private var inValidRepository: ReposRepositoryContract!
    
    // MARK: - LIFECYCLE
    override func setUp() {
        super.setUp()
        sut = FetchReposUseCase()
        validRepository = MockValidReposRepository()
        inValidRepository = MockInValidReposRepository()
    }
    
    override func tearDown() {
        sut = nil
        validRepository = nil
        inValidRepository = nil
        super.tearDown()
    }
    
    // MARK: - METHODS
    //
    func testSUT_whenExecutingUseCaseCorrectly_validResponseReturned() {
        // Given
        let exp = expectation(description: "testSUT_whenExecutingUseCaseCorrectly_validResponseReturned")
        let sut = FetchReposUseCase(repository: validRepository)
        var data: [ReposResponse]?
        
        // When
        sut
            .execute(offset: 0, limit: 10)
            .sink { completion in
                guard case .failure(let error) = completion else { return }
                XCTFail("Expected to recieve value while execute instead of \(error)")
            } receiveValue: { response in
                data = response
                exp.fulfill()
            }
            .store(in: &sut.cancellables)
        
        waitForExpectations(timeout: 1.0)
        
        // Then
        XCTAssertNotNil(data)
    }
    
    func testSUT_whenExecutingUseCaseIncorrectly_invalidResponseReturned() {
        // Given
        let exp = expectation(description: "testSUT_whenExecutingUseCaseIncorrectly_invalidResponseReturned")
        let sut = FetchReposUseCase(repository: inValidRepository)
        var tempError: BaseError?
        
        // When
        sut
            .execute(offset: 0, limit: 10)
            .sink { completion in
                if case .failure(let error) = completion {
                    tempError = error
                } else {
                    XCTFail("Expected to Fail")
                }
                exp.fulfill()
            } receiveValue: { _ in
                XCTFail("Expected to Fail")
            }
            .store(in: &sut.cancellables)
        
        waitForExpectations(timeout: 1.0)
        
        // Then
        XCTAssertEqual(tempError, MockData.unexpectedError)
    }
    
}
