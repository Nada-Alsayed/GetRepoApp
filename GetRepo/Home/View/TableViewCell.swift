//
//  TableViewCell.swift
//  GetRepo
//
//  Created by MAC on 19/10/2023.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var ownerName: UILabel!
    @IBOutlet weak var repoName: UILabel!
    @IBOutlet weak var creationDate: UILabel!
    @IBOutlet weak var ownerAvatar: UIImageView!
    @IBOutlet weak var view: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        ownerAvatar.layer.cornerRadius = 15
        view.layer.cornerRadius = 15
        view.layer.masksToBounds = true
    }
    
    override var frame: CGRect{
        get{
            return super.frame
        }
        set(newFrame){
            var frame = newFrame
            frame.origin.x += 8
            frame.size.width -= 2 * 8
            frame.origin.y += 8
            frame.size.height -= 2 * 8
            super.frame = frame
        }
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
