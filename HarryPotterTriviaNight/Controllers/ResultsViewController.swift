import UIKit
import GoogleMobileAds

class ResultsTableViewCell: UITableViewCell {
    @IBOutlet var trophyImage: UIImageView?
    @IBOutlet var houseLabel: UILabel?
    
}

class ResultsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var resultsTableView: UITableView!
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teams.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = resultsTableView.dequeueReusableCell(withIdentifier: "cell") as! ResultsTableViewCell
        
        cell.houseLabel?.text = String(indexPath.row + 1) + ". "  + teams[indexPath.row].name
        cell.houseLabel?.textColor = #colorLiteral(red: 0.7803921569, green: 0.7803921569, blue: 0.8156862745, alpha: 1)
        cell.houseLabel?.adjustsFontSizeToFitWidth = true
        cell.houseLabel?.sizeToFit()
        
        if(indexPath.row == 0) {
            cell.trophyImage?.image = UIImage(named: "trophy")
        } else {
            
        }

        // making the tableview have a clear background
        cell.layer.backgroundColor = UIColor.clear.cgColor
        cell.backgroundColor = .clear
        resultsTableView.layer.backgroundColor = UIColor.clear.cgColor
        resultsTableView.backgroundColor = .clear
        return cell
    }

    @IBOutlet weak var bannerView: GADBannerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // starting ads on the bannerview
        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        
        // removing white space at end of table view
        self.resultsTableView.tableFooterView = UIView()
        
        // sorting teams
        teams = teams.sorted(by: {$0.score > $1.score})
    }
    
    // added to prevent the segue added from partial curl
    override func viewDidAppear(_ animated: Bool) {
    self.view.gestureRecognizers?.removeAll()
    }
}
