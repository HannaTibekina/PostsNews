//
//  Post.swift
//  PostsNew
//
//  Created by Анна Тибекина on 17.03.2022.
//

import Foundation

/*    "posts": [
 {
     "postId": 111,
     "timeshamp": 1569914716,
     "title": "Спор с таксистом бесполезен",
     "preview_text": "Друг рассказал историю, далее с его слов.Как-то, во времена, когда я был студентом, пришлось добираться поздно вечером с малознакомого района домой. Транспорт почти не ходил, в кармане последние триста рублей, а ехать далеко. Триста рублей деньги совсем не большие и на такси не хватало, поэтому решил поймать бомбилу. ",
     "likes_count": 19738
 },
 
 */

struct Post {
    var postId: Int
    var timeshamp: Double?
    var title: String
    var preview_text: String
    var likes_count: Int
    var date: Date?
    
    init(dictionary: Dictionary<String, Any>) {
         postId = dictionary["postId"] as? Int ?? 0 
         timeshamp = dictionary["timeshamp"] as? Double
         title = dictionary["title"] as? String ?? ""
         preview_text = dictionary["preview_text"] as? String ?? ""
         likes_count = dictionary["likes_count"] as? Int ?? 0
        
        if let timeInterval = timeshamp {
            date = dateFromTimeshamp(timeInterval)
         
        }
    }
    
    func formattedDateString() -> String? {
        guard let date = date else {
            return nil
        }

        let dayTimePeriodFormatter = DateFormatter()
        dayTimePeriodFormatter.dateFormat = "MMM dd YYYY hh: mm a"
    

        let dateString = dayTimePeriodFormatter.string(from: date)
        
        return dateString
    }
    
    func dateFromTimeshamp(_ timeshamp: TimeInterval) -> Date? {
        let date = Date (timeIntervalSince1970: timeshamp)
        return date
    }
}
