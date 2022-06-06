//
//  DataParser.swift
//  PostsNew
//
//  Created by Анна Тибекина on 17.03.2022.
//

import Foundation

class DataParser {
    
    func parsePosts(from url: URL) -> [Post]? {
        
        let data = try? Data(contentsOf: url)
        if data == nil {
            return nil
        }
        
        let rootDictionaryAny = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments)
        if rootDictionaryAny == nil {
            return nil
        }
        
        let rootDictionary = rootDictionaryAny as? Dictionary<String,Any>
        if rootDictionary == nil {
            return nil
        }
        
        if let array = rootDictionary!["posts"] as? [Dictionary<String,Any>] {
            var returnArray: [Post] = []
           
            
            for dict in array {
                let newArticle = Post(dictionary: dict)
                returnArray.append(newArticle)
            }
            
            return returnArray
        }
        
        return nil
    }



func postPars(from url: URL) -> Post? {
       
        let data = try? Data(contentsOf: url)
        if data == nil {
            return nil
        }
        
        let rootDictionaryAny = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments)
        if rootDictionaryAny == nil {
            return nil
        }
        
        let rootDictionary = rootDictionaryAny as? Dictionary<String,Any>
        if rootDictionary == nil {
            return nil
        }
    print("aaaaaaaa", url, "aaaaaaaa")
        
    
        //let newArticle = Post(rootDictionary)
  
      
            
        
        return nil
}
}


