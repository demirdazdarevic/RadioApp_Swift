//
// SampleMenuViewController.swift
//
// Copyright 2017 Handsome LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

import UIKit
import InteractiveSideMenu

/**
 Menu controller is responsible for creating its content and showing/hiding menu using 'menuContainerViewController' property.
 */
class SampleMenuViewController: MenuViewController, Storyboardable {

    @IBOutlet fileprivate weak var tableView: UITableView!
    @IBOutlet fileprivate weak var avatarImageView: UIImageView!
    @IBOutlet fileprivate weak var lbl: UILabel!
    @IBOutlet fileprivate weak var avatarImageViewCenterXConstraint: NSLayoutConstraint!
    private var gradientLayer = CAGradientLayer()
    @IBOutlet fileprivate weak var nazad:UIButton!
    @IBOutlet fileprivate weak var btn1:UIButton!
    @IBOutlet fileprivate weak var pevac:UILabel!
    @IBOutlet fileprivate weak var pesma:UILabel!
    
    

    private var gradientApplied: Bool = false

    override var prefersStatusBarHidden: Bool {
        return false
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewWillAppear(_ animated: Bool) {
        let preferences = UserDefaults.standard
        pevac.text = preferences.string(forKey: "pevac")
        pesma.text = preferences.string(forKey: "pesma")
        super.viewWillAppear(true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //view.bringSubviewToFront(pevac)
//view.bringSubviewToFront(pesma)
        // Select the initial row
        tableView.selectRow(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: UITableView.ScrollPosition.none)

        //avatarImageView.layer.cornerRadius = avatarImageView.frame.size.width/2
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        //avatarImageViewCenterXConstraint.constant = -(menuContainerViewController?.transitionOptions.visibleContentWidth ?? 0.0)/2

        if gradientLayer.superlayer != nil {
            gradientLayer.removeFromSuperlayer()
        }
        let topColor = UIColor(red: 232.0/255.0, green: 122.0/255.0, blue: 71.0/255.0, alpha: 1.0)
        let bottomColor = UIColor(red: 232.0/255.0, green: 122.0/255.0, blue: 71.0/255.0, alpha: 1.0)
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        gradientLayer.frame = view.bounds
        view.layer.insertSublayer(gradientLayer, at: 0)
        
    }
    @IBAction func close(_ sender: Any) {
        guard let menuContainerViewController = self.menuContainerViewController else {
            return
        }

        
        menuContainerViewController.hideSideMenu()
        //hideSideMenu()
                    }
    deinit{
        print()
    }
}

extension SampleMenuViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuContainerViewController?.contentViewControllers.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.row == 0) {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String("SampleTableCell"), for: indexPath) as? SampleTableCell else {
            preconditionFailure("Unregistered table view cell")
        }
        
        cell.titleLabel.text = menuContainerViewController?.contentViewControllers[indexPath.row].title ?? "Početna"

            return cell }
        else if (indexPath.row == 1) {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String("SampleTableCell2"), for: indexPath) as? SampleTableCell else {
                preconditionFailure("Unregistered table view cell")
            }
            
            cell.titleLabel.text = menuContainerViewController?.contentViewControllers[indexPath.row].title ?? "Sve radio stanice"

                return cell
            
        }
        else if (indexPath.row == 2) {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String("SampleTableCell3"), for: indexPath) as? SampleTableCell else {
                preconditionFailure("Unregistered table view cell")
            }
            
            cell.titleLabel.text = menuContainerViewController?.contentViewControllers[indexPath.row].title ?? "Moje omiljene"

                return cell
            
        }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String("SampleTableCell3"), for: indexPath) as? SampleTableCell else {
            preconditionFailure("Unregistered table view cell") }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let menuContainerViewController = self.menuContainerViewController else {
            return
        }

        menuContainerViewController.selectContentViewController(menuContainerViewController.contentViewControllers[indexPath.row])
        menuContainerViewController.hideSideMenu()
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let v = UIView()
        v.backgroundColor = UIColor.clear
        return v
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.5
    }
}
