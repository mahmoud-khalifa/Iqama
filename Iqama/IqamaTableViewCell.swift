//
//  IqamaTableViewCell.swift
//  Iqama
//
//  Created by Mahmoud Adam on 11/6/16.
//  Copyright © 2016 lognlabs. All rights reserved.
//

import UIKit
import MaterialControls
import SnapKit

class IqamaTableViewCell: MDTableViewCell {

    let arabicLabel = UILabel()
    let englishLabel = UILabel()
    let timeLabel = UILabel()
   
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configureView()
        self.setupConstraints()
    }
    
    func updateView(pray: Pray) {
        self.arabicLabel.text = pray.getArabicName()
        self.englishLabel.text = pray.getEnglishName()
        self.timeLabel.text = pray.getFormatedPrayTime()
        
    }
    
    private func configureView() {
        
        arabicLabel.textAlignment = .Right
        contentView.addSubview(arabicLabel)
        
        englishLabel.textAlignment = .Left
        contentView.addSubview(englishLabel)
        
        timeLabel.textAlignment = .Center
        contentView.addSubview(timeLabel)
    }
    private func setupConstraints() {
        arabicLabel.snp_makeConstraints { (make) in
            make.right.equalTo(contentView).offset(-20)
            make.centerY.equalTo(contentView)
            make.height.equalTo(21)
            make.width.equalTo(150)
        }
        
        englishLabel.snp_makeConstraints { (make) in
            make.left.equalTo(contentView).offset(20)
            make.centerY.equalTo(contentView)
            make.height.equalTo(21)
            make.width.equalTo(150)
        }
        
        timeLabel.snp_makeConstraints { (make) in
            make.centerX.centerY.equalTo(contentView)
            make.height.equalTo(21)
            make.width.equalTo(150)
        }
        
    }
}
