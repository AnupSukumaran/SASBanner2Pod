//
//  PageSlideViewController.swift
//  Pods-SASBanner_Example
//
//  Created by Manu Puthoor on 15/09/20.
//

import UIKit

public protocol SASPageSlideViewControllerDelegate: class {
    func timer(started: Bool)
    
}

public class SASPageSlideViewController: UIPageViewController {

   var images = [UIImage]()
   var imageContentFit: UIImageView.ContentMode = .scaleAspectFit
   var currentIndex = 0
   var itemIndex = 0
   weak public var pageDelegate: SASPageSlideViewControllerDelegate?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        delegate = self
        if let startingViewController = contentViewController(at: itemIndex) {
            setViewControllers([startingViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
         pageDelegate?.timer(started: true)
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        pageDelegate?.timer(started: false)
    }
    
    func contentViewController(at index: Int) -> SASImageViewController? {
        
        if index < 0 || index >= images.count {
            return callImageViewController(imgIndex: 0)
        }
        
        return callImageViewController(imgIndex: index)
        
    }
    
    func callImageViewController(imgIndex: Int) -> SASImageViewController? {
        let bundle = Bundle(for: type(of: self))
        let vc = SASImageViewController(nibName: "SASImageViewController", bundle: bundle)
        guard !images.isEmpty else {return nil}
        vc.imageData = images[imgIndex]
        vc.index = imgIndex
        vc.imageContentFit = imageContentFit
        return vc
    }
    
    public func forwardPage() {
    
        guard  currentIndex < (images.count - 1) else {
            currentIndex = 0
            if let nextViewController = contentViewController(at: 0) {
                setViewControllers([nextViewController], direction: .forward, animated: true, completion: nil)
            }
            return
        }
        currentIndex += 1
        if let nextViewController = contentViewController(at: currentIndex) {
            setViewControllers([nextViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    
    public func backwardPage() {
        guard  currentIndex > 0 else {
            currentIndex = images.count - 1
            if let nextViewController = contentViewController(at: currentIndex) {
               setViewControllers([nextViewController], direction: .reverse, animated: true, completion: nil)
            }
            return
        }
        currentIndex -= 1
        if let nextViewController = contentViewController(at: currentIndex) {
            setViewControllers([nextViewController], direction: .reverse, animated: true, completion: nil)
        }
    }

    
}


extension SASPageSlideViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! SASImageViewController).index
        if index > 0 {
            index -= 1
            return contentViewController(at: index)
        } else {
            return contentViewController(at: images.count - 1)
        }
    
    }
    
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! SASImageViewController).index
        index += 1
        
        return contentViewController(at: index)
    }
    
    public func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        if completed {
            if let contentViewController = pageViewController.viewControllers?.first as? SASImageViewController {
                currentIndex = contentViewController.index
                let timeInterval = (pageDelegate as? SASScrollViewBlock)?.scrollInterval ?? 2
                perform(#selector(dealyedAction), with: nil, afterDelay: timeInterval)
                pageDelegate?.timer(started: false)
            }
        }
        
    }
    
    @objc func dealyedAction() {
        pageDelegate?.timer(started: true)
    }
    
    
}
