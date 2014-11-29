//
//  DetailViewController.swift
//
//  Created by Sanjay Mallik on 11/15/14.
//  Copyright (c) 2014 Sanjay Mallik. All rights reserved.
//

import UIKit

let waterfallViewCellIdentify = "waterfallViewCellIdentify"

class NavigationControllerDelegate: NSObject, UINavigationControllerDelegate{
    func navigationController(navigationController: UINavigationController!, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController!, toViewController toVC: UIViewController!) -> UIViewControllerAnimatedTransitioning!{
        let transition = NTTransition()
        transition.presenting = operation == .Pop
        return  transition
    }
}

class NTWaterfallViewController:UICollectionViewController, CHTCollectionViewDelegateWaterfallLayout, NTTransitionProtocol, NTWaterFallViewControllerProtocol,UIImagePickerControllerDelegate, UINavigationControllerDelegate{
//    class var sharedInstance: NSInteger = 0 Are u kidding me?
    var imageNameList : NSMutableArray = []
    var imageView = UIImageView()
    
    @IBOutlet weak var addPhotos: UIButton!
    let delegateHolder = NavigationControllerDelegate()
    
    /*var detailItem: AnyObject? {
        didSet {
            // Update the view.
            
        }
    }*/

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationController!.delegate = delegateHolder
        self.view.backgroundColor = UIColor.yellowColor()
        
        var img:UIImage = UIImage()
        var index = 0
        while(index<14){
            let imageName = NSString(format: "%d.jpg", index)
            let img = UIImage(named: imageName)!
            imageNameList.addObject(img)
            index++
        }
        
        collectionView!.frame = screenBounds
        collectionView!.setCollectionViewLayout(CHTCollectionViewWaterfallLayout(), animated: false)
        collectionView!.backgroundColor = UIColor.grayColor()
        collectionView!.bounces = true
        collectionView!.registerClass(NTWaterfallViewCell.self, forCellWithReuseIdentifier: waterfallViewCellIdentify)
        collectionView!.reloadData()

    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize{
        let image:UIImage = self.imageNameList[indexPath.row] as UIImage
        let imageHeight = image.size.height*gridWidth/image.size.width
        return CGSizeMake(gridWidth, imageHeight)
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell{
        var collectionCell: NTWaterfallViewCell = collectionView.dequeueReusableCellWithReuseIdentifier(waterfallViewCellIdentify, forIndexPath: indexPath) as NTWaterfallViewCell
        //collectionCell.imageViewContent.image = UIImage()
        println("setting images")
        collectionCell.imageViewContent.image  = self.imageNameList[indexPath.row] as? UIImage
        //collectionCell.setNeedsLayout()
        //collectionView.reloadData()
        return collectionCell;
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return imageNameList.count;
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath){
        let pageViewController = NTHorizontalPageViewController(collectionViewLayout: pageViewControllerLayout(), currentIndexPath:indexPath)
        pageViewController.imageNameList = self.imageNameList
        collectionView.setCurrentIndexPath(indexPath)
        navigationController!.pushViewController(pageViewController, animated: true)
    }
    
    func pageViewControllerLayout () -> UICollectionViewFlowLayout {
        let flowLayout = UICollectionViewFlowLayout()
        let itemSize  = self.navigationController!.navigationBarHidden ?
        CGSizeMake(screenWidth, screenHeight+20) : CGSizeMake(screenWidth, screenHeight-navigationHeaderAndStatusbarHeight)
        flowLayout.itemSize = itemSize
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.scrollDirection = .Horizontal
        return flowLayout
    }
    
    func viewWillAppearWithPageIndex(pageIndex : NSInteger) {
        var position : UICollectionViewScrollPosition =
        .CenteredHorizontally & .CenteredVertically
        let image:UIImage! = self.imageNameList[pageIndex] as UIImage
        let imageHeight = image.size.height*gridWidth/image.size.width
        if imageHeight > 400 {//whatever you like, it's the max value for height of image
           position = .Top
        }
        let currentIndexPath = NSIndexPath(forRow: pageIndex, inSection: 0)
        collectionView!.setCurrentIndexPath(currentIndexPath)
        if pageIndex<2{
            collectionView!.setContentOffset(CGPointZero, animated: false)
        }else{
            collectionView!.scrollToItemAtIndexPath(currentIndexPath, atScrollPosition: position, animated: false)
        }
    }
    
    func transitionCollectionView() -> UICollectionView!{
        return collectionView
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func addNewBev(sender: UIButton) {
        
        var available = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        println(available)
        
        if available == true{
            var pickerController : UIImagePickerController = UIImagePickerController()
            pickerController.sourceType = UIImagePickerControllerSourceType.Camera
            pickerController.delegate = self
            pickerController.allowsEditing = false
            self.presentViewController(pickerController, animated: true, completion: nil)
        }else{
            println("Camera is not available on this devicce")
        }

    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info:NSDictionary) {
        //var count = self.imageNameList.count - 1
        var addedImage:UIImage = info[UIImagePickerControllerOriginalImage] as UIImage!
        imageNameList.addObject(addedImage)
        println(imageNameList.count)
        collectionView!.setNeedsLayout()
        collectionView!.reloadData()
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}

