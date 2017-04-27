//
//  RearrangeScheduleVC.swift
//  travelToMySelfLayOut
//
//  Created by 倪僑德 on 2017/4/26.
//  Copyright © 2017年 Chiao. All rights reserved.
//

import UIKit

class RearrangeScheduleVC: UIViewController, UIGestureRecognizerDelegate {
    
    //----------testArea--------v
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        
        var testA = DateCellContent(dateValue: 1)
        var testB = ScheduleAndTrafficCellContent(nameOfViewPoint: <#String#>, transportationMode: <#String#>, trafficTime: <#String#>)
        cellContentArray.append(testA)
        cellContentArray.append(testB)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //----------testArea--------^
    
    
    
    var cellContentArray = [CellContent]()
    @IBOutlet weak var travelPathWebView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func finishAndNextPage(_ sender: UIBarButtonItem) {
        //先將Array照天數切開
        //再將每天的內容帶入輸出中
        //最後將資料輸出
    }
    
    private func seperateArrayByDate (intputArray:[CellContent]) -> (remainingOfInputArray:[CellContent], oneDayScheduleArray:[ScheduleAndTrafficCellContent])! {
        //....
        return nil
    }

    
    
}

extension RearrangeScheduleVC : UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellContentArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //Check the cell is for prsenting Date or viewPoint and traffic information, then built it.
        switch cellContentArray[indexPath.item].type! {
            
        //for presenting Date
        case .dateCellType:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DateCell", for: indexPath) as! DateCell
            // if is the 1st day cell, show the adding days button
            if indexPath.item == 0{
                cell.addNewTripDayButton.isHidden = false
            }
            // setting the label text
            let cellContent = cellContentArray[indexPath.item] as! DateCellContent
            cell.dateLabel.text = cellContent.dateStringForLabel
            return cell
            
        //for presenting viewPoint and traffic information
        case .scheduleAndTrafficCellType:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "scheduleAndTrafficCell", for: indexPath) as! ScheduleAndTrafficCell
            // setting the label text
            let cellContent = cellContentArray[indexPath.item] as! ScheduleAndTrafficCellContent
            cell.viewPointName.text = cellContent.viewPointName
            cell.trafficInf.text = "\(cellContent.transportationMode), \(cellContent.trafficTime)"
            if let viewPointDetail = cellContent.viewPointInformation {
                cell.viewPointDetail.text = viewPointDetail
            }
            return cell
        
        //CellType unknown or Type wrong
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DateCell", for: indexPath)
            return cell
        }
    }
    
}
