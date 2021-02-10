//
//  NewsViewModel.swift
//  NewsUI
//
//  Created by Muhammad Azzam Al Bana on 08/02/21.
//

import Foundation
import Combine
import SwiftyJSON

class NewsViewModel: ObservableObject {
    @Published var data = [News]()
    
    init() {
        let url = "http://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=7e94e23127894d279342050d6d74fefc"
        
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: URL(string: url)!){(data, _, error)in
            if error != nil{
                print((error?.localizedDescription)!)
                return
            }
            
            let json = try! JSON(data: data!)
            let items = json["articles"].array!
            
            for i in items{
                let title = i ["title"].stringValue
                let description = i ["description"].stringValue
                let  image = i ["image"].stringValue
                
                DispatchQueue.main.sync {
                    self.data.append(News(title: title, image: image, description: description))
                }
                
            }
            
            
        }.resume()
        
        
    }
}

