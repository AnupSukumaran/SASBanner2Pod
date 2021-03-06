//
//  ScrollViewBlock+Ext.swift
//  SASPager
//
//  Created by Manu Puthoor on 17/02/20.
//  Copyright © 2020 Manu Puthoor. All rights reserved.
//

import UIKit
import WebKit

extension SASScrollViewBlock: UIScrollViewDelegate {
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        actionAfterScrolling(scrollView, pageControl: pgControl, view: self)
    }
    
    func loadViewFromNib(_ bgColor: UIColor = .white) -> UIView? {

        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "SASScrollViewBlock", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.backgroundColor = bgColor
        return view
    }

    func xibSetup(bgColor: UIColor = .white) {
        
        guard let view = loadViewFromNib(bgColor) else {return }
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
        contentView = view
        
    }
    
    func settingPageViewController(baseVC: UIViewController, imageContentFit: UIImageView.ContentMode) {
       
        let bundle = Bundle(for: type(of: self))
        var pageVC = SASPageSlideViewController(nibName: "SASPageSlideViewController", bundle: bundle)
        
        pageVC = SASPageSlideViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        
        if let imgs = images {
            pageVC.images = imgs.compactMap{$0}
        }
        pageVC.pageDelegate = self
        pageVC.imageContentFit = imageContentFit
        pgControl.isHidden = false
        baseVC.view.bringSubviewToFront(pgControl)

        baseVC.addChild(pageVC)//addChildViewController(pageVC)
        pageVC.view.frame = bounds
        contentView!.addSubview(pageVC.view)
        pageVC.didMove(toParent: baseVC)
        
        self.pageVC = pageVC
    }
    
    func pageControlSetup() {
        pgControl.numberOfPages = images?.count ?? 0
        pgControl.currentPage = 0
    }

    func pageControlSetupForViews(views: [UIView]) {
        pgControl.numberOfPages = views.count
        pgControl.currentPage = 0
        bringSubviewToFront(pgControl)
    }

    func actionAfterScrolling(_ scrollView: UIScrollView, pageControl: UIPageControl, view: UIView) {
        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
        pageControl.currentPage = Int(pageIndex)
    }
    
}

extension SASScrollViewBlock: SASPageSlideViewControllerDelegate {
    public func timer(started: Bool) {
        if started {
            startAutoScroll()
        } else {
            stopAutoScroll()
        }
    }
    
    
}
