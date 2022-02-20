//
//  ImageListView.swift
//  MovieCollection
//
//  Created by Emrah Yıldırım on 20.02.2022.
//

import SwiftUI

struct ImageListView: View {
    
    let url : String //url değeri almasını isteyerek ContentView'da bu görsel isteme çağrıldığında orada isyetecek.
    @ObservedObject var imageDownloaderClient = ImageDownloaderClient() //görsel indirme sınıfından nesne oluşturduk. Observed ile de published değere ulaşmak için kullandık.
    
    init(url: String) { // yukarıda bu view çağrıldığında istenecek url ile görselIndir 'i bağladık ve burada init ettik.
        self.url = url
        self.imageDownloaderClient.gorselIndir(url: url)
        
    }
    
    var body: some View {
        
        if let data = self.imageDownloaderClient.indirilenGorsel { //indirilen görsel görselIndirme dosyasındaki Published ile yayına açtığımız görsel datası
            return Image(uiImage: UIImage(data: data)!) //veri gelen image böyle gösterilir.
                .resizable()
            
        } else {
            // Veri gelmezse bu görseli gösterecek hepsinde.
            return Image("https://m.media-amazon.com/images/M/MV5BNjM0NTc0NzItM2FlYS00YzEwLWE0YmUtNTA2ZWIzODc2OTgxXkEyXkFqcGdeQXVyNTgwNzIyNzg@._V1_SX300.jpg")
                .resizable()
        }
    }
}

struct ImageListView_Previews: PreviewProvider {
    static var previews: some View {
        ImageListView(url: "https://m.media-amazon.com/images/M/MV5BNjM0NTc0NzItM2FlYS00YzEwLWE0YmUtNTA2ZWIzODc2OTgxXkEyXkFqcGdeQXVyNTgwNzIyNzg@._V1_SX300.jpg")
    }
}
