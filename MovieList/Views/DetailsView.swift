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
    var similarMovie: SimilarMovie?
    @ObservedObject var movieViewModel = MovieViewModel()
    @State var changeLike:Bool = false
    @State var vote: Int = 0
    
    var body: some View {
        ScrollView {
            ZStack (alignment: .bottom) {
                VStack{
                    WebImage(url: URL(string: "https://image.tmdb.org/t/p/w500/\(movie.poster_path)"))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    
                    Spacer()
                    VStack(spacing: 5) {
                        HStack (alignment: .center, spacing: 10){
                            Text(movie.title)
                                .font(.largeTitle)
                            RatingView(rating: movie.vote_average)
                            Spacer()
                        }
                        Text(movie.overview ?? "")
                            .foregroundColor(.gray)
                            .padding(.bottom, 10)
                        HStack{
                            Spacer()
                            Text("Popularity:")
                            Text(String(format: "%.3f", movie.popularity))
                                .foregroundColor(Color.gray)
                            Spacer()
                            Text(self.changeLike ? "\(vote)" : "\(movie.vote_count)")
                            Image(systemName: self.changeLike ? "heart.fill" : "heart")
                                .foregroundColor(.red)
                                .onTapGesture {
                                    self.changeLike.toggle()
                                    self.vote = movie.vote_count + 1
                                }
                            Spacer()
                        }
                        
                    }.padding()
                        .background(Color.white)
                        .cornerRadius(20)
                }
            }
            VStack (alignment: .leading, spacing: 10) {
                Text("Similar Movies")
                    .font(.title)
                    .fontWeight(.medium)
                
                if let movies = movieViewModel.similarLists{
                    ForEach(movies) { movie in
                        
                        VStack {
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
                            
                        } .onAppear {
                            movieViewModel.fetchSimilarMovie(similarList: movie)
                        }
                    }
                }else{
                    LoadingData()
                }
            }
            .padding()
        }.onAppear {
            movieViewModel.fetchSimilarData(movieId: movie.id)
        }
        .ignoresSafeArea(.all, edges: .top)
    }
}


struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView(movie: Movie(id: 831827, title: "Far From the Tree", overview: "On an idyllic beach in the Pacific Northwest, curiosity gets the better of a young raccoon whose frustrated parent attempts to keep them both safe.", poster_path: "/39oaQUS0KxyXL6KYJ2o2u03PpHz.jpg", vote_average: 8.1, vote_count: 98, popularity: 846.782), similarMovie: SimilarMovie(id: 831827, title: "Far From the Tree", overview: "On an idyllic beach in the Pacific Northwest, curiosity gets the better of a young raccoon whose frustrated parent attempts to keep them both safe.", poster_path: "/39oaQUS0KxyXL6KYJ2o2u03PpHz.jpg", vote_average: 8.1, vote_count: 98, popularity: 846.782), movieViewModel: MovieViewModel())
    }
}
