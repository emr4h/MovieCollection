//
//  DetailView.swift
//  MovieCollection
//
//  Created by Emrah Yıldırım on 20.02.2022.
//

import SwiftUI

struct DetailView: View {
    
    let imdbId : String // Bunu tanımlayarak DetailView'ı her çağırdığımızda bizden bir imdbId sormasını sağladık. Böylelikle ContentView içerisinde NavigationLink destination kısmına ekleyebiliriz.
    
    @ObservedObject var movieDetailsViewModel = FilmDetayViewModel()
    
    var body: some View {
        ScrollView {
        VStack(alignment: .leading, spacing: 5){
            
            Text(movieDetailsViewModel.filmDetayi?.title ?? "Film Ismi Gösterilecek").bold().font(.title).foregroundColor(.blue).padding().frame(width: UIScreen.main.bounds.width*1, height: 100)
            
            HStack{
                Spacer()
                ImageListView(url: movieDetailsViewModel.filmDetayi?.poster ?? "")
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(60.0)
                    .shadow(color: .gray, radius: 20)
                    .frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.4, alignment: .center)
                Spacer()
                }
            
            Text("About Movies: \(movieDetailsViewModel.filmDetayi?.plot ?? "")").padding()
            
            Text("Director: \(movieDetailsViewModel.filmDetayi?.director ?? "")").padding()
            
            Text("Writer: \(movieDetailsViewModel.filmDetayi?.writer ?? "")").padding()
            
            Text("Awards: \(movieDetailsViewModel.filmDetayi?.awards ?? "")").padding()
            
            Text("Year: \(movieDetailsViewModel.filmDetayi?.year ?? "")").padding()
            Text("imdbRating: \(movieDetailsViewModel.filmDetayi?.imdbRating ?? "")").padding().font(.largeTitle)
            
            
            Spacer()
        }.onAppear(perform: {
            self.movieDetailsViewModel.filmDetayiAl(imdbId: imdbId)
        })
    }
    }
    
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(imdbId: "tt3896198")
    }
}
