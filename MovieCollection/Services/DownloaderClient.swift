//
//  DownloaderClient.swift
//  MovieCollection
//
//  Created by Emrah Yıldırım on 18.02.2022.
//

import Foundation

// Verileri çekip indirme işlemi için bir sınıf foluşturduk.
class DownloaderClient {
    
    // Şimdi bir fonksiyon oluşturacağız daha sonra sınıfın içerisinden bu foksiyonu çağırıp verileri indirebilmek için
    
    // Fonksiyon search adındaki parametreyi alıyor, completion ile ne verisi döneceğini(Movie dizisi) ve hata olursa ne döneceğini belirttik.
    func moviesDownload(search: String, completion: @escaping (Result<[Movie]?,DownloaderError>) -> Void) {
        
        // url 'yi tanımladık, gelmezse hatasını yazdık.
        guard let url = URL(string: "https://www.omdbapi.com/?s=\(search)&apikey=9cefb3b1") else {
            return completion(.failure(.yanlisUrl))
        }
        
        // URLSession içerisinde veriyi çektik ve işledik
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            //veri çekildi
            guard let data = data, error == nil else {
                return completion(.failure(.veriGelmedi))
            }
            
            // answerData değişkeni oluşturup InComingMovies yapısından dönen cevabı bu değişkene işledik.
            guard let answerData = try? JSONDecoder().decode(InComingMovies.self, from: data) else {
                return completion(.failure(.veriIslenemedi))
            }
            
            completion(.success(answerData.movies)) // Her şey doğru olursa InComingMovies yapsısı içerisindeki movies değişkenini almış olduk
            
        }.resume() // Bu URLSession için gerekli
        
    }
    
    
    // DetailsMovie'yi yazdıktan sonra ekledim, detayları indirmesi için ayrıca bir indirme fonksiyonu yazdık yukarıdakine çok benzeyen aynı,
    func movieDetailsDownload(imdbId : String, completion: @escaping (Result<DetailsMovie,DownloaderError>) -> Void) {
            
            guard let url = URL(string: "https://www.omdbapi.com/?i=\(imdbId)&apikey=9cefb3b1") else {
                return completion(.failure(.yanlisUrl))
            }
            
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard let data = data, error == nil else {
                    return completion(.failure(.veriGelmedi))
                }
                
                guard let gelenFilmDetayi = try? JSONDecoder().decode(DetailsMovie.self, from: data) else {
                    return completion(.failure(.veriIslenemedi))
                }
                
                completion(.success(gelenFilmDetayi))
                
            }.resume()
        }
    
    
    
}

// Hata tipleri
enum DownloaderError: Error {
    case yanlisUrl
    case veriGelmedi
    case veriIslenemedi
}


// Not: url'yi tanımladığımız yerde bazen http olabiliyor, böyle bir durumda infoplist den bunu ayarlamamız http'ye izin vermemiz gerekiyor.
