//
//  SideCabinetViewController.swift
//  Platt
//
//  Created by Jaden Nation on 4/22/19.
//  Copyright © 2019 Designer Jeans. All rights reserved.
//

import UIKit

enum SideCabinetPosition {
    case offscreen, partiallyOnscreen(percentOnscreen: CGFloat), fullscreen
}

enum SideCabinetOption: String {
    case about, close, contact
}

extension Notification.Name {
    static let openingSideCabinetController = Notification.Name("openingSideCabinetController")
    static let openedSideCabinetController = Notification.Name("openedSideCabinetController")
    static let closedSideCabinetController = Notification.Name("closedSideCabinetController")
}

class PairedLabelContainer: ModernView {
    let titleLabel = UILabel()
    let bodyLabel = UILabel()
    
    func loadData(title: String?, body: String?) {
        let shouldHide = title == nil && body == nil
        layer.opacity = shouldHide ? 0 : 1
        titleLabel.text = title
        bodyLabel.text = body
    }
    
    override func setup() {
        for label in [titleLabel, bodyLabel] {
            addSubview(label)
            label.textAlignment = .center
            label.adjustsFontSizeToFitWidth = true
            label.textColor = .white
        }
        layoutMargins = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        titleLabel.font = UIFont.sfProTextBold(size: 40)
        bodyLabel.font = UIFont.sfProTextRegular(size: 26)
        bodyLabel.numberOfLines = 0
    }
    
    override func addConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        bodyLabel.translatesAutoresizingMaskIntoConstraints = false
        addConstraints([
            titleLabel.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            bodyLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            bodyLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            bodyLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            bodyLabel.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor),
            ])
    }
}

class SideCabinetController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var cabinetPosition: SideCabinetPosition = .offscreen
    private let tableView = UITableView()
    private var data = [SideCabinetOption]()
    public weak var delegate: HostsSideCabinet?
    private var lastSwipeX: CGFloat = 0
    private var panGestureRecognizer: UIPanGestureRecognizer?
    let pairedLabelContainer = PairedLabelContainer()
    
    private var fakeBgroundView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fakeBgroundView.translatesAutoresizingMaskIntoConstraints = false
        fakeBgroundView.backgroundColor = .spotifyGreen()
        
        view.layoutMargins = UIEdgeInsets(top: 32, left: 16, bottom: 0, right: 0)
        
        data = [.about, .contact, .close]
        
        view.addSubview(fakeBgroundView)
        view.addSubview(tableView)
        view.addSubview(pairedLabelContainer)
        pairedLabelContainer.translatesAutoresizingMaskIntoConstraints = false
        pairedLabelContainer.alpha = 0
        
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.isScrollEnabled = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(SideCabinetOptionCell.self, forCellReuseIdentifier: "OptionCell")
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(didSwipe(sender:)))
        view.addGestureRecognizer(panGestureRecognizer!)
        
        view.addConstraints([
            fakeBgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            fakeBgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            fakeBgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            fakeBgroundView.widthAnchor.constraint(equalTo: view.widthAnchor),
            tableView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.heightAnchor.constraint(equalTo: view.layoutMarginsGuide.heightAnchor, multiplier: 0.5),
            pairedLabelContainer.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            pairedLabelContainer.topAnchor.constraint(equalTo: tableView.bottomAnchor),
            pairedLabelContainer.widthAnchor.constraint(lessThanOrEqualTo: view.layoutMarginsGuide.widthAnchor),
            ])
    }
    
    func tableView(_ tableView: UITableView, canFocusRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OptionCell", for: indexPath) as! SideCabinetOptionCell
        cell.loadData(optionData: data[indexPath.section], position: indexPath.section)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.tappedOption(optionValue: data[indexPath.section].rawValue)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 16
    }
    
    @objc private func didSwipe(sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .began:
            lastSwipeX = sender.location(in: view).x
        case .changed:
            let newLocation = sender.location(in: view).x
            if abs(lastSwipeX - newLocation) > ((view.frame.width - lastSwipeX ) / 2) && newLocation > lastSwipeX {
                delegate?.animateCabinetPosition(position: .offscreen)
                view.removeGestureRecognizer(panGestureRecognizer!)
            }
        case .ended: break
        default: break
            
        }
    }
    
    
}
