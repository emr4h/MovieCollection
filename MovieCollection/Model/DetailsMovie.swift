//
//  DetailsMovie.swift
//  MovieCollection
//
//  Created by Emrah Yıldırım on 20.02.2022.
//

import Foundation

//Not: Bir filmin detaylarını göstericeğimiz yapı, önceden url'de s="harry" gibi gidiyordu. Buradaki api sorgusu ise i="imdbID" şeklinde yapılıp aşağıdaki gibi bir film detayları gösterilir.

// Burada bir film detaylarının gösterileceği modeli oluşturduk.

struct DetailsMovie : Codable {
    
    let title : String
    let year : String
    let genre : String
    let director : String
    let writer : String
    let actors : String
    let plot : String
    let awards : String
    let poster : String
    let metascore : String
    let imdbRating : String
    let imdbId : String
    
    private enum CodingKeys : String, CodingKey {
        case title = "Title"
        case year = "Year"
        case genre = "Genre"
        case director = "Director"
        case writer = "Writer"
        case actors = "Actors"
        case plot = "Plot"
        case awards = "Awards"
        case poster = "Poster"
        case metascore = "Metascore"
        case imdbRating = "imdbRating"
        case imdbId = "imdbID"
    }
    
}
