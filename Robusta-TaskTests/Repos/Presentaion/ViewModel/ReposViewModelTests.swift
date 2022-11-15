//
//  ReposViewModelTests.swift
//  Robusta-TaskTests
//
//  Created by Abdelrhman Eliwa on 15/11/2022.
//

import XCTest
import Combine
@testable import Robusta_Task

final class ReposViewModelTests: XCTestCase {

    // MARK: - PROPERTIES
    private var sut: ReposViewModel!
    private var validUseCase: FetchReposUseCaseContract!
    private var inValidUseCase: FetchReposUseCaseContract!

    // MARK: - LIFECYCLE
    override func setUp() {
        super.setUp()
        sut = ReposViewModel()
        validUseCase = MockValidFetchReposUseCase()
        inValidUseCase = MockInValidFetchReposUseCase()
    }

    override func tearDown() {
        sut = nil
        validUseCase = nil
        inValidUseCase = nil
        super.tearDown()
    }

    // MARK: - METHODS
    //
    func testSUT_whenInitCalled_withValidUseCase_dataFetchedSuccessfully() {
        // Given
        let sut = ReposViewModel(fetchReposUseCase: validUseCase)
        let exp = expectation(description: "testSUT_whenInitCalled_withValidUseCase_dataFetchedSuccessfully")
        var data: [ReposResponse] = []

        // When
        sut.$repos
            .dropFirst()
            .sink(receiveValue: { repos in
                data = repos
                exp.fulfill()
            })
            .store(in: &sut.cancellables)

        waitForExpectations(timeout: 1)
        
        // Then
        XCTAssertNotEqual(data.count, 0)
    }
    
    func testSUT_whenLoadDataCalledSuccessfully_andReposArrayNotEmpty_reposAppendedOnReposArray() {
        // Given
        let sut = ReposViewModel(fetchReposUseCase: validUseCase)
        let exp = expectation(description: "testSUT_whenLoadDataCalledSuccessfully_andReposArrayNotEmpty_reposAppendedOnReposArray")
        var data: [ReposResponse] = []
        
        // When
        sut.repos = MockData.repos()
        sut.$repos
            .dropFirst()
            .sink(receiveValue: { repos in
                data = repos
                exp.fulfill()
            })
            .store(in: &sut.cancellables)

        waitForExpectations(timeout: 1)
        
        // Then
        XCTAssertEqual(sut.repos.count, data.count)
    }
    
    func testSUT_whenLoadDataCalledSuccessfully_andReposArrayReachedMaxCount_stateShouldBeLoadedAll() {
        // Given
        let sut = ReposViewModel(fetchReposUseCase: validUseCase, maxCount: 10)
        let exp = expectation(description: "testSUT_whenLoadDataCalledSuccessfully_andReposArrayReachedMaxCount_stateShouldBeLoadedAll")
        var state: ViewModelState?
        
        // When
        sut.$repos
            .dropFirst()
            .sink(receiveValue: { _ in
                exp.fulfill()
            })
            .store(in: &sut.cancellables)

        waitForExpectations(timeout: 1)
        state = sut.state
        
        // Then
        XCTAssertEqual(state, .loadedAll)
    }
    
    func testSUT_whenLoadDataCalled_andStateIsNotIdle_dataShoulBeEmpty() {
        // Given
        let sut = ReposViewModel(fetchReposUseCase: validUseCase, state: .loading)
        
        // When
        sut.state = .loading
        sut.loadData()
        
        // Then
        XCTAssertEqual(sut.repos.count, 0)
    }
}
