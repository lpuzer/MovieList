//
//  MovieModel.swift
//  MovieList
//
//  Created by Luciano Puzer on 11/01/22.
//

import SwiftUI

struct ListOfMovies: Decodable {
    let results: [Movie]
}

struct SimilarMovies: Decodable {
    let results: [SimilarMovie]
}

struct Movie: Identifiable, Decodable {
    let id: Int
    let title: String
    let overview: String?
    let poster_path: String
    let vote_average: Float
    var vote_count: Int
    var popularity: Float
}


struct SimilarMovie: Identifiable, Decodable {
    let id: Int
    let title: String
    let overview: String?
    let poster_path: String
    let vote_average: Float
    var vote_count: Int
    var popularity: Float
}

