//
//  OnboardingViewController.swift
//  MC1-Group12
//
//  Created by Anselmus Pavel Adriska on 09/04/22.
//

import UIKit

class OnboardingViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var getStartedBtn: UIButton!
    
    var scrollHeight: CGFloat! = 0.0
    var scrollWidth: CGFloat! = 0.0
    
    //Slides data
    var titles = ["Hi! Welcome to USay!", "We're ready to assist you!", "Communication is the key!"]
    var desc = ["Let's get started! Are you excited?", "We help you find activities for you and your child based on your preferences.", "These activities helps you to mantain your interaction with your child especially in communication."]
    var imgs = ["onboarding_1", "onboarding_2", "onboarding_3"]
    
    override func viewDidLayoutSubviews() {
        scrollHeight = scrollView.frame.size.height
        scrollWidth = scrollView.frame.size.width
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.layoutIfNeeded()
        
        self.scrollView.delegate = self
        scrollView.isPagingEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        
        var frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        
        //Creating and adding slides to scrollView
        for index in 0..<titles.count {
            frame.origin.x = scrollWidth * CGFloat(index)
            frame.size = CGSize(width: scrollWidth, height: scrollHeight)
            
            let slide = UIView(frame: frame)
            
            //subviews
            let imageView = UIImageView.init(image: UIImage.init(named: imgs[index]))
            imageView.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
            imageView.contentMode = .scaleAspectFit
            imageView.center = CGPoint(x: scrollWidth/2, y: scrollHeight/2 - 50)
            
            let titleTxt = UILabel.init(frame: CGRect(x: 32, y: imageView.frame.maxY+30, width: scrollWidth-64, height: 30))
            titleTxt.textAlignment = .center
            titleTxt.font = UIFont.boldSystemFont(ofSize: 20.0)
            titleTxt.text = titles[index]
            
            let descTxt = UILabel.init(frame: CGRect(x: 32, y: titleTxt.frame.maxY+10, width: scrollWidth-64, height: 70))
            descTxt.textAlignment = .center
            descTxt.numberOfLines = 3
            descTxt.font = UIFont.systemFont(ofSize: 14.0)
            descTxt.text = desc[index]
            
            slide.addSubview(imageView)
            slide.addSubview(titleTxt)
            slide.addSubview(descTxt)
            scrollView.addSubview(slide)
        }
        
        //Set scrollView width to contain all slides
        scrollView.contentSize = CGSize(width: scrollWidth * CGFloat(titles.count), height: scrollHeight)
        
        //Disable vertical scroll/bounce
        self.scrollView.contentSize.height = 1.0
        
        //Set initial state for page control
        pageControl.numberOfPages = titles.count
        pageControl.currentPage = 0
        
        //Set inital state for button
        getStartedBtn.isEnabled = false
    }
    
    //When page control indicator clicked
    @IBAction func pageChanged(_ sender: Any) {
        scrollView!.scrollRectToVisible(CGRect(x: scrollWidth * CGFloat ((pageControl?.currentPage)!), y: 0, width: scrollWidth, height: scrollHeight), animated: true)
        
        getStartedBtn.isEnabled = pageControl.currentPage == 2 ? true : false
    }
    
    //Set button isEnabled property based on the currentPage of pageControl
    func setButtonEnableProperty() {
        getStartedBtn.isEnabled = pageControl.currentPage == 2 ? true : false
    }
    
    //Function that will be ran after user swiped through scrollView
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        setIndiactorForCurrentPage()
        
        //Set button state
        setButtonEnableProperty()
    }

    //Set indicator for pageControl current page
    func setIndiactorForCurrentPage()  {
        let page = (scrollView?.contentOffset.x)!/scrollWidth
        pageControl?.currentPage = Int(page)
    }
}
