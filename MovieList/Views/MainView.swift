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
                    MovieMainList(movies: movies)
                }else{
                    LoadingData()
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(content: {
                 ToolbarItem(placement: .principal, content: {
                 Text("Popular Kids Movies")
              })})
            

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

struct LoadingData: View {
    var body: some View {
        Text("Feching data...")
    }
}

struct MovieMainList: View {
    @ObservedObject var movieViewModel = MovieViewModel()
    var movies: [Movie]
    var body: some View {
        VStack {
            List{
                ForEach(movies) { movie in
                    NavigationLink {
                        DetailsView(movie: movie)
                    } label: {
                        MoviesCell(movie: movie)
                            .onAppear {
                                movieViewModel.fetchMovie(movie: movie)
                            }
                    }   
                }
            }
            .listStyle(PlainListStyle())
        }
    }
}

struct MoviesCell: View {
    var movie: Movie
    var body: some View {
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
                
                RatingView(rating: movie.vote_average)
            }.padding(.vertical)
        }
    }
}

struct RatingView: View {
    var rating: Float
    var body: some View {
        HStack{
            Image(systemName: "star.fill")
                .resizable()
                .frame(width: 12, height: 12)
                .foregroundColor(.orange)
            
            Text(String(format: "%.1f", rating))                .fontWeight(.medium)
        }
    }
}
