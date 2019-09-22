import UIKit
import GoogleMobileAds

class ResultsViewController: UIViewController {

    @IBOutlet weak var bannerView: GADBannerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // starting ads on the bannerview
        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
    }
    
    // added to prevent the segue added from partial curl
    override func viewDidAppear(_ animated: Bool) {
        self.view.gestureRecognizers?.removeAll()
    }
}
