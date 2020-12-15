//
//  RulesAndCreditsViewController.swift
//  Canvas
//
//  Created by HaroldDavidson on 2/9/20.
//

import UIKit


// MARK:- This file isn't in use
// MARK:-

class RulesAndCreditsViewController: UIViewController {
    
    @IBOutlet var viewContainer: UIView!
    var views: [UIView]!
    @IBOutlet var backButton: UIButton!
    
    @IBAction func segmentedControl(_ sender: UISegmentedControl) {
        //self.viewContainer.bringSubviewToFront(views[sender.selectedSegmentIndex])
        // switching on which view is selected and setting other to be hidden - this needs to happen because I have a clear background on both xibs.
        switch sender.selectedSegmentIndex {
        case 0:
            views[1].isHidden = true
            views[0].isHidden = false
            break
        case 1:
            views[1].isHidden = false
            views[0].isHidden = true
            break
        default:
            break
        }
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backButton.tintColor = .white
        
        // initializing and adding the views
        views = [UIView]()
        views.append(RulesViewController().view)
        views.append(CreditsViewController().view)
        
        for view in views {
            viewContainer.addSubview(view)
        }
        
        // setting inital status of the views
        viewContainer.bringSubviewToFront(views[0])
        views[1].isHidden = true
    }
}
