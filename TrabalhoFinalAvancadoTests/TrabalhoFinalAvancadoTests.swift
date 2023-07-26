//
//  TrabalhoFinalAvancadoTests.swift
//  TrabalhoFinalAvancadoTests
//
//  Created by Lucas Luis Ribeiro on 29/06/23.
//

import XCTest
@testable import TrabalhoFinalAvancado

final class TrabalhoFinalAvancadoTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCallFecthMovie() throws {
        let model = MoviesModelMock()
        let service = MoviesServiceMock()
       
        let viewModel = MoviesViewModel(movies: model, service: service)
       
        viewModel.getMovies()
       
        XCTAssert(service.didCalledGetMoviesTimes == 1)
    }


}
