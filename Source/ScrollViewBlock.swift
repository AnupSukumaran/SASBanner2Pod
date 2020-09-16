//
//  ScrollViewBlock.swift
//  SASPager
//
//  Created by Manu Puthoor on 17/02/20.
//  Copyright © 2020 Manu Puthoor. All rights reserved.
//

import UIKit


@IBDesignable
public class ScrollViewBlock: UIView {
  
    @IBOutlet public weak var pageControl: UIPageControl!
    
    public var pageVC: PageSlideViewController!
    public var baseVC: UIViewController!
    public var viewBGColor: UIColor = .green
    public var images: [UIImage?]?
    public var contentView: UIView?
    public var webViewBGC: UIColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
    public var contentViewBGC: UIColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    public var gameTimer: Timer?
    public var scrollInterval: TimeInterval = 2
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup(bgColor: viewBGColor)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        xibSetup(bgColor: viewBGColor)
    }
    
    public func congifBanner(images: [UIImage?]?, baseVC: UIViewController,imageFit: UIImageView.ContentMode, scrollInterval: TimeInterval = 2) {
        self.images = images
        settingPageViewController(baseVC: baseVC, imageContentFit: imageFit)
        self.scrollInterval = scrollInterval
        guard scrollInterval > 0 else {return}
        
        gameTimer = Timer.scheduledTimer(timeInterval: scrollInterval, target: self, selector: #selector(authenticate), userInfo: nil, repeats: true)

    }
    
    @objc func authenticate() {
        pageVC.forwardPage()
    }
    
    public func stopAutoScroll() {
        gameTimer?.invalidate()
    }
    
    public func startAutoScroll(){
        stopAutoScroll()
        gameTimer = Timer.scheduledTimer(timeInterval: scrollInterval, target: self, selector: #selector(authenticate), userInfo: nil, repeats: true)
    }

}

 
