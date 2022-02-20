//
//  Movie.swift
//  MovieCollection
//
//  Created by Emrah Yıldırım on 18.02.2022.
//
// Search araması yaptığımız zamanın modelini oluşturduk. Bunlar bir liste içerisinde aramanın sonucunu aşağıdaki gibi bir json şeklinde dönderiyor :

/*
 
 "Search":[
 {
    "Title":"Harry Potter and the Deathly Hallows: Part 2",
    "Year":"2011",
    "imdbID":"tt1201607",
    "Type":"movie",
    "Poster":"http:posterlinki.com/poster.png"
 },
 {
    "Title":"Harry Potter and the Sorcerer's Stone",
    "Year":"2001",
    ...
 
 */

import Foundation

// Codable gelen veriyi işleyip değişkenlere atamamıza olanak sağlıyor. Encodeable ve Decodeable diye ikiye ayrılıyor.

struct Movie : Codable {
    
    // Bunlar api den gelen değerler
    let title : String
    let year : String
    let imdbId : String
    let type : String
    let poster : String
    
    // Aşağıdaki fonksiyon ile api'den gelen değerlerin isimlerini vererek bizim oluşturduğumuz değişkenlere eşleştirdik. Böylelikle xcode api'den gelenleri bunlara atayacak.
    // Bunu yaptık çünkü değişkenler küçük harfle tanımlamak istedik ama api de büyük harfle tanımlıydılar, uyum sağlamak için bu yolu kullandık.
    private enum CodingKeys : String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbId = "imdbID"
        case type = "Type"
        case poster = "Poster"
    }

}

// En baştaki örnek veriye bakarsak bu alıcağımız veri bir liste halinde gelecek, örneğin harry diye search araması yapıldığında liste halinde verecek.
// Yani bu verileri Movie şeklinde almamız yetmiyor, listeyi alabilmek için veride belirtilen Search anahtar kelimesinide vermemiz gerekiyor.
struct InComingMovies : Codable {
    // yani search'ü gördüğünde sana Movie dizisi gelecek, al bunu movies içine ata dedik.
    let movies : [Movie]
    private enum CodingKeys : String, CodingKey {
        case movies = "Search"
    }
}

// Not : Json4Swift


