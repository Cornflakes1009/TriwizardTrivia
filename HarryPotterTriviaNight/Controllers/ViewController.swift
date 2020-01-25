import UIKit
import GoogleMobileAds

class ViewController: UIViewController {

    @IBOutlet var teamButtons: [UIButton]!
    @IBOutlet weak var bannerView: GADBannerView!
    @IBOutlet weak var headlineLabel: UILabel!
    @IBOutlet weak var directionsLabel: UILabel!
    @IBOutlet weak var beginButton: UIButton!
    
    var gryffindorButtonSelected = false
    var hufflepuffButtonSelected = false
    var ravenclawButtonSelected = false
    var slytherinButtonSelected = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for button in teamButtons {
            // adjusting text position
            
            button.titleEdgeInsets = UIEdgeInsets.init(top: 7, left: 0, bottom: 0, right: 0)
            // adjusting text size
            button.titleLabel?.adjustsFontSizeToFitWidth = true
            
            // adding shadow
            button.layer.shadowColor = UIColor.black.cgColor
            button.layer.shadowOffset = CGSize(width: 5, height: 5)
            button.layer.shadowRadius = 5
            button.layer.shadowOpacity = 1.0
        }
        
        // adjusting font to fit
        //headlineLabel.adjustsFontSizeToFitWidth = true
        directionsLabel.adjustsFontSizeToFitWidth = true
        
        // starting ads on the bannerview
//        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
//        bannerView.rootViewController = self
//        bannerView.load(GADRequest())
        
        //beginButton.isHidden = true
        beginButton.isEnabled = false
    }

    @IBAction func houseButtonTapped(_ sender: UIButton, forEvent event: UIEvent) {
        switch sender.tag {
        case 1:
            if(gryffindorButtonSelected) {
                gryffindorButtonSelected = false
                sender.setTitleColor(#colorLiteral(red: 0.9215686275, green: 0.7529411765, blue: 0.2588235294, alpha: 1), for: .normal)
                sender.backgroundColor = #colorLiteral(red: 0.4901960784, green: 0.09803921569, blue: 0.08235294118, alpha: 1)
                for (index, team) in teams.enumerated() {
                    if(team.name == "Gryffindor") {
                        teams.remove(at: index)
                    }
                }
            } else {
                gryffindorButtonSelected = true
                setColors(button: sender)
                let teamGryffindor = Team(name: "Gryffindor")
                teams.append(teamGryffindor)
            }
        case 2:
            if(hufflepuffButtonSelected) {
                hufflepuffButtonSelected = false
                sender.setTitleColor(#colorLiteral(red: 0.07843137255, green: 0.07843137255, blue: 0.1333333333, alpha: 1), for: .normal)
                sender.backgroundColor = #colorLiteral(red: 0.9333333333, green: 0.7137254902, blue: 0.2705882353, alpha: 1)
                for (index, team) in teams.enumerated() {
                    if(team.name == "Hufflepuff") {
                        teams.remove(at: index)
                    }
                }
            } else {
                hufflepuffButtonSelected = true
                setColors(button: sender)
                let teamHufflepuff = Team(name: "Hufflepuff")
                teams.append(teamHufflepuff)
            }
        case 3:
            if(ravenclawButtonSelected) {
                ravenclawButtonSelected = false
                sender.setTitleColor(#colorLiteral(red: 0.7803921569, green: 0.7803921569, blue: 0.8156862745, alpha: 1), for: .normal)
                sender.backgroundColor = #colorLiteral(red: 0.1019607843, green: 0.1058823529, blue: 0.2980392157, alpha: 1)
                for (index, team) in teams.enumerated() {
                    if(team.name == "Ravenclaw") {
                        teams.remove(at: index)
                    }
                }
            } else {
                ravenclawButtonSelected = true
                setColors(button: sender)
                let teamRavenclaw = Team(name: "Ravenclaw")
                teams.append(teamRavenclaw)
            }
        case 4:
            if(slytherinButtonSelected) {
                slytherinButtonSelected = false
                sender.setTitleColor(#colorLiteral(red: 0.7294117647, green: 0.7254901961, blue: 0.7647058824, alpha: 1), for: .normal)
                sender.backgroundColor = #colorLiteral(red: 0.2117647059, green: 0.462745098, blue: 0.2941176471, alpha: 1)
                for (index, team) in teams.enumerated() {
                    if(team.name == "Slytherin") {
                        teams.remove(at: index)
                    }
                }
            } else {
                slytherinButtonSelected = true
                setColors(button: sender)
                let teamSlytherin = Team(name: "Slytherin")
                teams.append(teamSlytherin)
            }
            
        default:
            break
            
        }

        
        
        if(teams.count > 1) {
            //beginButton.isHidden = false
            beginButton.isEnabled = true
        } else {
            //beginButton.isHidden = true
            beginButton.isEnabled = false        }
    }
    

    @IBAction func beginButtonSegue(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(identifier: "QuestionStoryboard") as! QuestionViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func setColors(button: UIButton) {
        button.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        button.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
    }
}
