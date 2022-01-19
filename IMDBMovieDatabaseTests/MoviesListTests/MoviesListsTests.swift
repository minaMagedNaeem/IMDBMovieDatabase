//
//  IMDBMovieDatabaseTests.swift
//  IMDBMovieDatabaseTests
//
//  Created by Mina Maged on 1/14/22.
//

import XCTest
@testable import IMDBMovieDatabase

class MoviesListsTests: XCTestCase {
    
    var viewModel: MoviesListViewModel!

    override func setUpWithError() throws {
        self.viewModel = MoviesListViewModel(networkManager: MoviesTestsNetworkManager(), repo: TestMoviesListRepo())
    }

    override func tearDownWithError() throws {
        self.viewModel = nil
    }

    func testGetMovies() throws {
        self.viewModel.getMoviesLists()
        
        XCTAssert(self.viewModel.moviesCount != 0, "Could not decode json")
    }
    
    func testMovieDecoding() throws {
        self.viewModel.getMoviesLists()
        
        let firstMovie = self.viewModel.movie(for: 0)
        
        XCTAssert(firstMovie.id == 524434, "Could not decode json")
        XCTAssert(firstMovie.originalTitle == "Eternals", "Could not decode json")
        XCTAssert(firstMovie.popularity == 11856.588, "Could not decode json")
        XCTAssert(firstMovie.voteAverage == 7.2, "Could not decode json")
    }
    
    func testFavourites() throws {
        self.viewModel.getMoviesLists()
        self.viewModel.movie(for: 0).favourite = true
        self.viewModel.movie(for: 1).favourite = true
        self.viewModel.movie(for: 2).favourite = true
        self.viewModel.toggleFavourites()
        
        XCTAssert(self.viewModel.moviesCount == 3, "Error in favourites")
        
        self.viewModel.toggleFavourites()
        self.viewModel.movie(for: 2).favourite = false
        self.viewModel.toggleFavourites()
        
        XCTAssert(self.viewModel.moviesCount == 2, "Error in favourites")
        
        self.viewModel.toggleFavourites()
        self.viewModel.movie(for: 0).favourite = false
        self.viewModel.movie(for: 1).favourite = false
        self.viewModel.toggleFavourites()
        
        XCTAssert(self.viewModel.moviesCount == 0, "Error in favourites")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
