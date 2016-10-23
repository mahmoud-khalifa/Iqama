//
//  IqamaViewController.swift
//  Iqama
//
//  Created by Mahmoud Adam on 10/22/16.
//  Copyright © 2016 lognlabs. All rights reserved.
//

import UIKit
import MaterialControls
import SnapKit
import MaterialActionSheetController

class IqamaViewController: UIViewController {
    let prayTable = UITableView()
    let supportButton = MDButton()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        setupConstraints()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    //MARK: - Private Helper methods
    
    //MARK: drawing the view
    
    private func configureView() {
        
        // supportButton
        supportButton.setTitle("SUPPORT THE ICB", forState: .Normal)
        supportButton.backgroundColor = Constants.themeColor
        supportButton.rippleColor = UIColor.whiteColor()
        supportButton.addTarget(self, action: #selector(showSupportOptions), forControlEvents: .TouchUpInside)
        self.view.addSubview(supportButton)
    }
    
    private func setupConstraints() {
        supportButton.snp_makeConstraints { make in
            make.height.equalTo(50)
            make.left.right.bottom.equalTo(self.view)
        }
    }
    
    //MARK handling actions
    
    @objc private func showSupportOptions() {

        var supportActions = [MaterialAction]()
        for (title, id) in Constants.supportOptions {
            let supportAction = MaterialAction(icon: nil, title: title, handler: {(accessoryView) in
                if let supportUrl = NSURL(string:"https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=\(id)") {
                    UIApplication.sharedApplication().openURL(supportUrl)
                }
            })
            supportActions.append(supportAction)
        }
        let supportMenu = MaterialActionSheetController(title: "", message: "Support the ICB", actionSections: supportActions)
        supportMenu.theme = MaterialActionSheetTheme.dark()

        self.presentViewController(supportMenu, animated: true, completion: nil)
        
        /*
        // regualr action sheet
        let supportMenu = UIAlertController(title: "", message: "Support the ICB", preferredStyle: .ActionSheet)
        for (title, id) in Constants.supportOptions {
            let supportAction = UIAlertAction(title: title, style: .Default) {
                (action: UIAlertAction) in
                if let supportUrl = NSURL(string:"https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=\(id)") {
                    UIApplication.sharedApplication().openURL(supportUrl)
                }
            }
            supportMenu.addAction(supportAction)
        }
        
        self.presentViewController(supportMenu, animated: true, completion: nil)
        */
    }
}

