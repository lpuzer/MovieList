//
//  MovieViewModel.swift
//  MovieList
//
//  Created by Luciano Puzer on 11/01/22.
//

import SwiftUI
import Combine

class MovieViewModel: ObservableObject {
    @Published var movies = [Movie]()
    @Published var movie: Movie?
    @Published var similarLists = [SimilarMovie]()
    @Published var similarList: SimilarMovie?
    
    
    func fetchData() {
        let url = URL(string: "https://api.themoviedb.org/3/discover/movie?certification_country=US&certification.lte=G&sort_by=popularity.desc&api_key=6a9d5a41bc3069e8dc889efa40fcddfb")
        
        URLSession.shared.dataTask(with: url!) { data, response, error in
            if let error = error {
                print(error)
                return
            }
            if let data = data {
                do {
                    let arrayOfMovies = try JSONDecoder().decode(ListOfMovies.self, from: data)
                    DispatchQueue.main.async {
                        self.movies = arrayOfMovies.results
                    }
                } catch (let error) {
                    print(error)
                    return
                }
            } else {
                print("error")
                return
            }
            
        }.resume()
    }
    
    
    func fetchSimilarData(movieId: Int) {
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(movieId)/similar?api_key=6a9d5a41bc3069e8dc889efa40fcddfb")
        
        URLSession.shared.dataTask(with: url!) { data, response, error in
            if let error = error {
                print(error)
                return
            }
            
            if let data = data {
                do {
                    let arrayOfSimilarMovies = try JSONDecoder().decode(SimilarMovies.self, from: data)
                    DispatchQueue.main.async {
                        self.similarLists = arrayOfSimilarMovies.results
                    }
                } catch (let error) {
                    print(error)
                    return
                }
            } else {
                print("error")
                return
            }
            
        }.resume()
    }
    
    
    
    func fetchMovie(movie: Movie) {
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(movie.id)?api_key=6a9d5a41bc3069e8dc889efa40fcddfb")
        URLSession.shared.dataTask(with: url!) { data, response, error in
            if let error = error {
                print(error)
                return
            }
            
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    print(json)
                    let movie = try JSONDecoder().decode(Movie.self, from: data)
                    DispatchQueue.main.async {
                        self.movie = movie
                    }
                } catch (let error) {
                    print(error)
                    return
                }
            } else {
                print("error")
                return
            }
            
        }.resume()
    }
    
    
    
    func fetchSimilarMovie(similarList: SimilarMovie) {
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(similarList.id)?api_key=6a9d5a41bc3069e8dc889efa40fcddfb")
        
        URLSession.shared.dataTask(with: url!) { data, response, error in
            if let error = error {
                print(error)
                return
            }
            
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    print(json)
                    let similarMovie = try JSONDecoder().decode(SimilarMovie.self, from: data)
                    DispatchQueue.main.async {
                        self.similarList = similarMovie
                    }
                } catch (let error) {
                    print(error)
                    return
                }
            } else {
                print("error")
                return
            }
            
        }.resume()
    }
    
    
    
}

