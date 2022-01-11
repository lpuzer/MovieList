//
//  ContentView.swift
//  MovieList
//
//  Created by Luciano Puzer on 11/01/22.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var movieViewModel = MovieViewModel()
    var body: some View {
        Text("Hello, world!")
            .padding()
            .onAppear {
                movieViewModel.fetchData()
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
