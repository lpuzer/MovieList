//
//  MovieViewModel.swift
//  MovieList
//
//  Created by Luciano Puzer on 11/01/22.
//

import SwiftUI

class MovieViewModel: ObservableObject {
    
    func fetchData() {
        let url = URL(string: "https://api.themoviedb.org/3/discover/movie?certification_country=US&certification.lte=G&sort_by=popularity.desc&api_key=6a9d5a41bc3069e8dc889efa40fcddfb")
        
        URLSession.shared.dataTask(with: url!) { data, response, error in
            if let error = error {
                print(error)
                return
            }
            
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    print(json)
                } catch (let error) {
                print(error)
                return
            }
        } else {
            print("error")
            return
        }
        
        }.resume()    }
}
