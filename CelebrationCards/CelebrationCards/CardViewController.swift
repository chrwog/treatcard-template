//
//  CardViewController.swift
//  CelebrationCards
//
//  Created by Roger Serrat Santiago on 21/11/15.
//  Copyright © 2015 Yowlu, SCP. All rights reserved.
//

import UIKit
import GoogleMobileAds

class CardViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIDocumentInteractionControllerDelegate, GADInterstitialDelegate, UIScrollViewDelegate {
    
    // main view used
    var mainView: UIView!
    
    // main label of the card
    var mainLabel: UILabel!
    
    // main image view of the card
    var mainImageView: UIImageView!
    
    // secondary image view of the card
    var secondaryImageView: UIImageView!
    
    // camera icon view of the card
    var cameraIconView: UIView!
    
    // main text of the card
    var mainText: String!
    
    // main image of the card
    var mainImage: String!
    
    // secondary image of the card
    var secondaryImage: String!
    
    // main background color of the card
    var mainBackgroundColor: String!
    
    // main foreground color of the card
    var mainForegroundColor: String!
    
    // control if we need to show again the camera icon
    var needToShowAgain = false
    
    // boolean var (used to control first time for layout subviews)
    var firstTimeLayoutSubviews = true
    
    // main scroll view
    @IBOutlet var mainScrollView: UIScrollView!
    
    // template 1
    @IBOutlet var template1: UIView!
    
    // template 2
    @IBOutlet var template2: UIView!
    
    // template 3
    @IBOutlet var template3: UIView!
    
    // template 4
    @IBOutlet var template4: UIView!

    // template 5
    @IBOutlet var template5: UIView!
    
    // template 6
    @IBOutlet var template6: UIView!
    
    // template 7
    @IBOutlet var template7: UIView!
    
    // template 8
    @IBOutlet var template8: UIView!

    // template 9
    @IBOutlet var template9: UIView!

    // main wrapper view
    @IBOutlet var mainWrapperView: UIView!
    
    // the main text field (used to write on the labels)
    @IBOutlet var mainTextField: UITextField!
    
    // store the original constant to use it later
    var mainViewBottomConstant:CGFloat = 0
    
    // main textfield bottom constraint (used to move the textfield up when the keyboard is shown)
    @IBOutlet weak var mainTextFieldBottomConstraint: NSLayoutConstraint!
    
    // the image picker controller
    let imagePicker = UIImagePickerController()
    
    // the controller delegated of the share actions
    var shareController:UIDocumentInteractionController!
    
    // the ads views
    @IBOutlet weak var adsView: UIView!
    @IBOutlet weak var bannerView: GADBannerView!
    
    // ads constraints
    @IBOutlet weak var adsHeightConstraint: NSLayoutConstraint!
    
    // is portrait?
    var isPortrait = true
    
    // the interstitial
    var interstitial: GADInterstitial?
    
    // your banner admob id
    let bannerAdUnitID = "ca-app-pub-3940256099942544/2934735716"
    
    // your interstital admob id
    let interstitialAdUnitID = "ca-app-pub-3940256099942544/4411468910"
    
    // boolean var (used to control first time for ads)
    var firstTime = true
    
    // need to show ad
    var needToShowAd = false
    
    // a function required to use the interstitial
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // add an observer to catch later when the keyboard will show
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        
        // avoid the keyboard to show suggestions
        mainTextField.autocorrectionType = UITextAutocorrectionType.No
        
        // set the delegate for the image picker
        imagePicker.delegate = self
        
        // set the choosen template view
        switch choosenTemplateType {
            case "template2":
                mainView = template2
                isPortrait = true
                break
            case "template3":
                mainView = template3
                isPortrait = true
                break
            case "template4":
                mainView = template4
                isPortrait = false
                break
            case "template5":
                mainView = template5
                isPortrait = false
                break
            case "template5":
                mainView = template5
                isPortrait = false
                break
            case "template6":
                mainView = template6
                isPortrait = false
                break
            case "template7":
                mainView = template7
                isPortrait = false
                break
            case "template8":
                mainView = template8
                isPortrait = true
                break
            case "template9":
                mainView = template9
                isPortrait = false
                break
            default:
                mainView = template1
                isPortrait = true
                break
        }
        
        // add a shadow
        mainView.layer.shadowColor = UIColor.lightGrayColor().CGColor
        mainView.layer.shadowOffset = CGSizeMake(0, 0)
        mainView.layer.shadowOpacity = 0.3
        mainView.layer.shadowRadius = 10
        
        // set the main label
        mainLabel = mainView.viewWithTag(1) as! UILabel
        
        // set the main image
        if mainView.viewWithTag(2) != nil {
            mainImageView = mainView.viewWithTag(2) as! UIImageView
        }
        
        // set the secondary image
        secondaryImageView = mainView.viewWithTag(3) as! UIImageView
        
        if mainView.viewWithTag(4) != nil {
            // set the camera icon
            cameraIconView = mainView.viewWithTag(4)
        }
        
        // set the main text
        mainLabel.text = mainText
        
        // set the main image
        if mainImageView != nil {
            mainImageView.image = UIImage(named: mainImage)
        }
        
        // set the secondary image
        secondaryImageView.image = UIImage(named: secondaryImage)
        
        // set the main background color
        mainView.backgroundColor = colorWithHexString(mainBackgroundColor)
        
        // set the main foreground color
        mainLabel.textColor = colorWithHexString(mainForegroundColor)
        
        // if iPad increase the font size
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
            mainLabel.font = UIFont(name: mainLabel.font.fontName, size: 24)
        }
        
        // add a tap gesture to the main label
        let labelTapGesture:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: Selector("setMainLabelText:"))
        mainLabel.addGestureRecognizer(labelTapGesture)
        
        if mainImageView != nil {
            // add a tap gesture to the main image
            let imageTapGesture:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: Selector("setMainImageViewImage:"))
            mainImageView.addGestureRecognizer(imageTapGesture)
            
            // add a tap gesture to the camera icon
            cameraIconView.addGestureRecognizer(imageTapGesture)
        }
   
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        // if we set it to true
        if needToShowAd {
            // toggle it
            needToShowAd = false
            
            // call to show the interstitial
            if self.interstitial != nil {
                if self.interstitial!.isReady {
                    self.interstitial!.presentFromRootViewController(self)
                }
            }
        }
        
        // check if first time to init ads
        if firstTime {
            // toggle the first time
            firstTime = false
            
            // init the ads display
            initAds()
            
            // init the share controller
            initShare()
        }
        
        // if need to show the camera icon
        if needToShowAgain {
            needToShowAgain = false
            
            cameraIconView.hidden = false
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if (firstTimeLayoutSubviews) {
            firstTimeLayoutSubviews = false
            
            mainView.translatesAutoresizingMaskIntoConstraints = false
            
            // add the main view
            mainWrapperView.addSubview(mainView)
            
            // top constraint
            let mainViewTopConstraint = NSLayoutConstraint(item: mainView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: mainWrapperView, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: (isPortrait) ? 40 : (UIDevice.currentDevice().userInterfaceIdiom == .Pad) ? (mainWrapperView.bounds.height - ((mainWrapperView.bounds.width - 60) * 0.66)) : (mainWrapperView.bounds.height - ((mainWrapperView.bounds.width - 60) * 0.66)) / 2.0)
            
            print("1: \(mainWrapperView.bounds.height)")
            print("2: \(mainWrapperView.bounds.width)")
            
            // give it an indentifier so we can find it later
            mainViewTopConstraint.identifier = "mainViewTopConstraint"
            
            // add the top constraint
            mainWrapperView.addConstraint(mainViewTopConstraint)
            
            // store the constant
            mainViewBottomConstant = (isPortrait) ? -40 : (UIDevice.currentDevice().userInterfaceIdiom == .Pad) ? -(mainWrapperView.bounds.height - ((mainWrapperView.bounds.width - 60) * 0.66)) : -(mainWrapperView.bounds.height - ((mainWrapperView.bounds.width - 60) * 0.66)) / 2.0
            
            // bottom constraint
            let mainViewBottomConstraint = NSLayoutConstraint(item: mainView, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: mainWrapperView, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: mainViewBottomConstant)
            
            // give it an indentifier so we can find it later
            mainViewBottomConstraint.identifier = "mainViewBottomConstraint"
            
            // add the bottom constraint
            mainWrapperView.addConstraint(mainViewBottomConstraint)
            
            // leading constraint
            let mainViewLeadingConstraint = NSLayoutConstraint(item: mainView, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: mainWrapperView, attribute: NSLayoutAttribute.Leading, multiplier: 1, constant: (isPortrait) ? 40 : 10)
            
            // add the leading constraint
            mainWrapperView.addConstraint(mainViewLeadingConstraint)
            
            // trailing constraint
            let mainViewTrailingConstraint = NSLayoutConstraint(item: mainView, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: mainWrapperView, attribute: NSLayoutAttribute.Trailing, multiplier: 1, constant: (isPortrait) ? -40 : -10)
            
            // add the trailing constraint
            mainWrapperView.addConstraint(mainViewTrailingConstraint)
            
            mainWrapperView.layoutIfNeeded()
            
            if mainImageView != nil {
                // set the correct corner radius
                cameraIconView.layer.cornerRadius = cameraIconView.bounds.width / 2
            }
            
            // bring the label on front to avoid weird issues
            mainView.bringSubviewToFront(mainLabel)
        }
        
        print("3: \(mainWrapperView.bounds.height)")
        print("2: \(mainWrapperView.bounds.width)")
    }
    
    // event called when a the keyboard is going to show
    func keyboardWillShow (notification: NSNotification){
        // get the info of the notification and get the keyboard height to move up the inputs view
        var info = notification.userInfo!
        let keyboardFrame:CGRect = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        
        // set the new constant of the constraint and animate it
        mainTextFieldBottomConstraint.constant = keyboardFrame.height
        
        
        // check if we need to move the view
        if view.convertRect(view.frame, fromView: mainLabel).origin.y > view.bounds.height / 2 {
            for constraint:NSLayoutConstraint in mainWrapperView.constraints {
                if constraint.identifier == "mainViewBottomConstraint" {
                    constraint.constant = -((view.bounds.height / 2) - 80)
                }
                else if constraint.identifier == "mainViewTopConstraint" {
                    constraint.constant = 10
                }
            }
        }
        
        UIView.animateWithDuration(0.4) { () -> Void in
            self.mainWrapperView.layoutIfNeeded()
            self.view.layoutIfNeeded()
        }
    }
    
    // touches began on the main view, deal with the focuses of the textfields
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touchesSet = touches as NSSet
        let touch = touchesSet.anyObject() as? UITouch
        
        // if we were editing the main textfield and we lose the focus
        if mainTextField.isFirstResponder() && touch!.view != self.mainTextField  {
            // dismiss the keyboard
            mainTextField.resignFirstResponder();
            
            // set the new constraints
            mainTextFieldBottomConstraint.constant = -50
            
            // restore constraints
            for constraint:NSLayoutConstraint in mainWrapperView.constraints {
                if constraint.identifier == "mainViewBottomConstraint" {
                    constraint.constant = mainViewBottomConstant
                }
                else if constraint.identifier == "mainViewTopConstraint" {
                    constraint.constant = -mainViewBottomConstant
                }
            }
            
            UIView.animateWithDuration(0.2) { () -> Void in
                self.mainWrapperView.layoutIfNeeded()
                self.view.layoutIfNeeded()
            }
        }
    }
    
    // event called when a text field has changed
    @IBAction func textFieldChanged(sender: AnyObject) {
        // set the new text on to the main label
        mainLabel.text = mainTextField.text
    }
    
    // action to resign first responder
    @IBAction func actionToResignFirstResponder() {
        textFieldShouldReturn(mainTextField)
    }
    
    // event called when the return button is tapped on the keyboard
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        // set the new constant of the constraint and animate it
        mainTextFieldBottomConstraint.constant = -50
        
        // restore constraints
        for constraint:NSLayoutConstraint in mainWrapperView.constraints {
            if constraint.identifier == "mainViewBottomConstraint" {
                constraint.constant = mainViewBottomConstant
            }
            else if constraint.identifier == "mainViewTopConstraint" {
                constraint.constant = -mainViewBottomConstant
            }
        }
        
        UIView.animateWithDuration(0.2) { () -> Void in
            self.mainWrapperView.layoutIfNeeded()
            self.view.layoutIfNeeded()
        }
        
        return true
    }
    
    // show the keyboard to edit the label
    func setMainLabelText(sender:UITapGestureRecognizer) {
        // show keyboard
        mainTextField.becomeFirstResponder()
        
        // set the current text
        mainTextField.text = mainLabel.text
    }
    
    // show the image picker
    func setMainImageViewImage(sender:UITapGestureRecognizer) {
        // show keyboard
        pickPhotoFromGallery(self)
    }
    
    // action to pick image from the gallery
    func pickPhotoFromGallery(sender: AnyObject) {
        // set the image picker for the library
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .PhotoLibrary
        
        // show the picker
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    /*// action to pick image from the camera
    func pickPhotoFromCamera(sender: AnyObject) {
        // set the image picker for the camera
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .Camera
        
        // show the picker
        presentViewController(imagePicker, animated: true, completion: nil)
    }*/
    
    // callback for the image picker
    func imagePickerController(picker: UIImagePickerController,didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        // if we chose an image,
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            mainImageView.image = pickedImage
            
            cameraIconView.hidden = true
        }
        
        // dismiss the controller
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // callback for the cancel of the image picker
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        // dismiss the controller
        dismissViewControllerAnimated(true, completion: nil)
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
        
        // create the first interstitial
        self.interstitial = createAndLoadInterstitial()
    }
    
    // Delete Ads
    func deleteAds() {
        adsHeightConstraint.constant = 0
        adsView.updateConstraints()
    }
    
    // create and load the interstitial
    func createAndLoadInterstitial() -> GADInterstitial {
        let interstitial = GADInterstitial(adUnitID: interstitialAdUnitID)
        interstitial.delegate = self
        interstitial.loadRequest(GADRequest())
        return interstitial
    }
    
    // delegate protocol method called when the user has dismissed a interstitial
    func interstitialDidDismissScreen (interstitial: GADInterstitial) {
        // we load another one
        self.interstitial = createAndLoadInterstitial()
    }
    
    // if we received an ad
    func interstitialDidReceiveAd(ad: GADInterstitial!) {
        // if first time, show it
        if firstTime {
            firstTime = false
            
            if self.interstitial != nil {
                if (self.interstitial!.isReady) {
                    self.interstitial!.presentFromRootViewController(self)
                }
            }
            else {
                self.interstitial = createAndLoadInterstitial()
            }
        }
    }
    
    // Share implementation
    func initShare() {
        shareController = UIDocumentInteractionController()
        shareController.delegate = self
    }
    
    // share controller delegate functions
    func documentInteractionControllerViewControllerForPreview(controller: UIDocumentInteractionController) -> UIViewController{
        return self
    }
    
    // create the final image
    func createImage() -> NSString {
        // get the bounds of the view we want to create a image of
        let screenshotBounds = CGSizeMake(mainView.bounds.width, mainView.bounds.height)
        
        // threshold max size
        let maxSize = Double(1280.0);
        
        // check the max dimension
        let maxDim = Double(max(mainView.bounds.width, mainView.bounds.height));
        
        // get the scale
        let scale = CGFloat(Double(maxSize / maxDim));
        
        // begin to create the image
        UIGraphicsBeginImageContextWithOptions(screenshotBounds, false, scale);
        
        // render in the view we want
        mainView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        
        // create and render the image
        let screenCapture = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        // create a jpeg out of the raw data
        if let data = UIImagePNGRepresentation(screenCapture) {
            let filename = getDocumentsDirectory().stringByAppendingPathComponent("card.png");
            data.writeToFile(filename, atomically: true)
            
            return filename
        }
        
        return ""
    }
    
    // aux function used to get the correct path to store an image
    func getDocumentsDirectory() -> NSString {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    // share final image action
    @IBAction func shareFinalImage(sender: AnyObject) {
        if cameraIconView != nil {
            // hide it if necessary
            if !cameraIconView.hidden {
                cameraIconView.hidden = true
                needToShowAgain = true
            }
        }
        
        // call to create the image
        let path = createImage()
        
        // if success, send the image to the share controller
        if path != "" {
            let documentURL = NSURL(fileURLWithPath:path as String);
            
            // pass it to our document interaction controller
            shareController.URL = documentURL;
            
            // present the preview
            shareController.presentPreviewAnimated(true);
            
            // need to show add -> set it to true
            needToShowAd = true
        }
    }
    
    // utility function used to covert an hex value to an UIColor object (found here https://gist.github.com/arshad/de147c42d7b3063ef7bc#gistcomment-1487308)
    func colorWithHexString (hex:String) -> UIColor {
        var cString:String = hex.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()).uppercaseString
        
        if (cString.hasPrefix("#")) {
            cString = (cString as NSString).substringFromIndex(1)
        }
        
        if (cString.characters.count != 6) {
            return UIColor.grayColor()
        }
        
        let rString = (cString as NSString).substringToIndex(2)
        let gString = ((cString as NSString).substringFromIndex(2) as NSString).substringToIndex(2)
        let bString = ((cString as NSString).substringFromIndex(4) as NSString).substringToIndex(2)
        
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
        NSScanner(string: rString).scanHexInt(&r)
        NSScanner(string: gString).scanHexInt(&g)
        NSScanner(string: bString).scanHexInt(&b)
        
        
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(1))
    }
}
