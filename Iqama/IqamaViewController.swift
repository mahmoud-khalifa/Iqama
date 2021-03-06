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
import CVCalendar

class IqamaViewController: UIViewController {
    var menuView = CVCalendarMenuView()
    var calendarView = CVCalendarView()
    
    var selectedDay:DayView!
    let selectedDateLabel = UILabel()
    
    let RowIdentifier = "PrayTimesCell"
    let prayTimesTable = UITableView()
    
    let supportButton = MDButton()
    
    var prays: [Pray]?
    let praysController = PraysController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        setupConstraints()
        refreshPrays(NSDate())

    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Commit frames' updates
        menuView.commitMenuViewUpdate()
        calendarView.commitCalendarViewUpdate()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    //MARK: - Private Helper methods
    private func configureView() {
        // Calendar view
        menuView.menuViewDelegate = self
        calendarView.calendarDelegate = self
        
        self.view.addSubview(menuView)
        self.view.addSubview(calendarView)
        
        // Selected Date Label
        selectedDateLabel.textAlignment = .Center
        selectedDateLabel.text = CVDate(date: NSDate()).commonDescription
        self.view.addSubview(selectedDateLabel)
        
        // PrayTimes tableView
        prayTimesTable.dataSource = self
        prayTimesTable.delegate = self
        prayTimesTable.registerClass(IqamaTableViewCell.self, forCellReuseIdentifier: RowIdentifier)
        self.view.addSubview(prayTimesTable)
        
        // supportButton
        supportButton.setTitle("SUPPORT THE ICB", forState: .Normal)
        supportButton.backgroundColor = Constants.themeColor
        supportButton.rippleColor = UIColor.whiteColor()
        supportButton.addTarget(self, action: #selector(showSupportOptions), forControlEvents: .TouchUpInside)
        
        self.view.addSubview(supportButton)
    }
    
    private func setupConstraints() {
        menuView.snp_makeConstraints { make in
            make.left.right.equalTo(self.view)
            make.height.equalTo(24)
            
            if let offset = self.navigationController?.navigationBar.frame.height {
                make.top.equalTo(self.topLayoutGuide).offset(offset+20)
            } else {
                make.top.equalTo(self.topLayoutGuide)
                
            }
        }
        
        calendarView.snp_makeConstraints { make in
            make.left.right.equalTo(self.view)
            make.top.equalTo(menuView.snp_bottom)
            make.height.equalTo(50)
        }

        selectedDateLabel.snp_makeConstraints { make in
            make.top.equalTo(calendarView.snp_bottom)
            make.centerX.equalTo(calendarView)
            make.height.equalTo(21)
            make.width.equalTo(self.view)
        }
        
        prayTimesTable.snp_makeConstraints { make in
            make.top.equalTo(selectedDateLabel.snp_bottom)
            make.width.equalTo(self.view)
            make.bottom.equalTo(supportButton.snp_top)
        }
        
        supportButton.snp_makeConstraints { make in
            make.left.right.equalTo(self.view)
            make.bottom.equalTo(self.bottomLayoutGuide)
            make.height.equalTo(50)
        }
        
    }
    private func refreshPrays(date: NSDate) {
        prays = praysController.getPrays(date)
        prayTimesTable.reloadData()
    }
    //MARK handling actions
    
    @objc private func showSupportOptions() {
/*
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
        
        */
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
        supportMenu.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        
        self.presentViewController(supportMenu, animated: true, completion: nil)
 
    }
}


// MARK: - CVCalendarViewDelegate & CVCalendarMenuViewDelegate

extension IqamaViewController: CVCalendarViewDelegate, CVCalendarMenuViewDelegate {
    
    /// Required method to implement!
    func presentationMode() -> CalendarMode {
        return .WeekView
    }
    
    /// Required method to implement!
    func firstWeekday() -> Weekday {
        return .Sunday
    }
    
    
    // MARK: Optional methods
    
    func shouldShowWeekdaysOut() -> Bool {
        return true
    }
    
    func didSelectDayView(dayView: CVCalendarDayView, animationDidFinish: Bool) {
        selectedDay = dayView
        selectedDateLabel.text = dayView.date.commonDescription
        refreshPrays(dayView.date.convertedDate()!)
    }
    
}

// MARK: - UITableViewDataSource & UITableViewDelegate

extension IqamaViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Constants.prayCount
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(RowIdentifier) as! IqamaTableViewCell
        if let prays = self.prays {
            cell.updateView(prays[indexPath.row])
        }
        
        return cell
    }
    
    
    
}

