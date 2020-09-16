//
//  ViewController.swift
//  SASBanner2
//
//  Created by AnupSukumaran on 09/16/2020.
//  Copyright (c) 2020 AnupSukumaran. All rights reserved.
//

import UIKit
import SASBanner2

class ViewController: UIViewController {

    @IBOutlet weak var bannerView: ScrollViewBlock!
    
    var dummyImgs = [UIImage(named: "1"),UIImage(named: "2"),UIImage(named: "3")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bannerView.congifBanner(images: dummyImgs, baseVC: self, imageFit: .scaleAspectFill, scrollInterval: 3)
    }

    @IBAction func btnAction() {
        bannerView.stopAutoScroll()
        bannerView.pageVC.forwardPage()
    }
    
    @IBAction func btnAction2() {
        bannerView.startAutoScroll()
        bannerView.pageVC.backwardPage()
    }
    

    @IBAction func callVCAction() {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
}

