//
//  MovieViewModel.swift
//  MovieCollection
//
//  Created by Emrah Yıldırım on 19.02.2022.
//

import Foundation
import SwiftUI // Ekledik çünkü ObservableObject için

// Burada DownloaderClient 'ımızı kullanarak çekilen verileri kendi değişkenlerimize atayacağız

class MovieListViewModel : ObservableObject { // ObservableObject publisher(yayın) özelliği ekler yani yayın yapabilir hale geliyoruz. Değişiklik olduğunda yayını alan herkes bu değişiklikleri takip edebilecek.
    
    @Published var movies = [MovieViewModel]()// @Published ile de değişkeni yayına sokuyoruz.
    let downloaderClient = DownloaderClient() // İndirme sınıfından bir nesne oluşturduk.
    
    func movieSearchDo(movieName:String) {
        downloaderClient.moviesDownload(search: movieName) { (sonuc) in
            switch sonuc {
            case .failure(let hata):
                print(hata)
            case .success(let filmDizisi): // filmDizisi opsiyonel değer alıyor
                if let filmDizisi = filmDizisi { // opsiyonelliği bozmak için if let kullandık
                    DispatchQueue.main.async { // senkronize yapılması için gerekli
                        self.movies = filmDizisi.map(MovieViewModel.init) // Böylelikle çekilen veriyi movies adlı değişkene atadık. // map ile de internetten inen verileri aşağıdaki modele dönüşümünü sağladık.
                    }
                }
            }
        }
    }
    
}


struct MovieViewModel { // Bu struct'ı yapmamızın nedeni çekilen veride istemediğimiz, kullanmayacağımız kısımlar olabilir. Örneğin çekilen modelde yani Movie Modelinde type kısmını kullanmayacağız bu yüzden kullanacağımız verilerin modelini tanımladık.
    
    let movie : Movie // Movie modelinden nesne oluşturduk
    
    var title : String {
        movie.title
    }
    var poster : String {
        movie.poster
    }
    var year : String {
        movie.year
    }
    var imdbId : String {
        movie.imdbId
    }
    
    // Daha sonrada bu yapıyı published değişeninin iççerisine böyle olacak bir dizi alacak şeklinde tanımladık.
    
}
