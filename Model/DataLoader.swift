//
//  DataLoader.swift
//  PostsNew
//
//  Created by Анна Тибекина on 17.03.2022.
//

import Foundation

class DataLoader {
    
    var dataURL: URL {
        let path = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true)[0]+"/data.json"
        let urlPath = URL(fileURLWithPath: path)
        
        return urlPath
    }
    
    func loadPosts(complitionHandler:((_ model: DataModel) -> Void)?) {
        let url = URL(string: "https://raw.githubusercontent.com/aShaforostov/jsons/master/api/main.json")
        let session = URLSession(configuration: .default)
        let downloadTask = session.downloadTask(with: url!) { (urlFile, responce, error) in
            if urlFile != nil {
                try? FileManager.default.copyItem(at: urlFile!, to: self.dataURL)
                let model = DataModel()
                model.posts = DataParser().parsePosts(from: self.dataURL) ?? []
                complitionHandler?(model)
            }
        }
        
        downloadTask.resume()
    }
    
    func loadPostById(id: Int) {
        let stringURL = "https://raw.githubusercontent.com/aShaforostov/jsons/master/api/posts/\(id).json"
        let url = URL(string: stringURL)
        print(stringURL, id)
        let session = URLSession(configuration: .default)
        let downloadTask = session.downloadTask(with: url!) { (urlFile, responce, error) in
            if urlFile != nil {
                /*              try? FileManager.default.copyItem(at: urlFile!, to: url)
                
                
                let model = DataModel()
                model.post = DataParser().postPars(from: url)
            
            }
        }
        
        downloadTask.resume()
    }*/
}
        }
    }
}
