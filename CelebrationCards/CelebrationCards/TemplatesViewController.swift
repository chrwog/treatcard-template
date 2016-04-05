//
//  TemplatesViewController.swift
//  CelebrationCards
//
//  Created by Roger Serrat Santiago on 21/11/15.
//  Copyright © 2015 Yowlu, SCP. All rights reserved.
//

import UIKit
import GoogleMobileAds

// global var that stores the choosen template
var choosenTemplate = 0

// global var that stores the choosen template type
var choosenTemplateType = "template1"

class TemplatesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    // templates array
    var templatesArray = Array<Array<[String:String]>>()
    
    // main text
    var mainText = ""
    
    // main image
    var mainImage = ""
    
    // secondary image
    var secondaryImage = ""
    
    // main background color
    var mainBackgroundColor = ""
    
    // main foreground color
    var mainForegroundColor = ""
    
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
        templatesArray = [[["background_image":"template5.png", "type":"template1", "text":"Your message", "image":"img_template3.png", "image2":"card_decoration4.png", "background_color":"#FFFFFF", "foreground_color":"#434A54"],["background_image":"template1.png", "type":"template3", "text":"Your message", "image":"img_template1.jpg", "image2":"card_decoration1.png", "background_color":"#FFFFFF", "foreground_color":"#434A54"],["background_image":"template3.png", "type":"template4", "text":"Your message", "image":"img_template2.png", "image2":"card_decoration2.png", "background_color":"#B73430", "foreground_color":"#FFFFFF"],["background_image":"template4.png", "type":"template5", "text":"Your message", "image":"", "image2":"card_decoration3.png", "background_color":"#CAE2EA", "foreground_color":"#FFFFFF"],["background_image":"template6.png", "type":"template8", "text":"Your message", "image":"", "image2":"card_decoration5.png", "background_color":"#CAE2EA", "foreground_color":"#FFFFFF"],["background_image":"template7.png", "type":"template4", "text":"Your message", "image":"img_template4.png", "image2":"card_decoration6.png", "background_color":"#8DAAAE", "foreground_color":"#FFFFFF"],["background_image":"template8.png", "type":"template4", "text":"Your message", "image":"img_template5.png", "image2":"card_decoration7.png", "background_color":"#5F7C5C", "foreground_color":"#FFFFFF"],["background_image":"template9.png", "type":"template5", "text":"Your message", "image":"img_template5.png", "image2":"card_decoration8.png", "background_color":"#84B482", "foreground_color":"#FFFFFF"],["background_image":"template10.png", "type":"template3", "text":"Your message", "image":"img_template6.png", "image2":"card_decoration9.png", "background_color":"#FFFFFF", "foreground_color":"#434A54"],["background_image":"template11.png", "type":"template7", "text":"Your message", "image":"img_template7.png", "image2":"card_decoration10.png", "background_color":"#FFFFFF", "foreground_color":"#434A54"],
            ["background_image":"template13.png", "type":"template4", "text":"Your message", "image":"img_template9.png", "image2":"card_decoration12.png", "background_color":"#8DAAAE", "foreground_color":"#FFFFFF"],
            ["background_image":"template12.png", "type":"template9", "text":"Your message", "image":"img_template8.png", "image2":"card_decoration11.png", "background_color":"#FFFFFF", "foreground_color":"#434A54"],
            ["background_image":"template14.png", "type":"template3", "text":"Your message", "image":"img_template10.png", "image2":"card_decoration13.png", "background_color":"#FFFFFF", "foreground_color":"#434A54"],
            ["background_image":"template15.png", "type":"template4", "text":"Your message", "image":"img_template11.png", "image2":"card_decoration14.png", "background_color":"#B73430", "foreground_color":"#FFFFFF"],
            ["background_image":"template16.png", "type":"template6", "text":"Your message", "image":"img_template12.png", "image2":"card_decoration15.png", "background_color":"#EBC65D", "foreground_color":"#DA4453"],
            ["background_image":"template17.png", "type":"template7", "text":"Your message", "image":"img_template13.png", "image2":"card_decoration16.png", "background_color":"#FFFFFF", "foreground_color":"#434A54"]
            ], // Christmas
            [["background_image":"template18.png", "type":"template4", "text":"Your message", "image":"img_template14.png", "image2":"card_decoration17.png",  "background_color":"#EFD995", "foreground_color":"#FFFFFF"],
             ["background_image":"template19.png", "type":"template3", "text":"Your message", "image":"img_template15.png", "image2":"card_decoration18.png",  "background_color":"#FFFFFF", "foreground_color":"#434A54"],
             ["background_image":"template20.png", "type":"template7", "text":"Your message", "image":"img_template16.png", "image2":"card_decoration19.png",  "background_color":"#FFFFFF", "foreground_color":"#434A54"],
             ["background_image":"template21.png", "type":"template4", "text":"Your message", "image":"img_template17.png", "image2":"card_decoration20.png",  "background_color":"#FFFFFF", "foreground_color":"#434A54"],
             ["background_image":"template22.png", "type":"template6", "text":"Your message", "image":"img_template18.png", "image2":"card_decoration21.png",  "background_color":"#FFFFFF", "foreground_color":"#DA4453"],
             ["background_image":"template23.png", "type":"template1", "text":"Your message", "image":"img_template19.png", "image2":"card_decoration22.png",  "background_color":"#FFFFFF", "foreground_color":"#434A54"],
             ["background_image":"template24.png", "type":"template4", "text":"Your message", "image":"img_template20.png", "image2":"card_decoration23.png",  "background_color":"#DEA492", "foreground_color":"#FFFFFF"],
             ["background_image":"template25.png", "type":"template7", "text":"Your message", "image":"img_template21.png", "image2":"card_decoration24.png",  "background_color":"#000000", "foreground_color":"#FFFFFF"],
             ["background_image":"template43.png", "type":"template6", "text":"Your message", "image":"img_template37.png", "image2":"card_decoration42.png", "background_color":"#EFD995", "foreground_color":"#434A54"]
            ], // Birthday
            [["background_image":"template26.png", "type":"template4", "text":"Your message", "image":"img_template22.png", "image2":"card_decoration25.png", "background_color":"#EFD995", "foreground_color":"#FFFFFF"],
             ["background_image":"template28.png", "type":"template6", "text":"Your message", "image":"img_template24.png", "image2":"card_decoration27.png", "background_color":"#434A54", "foreground_color":"#FFFFFF"],
             ["background_image":"template27.png", "type":"template3", "text":"Your message", "image":"img_template23.png", "image2":"card_decoration26.png",  "background_color":"#FFDCDC", "foreground_color":"#FFFFFF"],
             ["background_image":"template29.png", "type":"template3", "text":"Your message", "image":"img_template25.png", "image2":"card_decoration28.png",  "background_color":"#FFFFFF", "foreground_color":"#434A54"],
             ["background_image":"template30.png", "type":"template5", "text":"Your message", "image":"img_template25.png", "image2":"card_decoration29.png",  "background_color":"#434A54", "foreground_color":"#FFFFFF"],
             ["background_image":"template31.png", "type":"template1", "text":"Your message", "image":"img_template26.png", "image2":"card_decoration30.png",  "background_color":"#EFD995", "foreground_color":"#FFFFFF"]
            ], // Love
             [["background_image":"template37.png", "type":"template3", "text":"Your message", "image":"img_template31.png", "image2":"card_decoration36.png", "background_color":"#FFFFFF", "foreground_color":"#434A54"],
             ["background_image":"template38.png", "type":"template4", "text":"Your message", "image":"img_template32.png", "image2":"card_decoration37.png", "background_color":"#FFFFFF", "foreground_color":"#434A54"],
             ["background_image":"template39.png", "type":"template4", "text":"Your message", "image":"img_template33.png", "image2":"card_decoration38.png", "background_color":"#393f47", "foreground_color":"#FFFFFF"],
             ["background_image":"template40.png", "type":"template1", "text":"Your message", "image":"img_template34.png", "image2":"card_decoration39.png", "background_color":"#FFFFFF", "foreground_color":"#434A54"],
             ["background_image":"template41.png", "type":"template6", "text":"Your message", "image":"img_template35.png", "image2":"card_decoration40.png", "background_color":"#FFFFFF", "foreground_color":"#434A54"],
             ["background_image":"template42.png", "type":"template4", "text":"Your message", "image":"img_template36.png", "image2":"card_decoration41.png", "background_color":"#393f47", "foreground_color":"#FFFFFF"]
            ], // Friends
             [["background_image":"template32.png", "type":"template9", "text":"Your message", "image":"img_template22.png", "image2":"card_decoration31.png", "background_color":"#FFFFFF", "foreground_color":"#434A54"],
             ["background_image":"template33.png", "type":"template4", "text":"Your message", "image":"img_template27.png", "image2":"card_decoration32.png", "background_color":"#434A54", "foreground_color":"#FFFFFF"],
             ["background_image":"template34.png", "type":"template3", "text":"Your message", "image":"img_template28.png", "image2":"card_decoration33.png", "background_color":"#FFFFFF", "foreground_color":"#434A54"],
             ["background_image":"template35.png", "type":"template7", "text":"Your message", "image":"img_template29.png", "image2":"card_decoration34.png",  "background_color":"#000000", "foreground_color":"#FFFFFF"],
             ["background_image":"template36.png", "type":"template4", "text":"Your message", "image":"img_template30.png", "image2":"card_decoration35.png", "background_color":"#FFFFFF", "foreground_color":"#434A54"]
            ]] // Thanks
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
        // return the count of the templates array
        return templatesArray[choosenCategory].count
    }
    
    // collection view method -> cell for item at index path (where all the cells are populated)
    internal func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        // declare a cell
        let cell:UICollectionViewCell!
        
        // load the sticker cell template (depending on the aspect ratio of the template)
        if UIImage(named:templatesArray[choosenCategory][indexPath.row]["background_image"]!)?.size.width < UIImage(named:templatesArray[choosenCategory][indexPath.row]["background_image"]!)?.size.height {
            cell = collectionView.dequeueReusableCellWithReuseIdentifier("TemplateCellWide", forIndexPath: indexPath)
        }
        else {
            cell = collectionView.dequeueReusableCellWithReuseIdentifier("TemplateCellNarrow", forIndexPath: indexPath)
        }
        
        // load the category image to the background image
        (cell.viewWithTag(1) as! UIImageView).image = UIImage(named:templatesArray[choosenCategory][indexPath.row]["background_image"]!)
        
        // add a shadow
        (cell.viewWithTag(1) as! UIImageView).layer.shadowColor = UIColor.lightGrayColor().CGColor
        (cell.viewWithTag(1) as! UIImageView).layer.shadowOffset = CGSizeMake(0, 0)
        (cell.viewWithTag(1) as! UIImageView).layer.shadowOpacity = 0.3
        (cell.viewWithTag(1) as! UIImageView).layer.shadowRadius = 5
        
        return cell
    }
    
    // collection view method -> size for item at index path (where all the cells are given a size)
    internal func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        // set a width that is equal to the half (minus insets) of the collection view width. Set a height that is a 1.5 times bigger than the width of the collection view
        return CGSizeMake(((collectionView.bounds.width - 8) / 2.0), ((collectionView.bounds.width - 8) / 2.0) * 1.2)
    }
    
    // collection view method -> cell selected at index path
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        // set the choosen template
        choosenTemplate = indexPath.row
        // set the choosen template type
        choosenTemplateType = templatesArray[choosenCategory][indexPath.row]["type"]!
        
        // set the text for the template
        mainText = templatesArray[choosenCategory][indexPath.row]["text"]!
        // set the image for the template
        mainImage = templatesArray[choosenCategory][indexPath.row]["image"]!
        // set the scondary image for the template
        secondaryImage = templatesArray[choosenCategory][indexPath.row]["image2"]!
        // set the main background color
        mainBackgroundColor = templatesArray[choosenCategory][indexPath.row]["background_color"]!
        // set the main foreground color
        mainForegroundColor = templatesArray[choosenCategory][indexPath.row]["foreground_color"]!
        
        performSegueWithIdentifier("CardSegue", sender: self)
    }
    
    // set the status bar to light
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    // go back to menu
    @IBAction func backToMenu(sender: AnyObject) {
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "CardSegue" {
            // Get the new view controller using segue.destinationViewController.
            // Pass the selected object to the new view controller.
            let viewController = segue.destinationViewController as! CardViewController
            
            // set the text and image
            viewController.mainText = mainText
            viewController.mainImage = mainImage
            viewController.secondaryImage = secondaryImage
            viewController.mainBackgroundColor = mainBackgroundColor
            viewController.mainForegroundColor = mainForegroundColor
        }
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
