//
//  MovieViewModel.swift
//  MovieList
//
//  Created by Luciano Puzer on 11/01/22.
//

import SwiftUI

class MovieViewModel: ObservableObject {
    
    func fetchData() {
        let url = URL(string: "https://api.themoviedb.org/3//discover/movie?certification_country=US&certification.lte=G&sort_by=popularity.desc")
    }
}
