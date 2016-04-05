//
//  CategoriesViewController.swift
//  CelebrationCards
//
//  Created by Roger Serrat Santiago on 21/11/15.
//  Copyright © 2015 Yowlu, SCP. All rights reserved.
//

import UIKit
import GoogleMobileAds

// global var that stores the choosen category
var choosenCategory = 0

class CategoriesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    // categories array
    let categoriesArray = ["cover1.png", "cover2.png", "cover3.png","cover4.png", "cover5.png"]
    
    // the ads views
    @IBOutlet weak var adsView: UIView!
    @IBOutlet weak var bannerView: GADBannerView!
    
    // ads constraints
    @IBOutlet weak var adsHeightConstraint: NSLayoutConstraint!
    
    // your banner admob id
    let bannerAdUnitID = "ca-app-pub-3940256099942544/2934735716"
    
    // boolean var (used to control first time for ads)
    var firstTime = true

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        // check if first time to init ads
        if firstTime {
            // toggle the first time
            firstTime = false
            
            // init the ads display
            initAds()
        }
    }
    
    // collection view method -> number of items in section (we only use one section)
    internal func collectionView(collectionView: UICollectionView, numberOfItemsInSection section:Int)->Int {
        // return the count of the categories array
        return categoriesArray.count
    }
    
    // collection view method -> cell for item at index path (where all the cells are populated)
    internal func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        // declare a cell
        let cell:UICollectionViewCell!
        
        // load the sticker cell template
        cell = collectionView.dequeueReusableCellWithReuseIdentifier("CategoryCell", forIndexPath: indexPath)
        
        // load the category image to the background image
        (cell.viewWithTag(2) as! UIImageView).image = UIImage(named:categoriesArray[indexPath.row])

        return cell
    }
    
    // collection view method -> size for item at index path (where all the cells are given a size)
    internal func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        // set a width that is equal to the collection view width. Set a height that is a fifth part of the width of the collection view
        return CGSizeMake(collectionView.bounds.width, collectionView.bounds.width * 0.4)
    }
    
    // collection view method -> cell selected at index path
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        // set the choosen category
        choosenCategory = indexPath.row
    }
    
    // set the status bar to light
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    // go back to menu
    @IBAction func backToMenu(sender: AnyObject) {
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // init or delete the ads
    func initAds() {
        // decide if you want to use Google AdMob
        let useAds:Int = 1;
        switch useAds {
        case 1:
            // start Google AdMob request
            googleAdMobInit()
            break;
        default:
            // show no ads
            deleteAds()
            break;
        }
    }
    
    // Google AdMob init
    func googleAdMobInit() {
        // init the banner
        bannerView.adUnitID = bannerAdUnitID
        bannerView.rootViewController = self
        
        let request:GADRequest = GADRequest();
        
        // Requests test ads on devices you specify. Your test device ID is printed to the console when
        // an ad request is made. GADBannerView automatically returns test ads when running on a
        // simulator.
        request.testDevices = [
            "2077ef9a63d2b398840261c8221a0c9a",  // Eric's iPod Touch
            kGADSimulatorID // iphone simulator
        ]
        
        bannerView.loadRequest(request);
    }
    
    // Delete Ads
    func deleteAds() {
        adsHeightConstraint.constant = 0
        adsView.updateConstraints()
    }
}
