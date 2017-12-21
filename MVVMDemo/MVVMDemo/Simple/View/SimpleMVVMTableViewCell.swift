//
//  SimpleMVVMTableViewCell.swift
//  MVVMDemo
//
//  Created by Geselle-Joy on 2017/12/20.
//  Copyright © 2017年 zhengtou. All rights reserved.
//

import UIKit

class SimpleMVVMTableViewCell: UITableViewCell {

    @IBOutlet weak var gankTitle: UILabel!
    @IBOutlet weak var gankAuthor: UILabel!
    @IBOutlet weak var gankTime: UILabel!
    
    static let height: CGFloat = UITableViewAutomaticDimension
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
