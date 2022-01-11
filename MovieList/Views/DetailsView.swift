//
//  DetailsView.swift
//  MovieList
//
//  Created by Luciano Puzer on 11/01/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct DetailsView: View {
    var movie: Movie
    @ObservedObject var movieViewModel = MovieViewModel()
    
    var body: some View {
        ZStack (alignment: .bottom) {
            VStack{
                WebImage(url: URL(string: "https://image.tmdb.org/t/p/w500/\(movie.poster_path)"))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                Spacer()
            }
            VStack(spacing: 5) {
                HStack (alignment: .center, spacing: 10){
                    Text(movie.title)
                        .font(.largeTitle)
                    
                    RatingView(rating: movie.vote_average)
                    Spacer()
                }
                
                Text(movie.overview ?? "")
                    .foregroundColor(.gray)
                
                
            }.padding()
                .background(Color.white)
                .cornerRadius(20)
        }
        .ignoresSafeArea(.all, edges: .top)
        .onAppear {
            movieViewModel.fetchMovie(movie: movie)
        }
    }
}


struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView(movie: Movie(id: 831827, title: "Far From the Tree", overview: "On an idyllic beach in the Pacific Northwest, curiosity gets the better of a young raccoon whose frustrated parent attempts to keep them both safe.", poster_path: "/39oaQUS0KxyXL6KYJ2o2u03PpHz.jpg", vote_average: 8.1), movieViewModel: MovieViewModel())
    }
}
