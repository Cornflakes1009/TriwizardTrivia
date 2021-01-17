import UIKit
import GoogleMobileAds
import AVFoundation

class ResultsTableViewCell: UITableViewCell {
    @IBOutlet var trophyImage: UIImageView?
    @IBOutlet var houseLabel: UILabel?
}

class ResultsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var player: AVPlayer?
    
    @IBOutlet weak var resultsTableView: UITableView!
    @IBOutlet var restartButton: UIButton!
    @IBOutlet var headlineLabel: UILabel!
    @IBOutlet var restartButtonHeight: NSLayoutConstraint!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teams.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = resultsTableView.dequeueReusableCell(withIdentifier: "cell") as! ResultsTableViewCell
        
        let score = teams[indexPath.row].score
        let pts: String
        if(score == 1) {
            pts = "pt. "
        } else {
            pts = "pts. "
        }
        
        cell.houseLabel?.text = String(score) + pts  + teams[indexPath.row].name
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
        resetGame()
        vibrate()
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    // MARK:- Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playBackgroundVideo()
        restartButton.layer.shadowColor = UIColor.black.cgColor
        restartButton.layer.shadowOffset = CGSize(width: 5, height: 5)
        restartButton.layer.shadowRadius = 5
        restartButton.layer.shadowOpacity = 1.0
        
        // starting ads on the bannerview
        bannerView.adUnitID = prodAdMobsKey
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        
        // removing white space at end of table view
        self.resultsTableView.tableFooterView = UIView()
        
        // sorting teams by score
        teams = teams.sorted(by: {$0.score > $1.score})
        
        headlineLabel.textAlignment = .center
        headlineLabel.layer.shadowColor = UIColor.black.cgColor
        headlineLabel.layer.shadowRadius = 3.0
        headlineLabel.layer.shadowOpacity = 1.0
        headlineLabel.layer.shadowOffset = CGSize(width: 4, height: 4)
        headlineLabel.layer.masksToBounds = false
        
        // if iPhone SE, adjust the UI to fit
        let screenHeight = UIScreen.main.bounds.size.height
        if(screenHeight < 569) {
            headlineLabel.font = headlineLabel.font.withSize(34)
            restartButtonHeight.constant = 60
        }
    }
    
    // MARK: - Background Video
    func playBackgroundVideo() {
        let path = Bundle.main.path(forResource: "smoke1", ofType: ".mp4")
        player = AVPlayer(url: URL(fileURLWithPath: path!))
        player!.actionAtItemEnd = AVPlayer.ActionAtItemEnd.none
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = self.view.frame
        playerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        self.view.layer.insertSublayer(playerLayer, at: 0)
        NotificationCenter.default.addObserver(self, selector: #selector(playerItemDidReachEnd), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: player!.currentItem)
        player!.seek(to: CMTime.zero)
        player!.play()
        self.player?.isMuted = true
    }
    
    @objc func playerItemDidReachEnd() {
        player!.seek(to: CMTime.zero)
    }
}
