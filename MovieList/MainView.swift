//
//  ContentView.swift
//  MovieList
//
//  Created by Luciano Puzer on 11/01/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct MainView: View {
    @ObservedObject var movieViewModel = MovieViewModel()
    var body: some View {
        NavigationView {
            ZStack{
                if let movies = movieViewModel.movies{
                    List{
                        ForEach(movies) { movie in
                            HStack (spacing: 15) {
                                
                                WebImage(url: URL(string: "https://image.tmdb.org/t/p/w500/\(movie.poster_path)"))
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 120)
                                    .cornerRadius(10)
                                
                                VStack (alignment: .leading, spacing: 5){
                                    Text(movie.title)
                                        .font(.title2)
                                        .fontWeight(.semibold)
                                    Text(movie.overview ?? "")
                                        .lineLimit(4)
                                        .foregroundColor(.gray)
                                    
                                    Spacer()
                                    
                                    HStack{
                                        Image(systemName: "star.fill")
                                            .resizable()
                                            .frame(width: 12, height: 12)
                                            .foregroundColor(.orange)
  
                                        Text(String(format: "%.1f", movie.vote_average))
                                            .fontWeight(.medium)
                                    }
                                }.padding(.vertical)
                            }
                        }
                    }
                    .listStyle(PlainListStyle())
                }else{
                    Text("Feching data...")
                }
            }
            .navigationTitle("Popular Kids Movies")
        }
        .onAppear {
                movieViewModel.fetchData()
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(movieViewModel: MovieViewModel())
    }
}
