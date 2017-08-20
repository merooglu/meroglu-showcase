//
//  PostCell.swift
//  meroglu-showcase
//
//  Created by Mehmet Eroğlu on 12.08.2017.
//  Copyright © 2017 Mehmet Eroğlu. All rights reserved.
//

import UIKit
import Alamofire

class PostCell: UITableViewCell {

    @IBOutlet weak var profileImg : UIImageView!
    @IBOutlet weak var showcaseImg: UIImageView!
    @IBOutlet weak var descriptionText : UITextView!
    @IBOutlet weak var likesLbl: UILabel!
    
    var post : Post!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func draw(_ rect: CGRect) {
        profileImg.layer.cornerRadius = profileImg.frame.width / 2
        profileImg.clipsToBounds = true
        
        showcaseImg.clipsToBounds = true
    }

    func configureCell(post: Post) {
        self.post = post
        
        self.descriptionText.text = post.postDescription
        self.likesLbl.text = "\(post.likes)"
        
    }

}
