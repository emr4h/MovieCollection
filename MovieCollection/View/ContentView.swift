//

// 1-Movie, 2-DownloaderClient, 3-Movie(List)ViewModel, 4-ImageDownloader, 5-ImageListView,6-DetailsMovie,7-DownloaderClient(2),8-MovieDetailsViewModel,


//  ContentView.swift
//  MovieCollection
//
//  Created by Emrah Yıldırım on 18.02.2022.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var movieListViewModel : MovieListViewModel //ObservableObject ile yayına aldığımız sınıfın yayınına ulaşabilmek için ObservedObject 'i ekledik.
    
    @State var aranacakFilm = "" //SearchBar için değişken
    init() { // dosyaya init ettik hatalar gitsin diye
        self.movieListViewModel = MovieListViewModel()
    }
    
    var body: some View {
        // Published movies değişkenini listeye yazdırdık, imdb id'sine göre,
        NavigationView {
            VStack {
                //onEditingChange textfield'a yazılırken ne değişeceğini söylüyor, hiç bir şey yapma dedik ona. OnEdit de yazıp enterladığında ne yapacağını söylüyor, arama işlemini burada yaptık.
                HStack{
                    Image(systemName: "magnifyingglass")
                        .padding()
                    TextField("Search Movie...", text: $aranacakFilm, onEditingChanged: { _ in}, onCommit: {
                        self.movieListViewModel.movieSearchDo(movieName: aranacakFilm.trimmingCharacters(in: .whitespacesAndNewlines).addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? aranacakFilm)
                        //.trimmingCharacters sonrası boşluk ve yeni satır girerse kullanıcı bunları url karakterine çevirmesi için yapıldı.
                    })
                        .textFieldStyle(DefaultTextFieldStyle())
                        
                }
               
                
                List(movieListViewModel.movies, id: \.imdbId ) { film in
                    NavigationLink(destination: {
                        DetailView(imdbId: film.imdbId)
                    }, label: {
                        HStack {
                            ImageListView(url: film.poster)
                                .frame(width: 100, height: 140, alignment: .leading)
                                .aspectRatio(contentMode: .fit)
                                .cornerRadius(60.0)
                                .shadow(color: .gray, radius: 20)
                            VStack(alignment: .leading) {
                                Text(film.title)
                                    .font(.title2)
                                    .foregroundColor(Color.orange)
                                    
                                Text(film.year)
                                    .bold()
                            }.padding()
                        }
                    })
                    
                }.navigationTitle(Text("Movie Collection"))
       
            }
        
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
