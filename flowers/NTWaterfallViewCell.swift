//
//  DetailViewController.swift
//  
//
//  Created by Sanjay Mallik on 11/15/14.
//  Copyright (c) 2014 Sanjay Mallik. All rights reserved.
//

import UIKit

class NTWaterfallViewCell :UICollectionViewCell, NTTansitionWaterfallGridViewProtocol{
    var imageName : UIImage?
    var imageViewContent : UIImageView = UIImageView()
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.lightGrayColor()
        contentView.addSubview(imageViewContent)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        imageViewContent.frame = CGRectMake(0, 0, frame.size.width, frame.size.height)
        imageViewContent.image = imageName
    }
    
    func snapShotForTransition() -> UIView! {
        let snapShotView = UIImageView(image: self.imageViewContent.image)
        snapShotView.frame = imageViewContent.frame
        return snapShotView
    }
}