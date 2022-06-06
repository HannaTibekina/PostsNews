//
//  OnePostsViewController.swift
//  PostsNew
//
//  Created by Анна Тибекина on 17.03.2022.
//

import UIKit
import CoreData

class OnePostsViewController: UIViewController {
    
    var post: Post?
    

    @IBOutlet weak var labelTitle: UILabel!
    
    @IBOutlet weak var labelPreview: UILabel!
    
  
    
    
    
    override func viewDidLoad() {
            super.viewDidLoad()

       
        
        
        numberOfLinesTitle ()
        numberOfLinesPreview ()
        
        labelTitle.text = post?.title
        labelPreview.text = post?.preview_text
        //labelLikes.text = post?.likes_count
        //labelTime.text = post?.timeshamp
        
        func numberOfLinesTitle () {
            
       labelTitle.numberOfLines = 4
       labelTitle.text = post?.title
       labelTitle.sizeToFit()
     }
        func numberOfLinesPreview () {
            
            labelPreview.numberOfLines = 0
            labelPreview.text = post?.preview_text
            labelPreview.sizeToFit()
     }
        
        
        
        
       // numberOfLinesTitle ()
    
    
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
