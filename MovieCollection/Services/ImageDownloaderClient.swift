//
//  ImageDownloaderClient.swift
//  MovieCollection
//
//  Created by Emrah Yıldırım on 20.02.2022.
//


import Foundation
import SwiftUI

// Görseller veride url şeklinde çekiliyor http:/amazon/aghgfd.png gibi, biz de bu görselleri indiren sınıfı aşağıdaki gibi yazdık

class ImageDownloaderClient : ObservableObject { // Observable yaptık çünü bu indirme sınıfından gelecek olan Published değişkeni yayına açmamız gerekir, heryerden ulaşabilmek için.
    
    @Published var indirilenGorsel : Data?
    
    // Görsel indirme fonksiyonu
    func gorselIndir(url: String) {
        guard let imageUrl = URL(string: url) else {
            return
        }
        
        URLSession.shared.dataTask(with: imageUrl) { data, response, error in
            guard let data = data, error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                self.indirilenGorsel = data
            }

        }.resume()
    }
    
    
}
