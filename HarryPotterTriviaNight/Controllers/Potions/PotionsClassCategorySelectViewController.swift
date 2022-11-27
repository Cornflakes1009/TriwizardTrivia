//
//  PotionsClassCategorySelectViewController.swift
//  HarryPotterTriviaNight
//
//  Created by HaroldDavidson on 3/22/22.
//  Copyright © 2022 HaroldDavidson. All rights reserved.
//

import UIKit
import AVFoundation
import GoogleMobileAds

class PotionsClassCategorySelectViewController: UIViewController {
    private let categories = ["Characters", "Spells", "Locations", "Death Eaters", "Order Members", "Potions", "Magical Beasts"]
    var player: AVPlayer?
    
    private let backgroundImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "clouds")
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    private let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.isEnabled = true
        button.tintColor = backButtonColor
        button.setTitleColor(whiteColor, for: .normal)
        button.addTarget(nil, action: #selector(backTapped), for: .touchUpInside)
        return button
    }()
    
    private let instructionLabel: UILabel = {
        let label = UILabel()
        label.text = "Select a Category"
        label.font = instructionLabelFont
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    private let tableView = UITableView()
    
    private let bannerView: GADBannerView = {
        let bannerView = GADBannerView()
        return bannerView
    }()
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        configureTableView()
        
        let notificationCenter = NotificationCenter.default
            notificationCenter.addObserver(self, selector: #selector(appMovedToBackground), name: UIApplication.willResignActiveNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(appMovedToForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    @objc func appMovedToBackground() {
        player?.pause()
    }
    
    @objc func appMovedToForeground() {
        player?.play()
    }
    
    // MARK: - Setting Up the Views
    private func setupViews() {
        playBackgroundVideo()
        
        backButton.setImage(backButtonImage, for: .normal)
        view.addSubview(backButton)
        backButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 5, paddingLeft: 5, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        view.addSubview(instructionLabel)
        instructionLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 20, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: 0)
        
        setupBannerView()
        
        view.addSubview(bannerView)
        bannerView.anchor(top: nil, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
        
        view.addSubview(tableView)
        tableView.anchor(top: instructionLabel.bottomAnchor, left: view.leftAnchor, bottom: bannerView.topAnchor, right: view.rightAnchor, paddingTop: 20, paddingLeft: 0, paddingBottom: -20, paddingRight: 0, width: 0, height: 0)
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
    
    private func setupBannerView() {
        // starting ads on the bannerview
        bannerView.adUnitID = prodAdMobsKey
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
    }
    
    // MARK: - Button Functions
    @objc func backTapped() {
        self.navigationController?.popViewController(animated: true)
        vibrate()
    }
}

extension PotionsClassCategorySelectViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HangmanCell") as! HangmanCell
        
        cell.categoryLabel.text = categories[indexPath.row]
        cell.categoryLabel.font = buttonFont
        cell.backgroundColor = .clear
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        vibrate()
        convertHangmanonJSON(jsonToRead: "\(categories[indexPath.row])")
        let vc = PotionsClassViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = true
        tableView.separatorStyle = .none
        tableView.rowHeight = buttonHeight + 20
        tableView.isUserInteractionEnabled = true
        tableView.register(HangmanCell.self, forCellReuseIdentifier: "HangmanCell")
        tableView.backgroundColor = .none
    }
}
