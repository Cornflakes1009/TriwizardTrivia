import UIKit
import GoogleMobileAds

class ResultsTableViewCell: UITableViewCell {
    @IBOutlet var trophyImage: UIImageView?
    @IBOutlet var houseLabel: UILabel?
    
}

class ResultsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var resultsTableView: UITableView!
    @IBOutlet var restartButton: UIButton!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teams.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = resultsTableView.dequeueReusableCell(withIdentifier: "cell") as! ResultsTableViewCell
        
        cell.houseLabel?.text = String(indexPath.row + 1) + ". "  + teams[indexPath.row].name
        cell.houseLabel?.textColor = #colorLiteral(red: 0.9215686275, green: 0.7529411765, blue: 0.2588235294, alpha: 1)
        cell.houseLabel?.adjustsFontSizeToFitWidth = true
        cell.houseLabel?.sizeToFit()
        
        if(indexPath.row == 0) {
            cell.trophyImage?.image = UIImage(systemName: "rosette")
        }
        
        if(teams[indexPath.row].score == teams[0].score) {
            cell.trophyImage?.image = UIImage(systemName: "rosette")
        }

        // making the tableview have a clear background
        cell.layer.backgroundColor = UIColor.clear.cgColor
        cell.backgroundColor = .clear
        resultsTableView.layer.backgroundColor = UIColor.clear.cgColor
        resultsTableView.backgroundColor = .clear
        return cell
    }

    @IBOutlet weak var bannerView: GADBannerView!
    
    // clearing out the game and sending back to home screen
    @IBAction func restartTapped(_ sender: Any) {
        questionList.removeAll()
        teams.removeAll()
        currentTeam = 0
        questionIndex = 0
        questionList.removeAll()
        
        
        let vc = self.storyboard?.instantiateViewController(identifier: "PickTeamsStoryboard") as! ViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        restartButton.layer.shadowColor = UIColor.black.cgColor
        restartButton.layer.shadowOffset = CGSize(width: 5, height: 5)
        restartButton.layer.shadowRadius = 5
        restartButton.layer.shadowOpacity = 1.0

        // starting ads on the bannerview
        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        
        // removing white space at end of table view
        self.resultsTableView.tableFooterView = UIView()
        
        // sorting teams by score
        teams = teams.sorted(by: {$0.score > $1.score})
    }
}
