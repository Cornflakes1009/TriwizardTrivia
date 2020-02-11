//
//  RulesAndCreditsViewController.swift
//  Canvas
//
//  Created by HaroldDavidson on 2/9/20.
//

import UIKit

class RulesAndCreditsViewController: UIViewController {
    
    @IBOutlet var viewContainer: UIView!
    var views: [UIView]!
    
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
        let vc = self.storyboard?.instantiateViewController(identifier: "PickTeamsStoryboard") as! ViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
