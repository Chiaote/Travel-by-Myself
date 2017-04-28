//
//  RearrangeScheduleVC.swift
//  travelToMySelfLayOut
//
//  Created by 倪僑德 on 2017/4/26.
//  Copyright © 2017年 Chiao. All rights reserved.
//

import UIKit

class RearrangeScheduleVC: UIViewController, UIGestureRecognizerDelegate {
    
    
    // key setting
    let keyOfDateCell = "dailyScheduleSetting"
    let keyOfScheduleAndTrafficCell = "scheduleArray"
    
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
        var tmpArray = [ScheduleAndTrafficCellContent]()
        
        // 先抓出總共有幾天
        let daysCounting = countTripDays(inputArray: cellContentArray)
        
        //在尋訪Array的物件並切割天數func的次數
        let nextPageCellContentArray = seperateArrayByDate(intputArray: cellContentArray)
        
        //在於同圈迴圈中將ＶＣ作出來
        
        //在將全部VC帶入新的Array中
        
        //最後輸出
        
    }
    
    //確認天數
    private func countTripDays(inputArray:[CellContent]) -> Int{
        var daysCounting = 0
        for obj in inputArray {
            if (obj is DateCellContent){
                daysCounting += 1
            }
        }
        return daysCounting
    }
    
    
    //將array丟入, 並回傳分類後的array, 其中天數的key為dailyScheduleSetting, 行程的為scheduleArray
    private func seperateArrayByDate (intputArray:[CellContent]) -> [[String:[AnyObject]]] {
        
        //tmpObj
        var tmpArray = [ScheduleAndTrafficCellContent]()
        var tmpDictionary = [String:[CellContent]]()
        var isFirstObj = true
        
        //outputArray
        var seperateFinishArray = [[String:[AnyObject]]]()
        
        
        for obj in intputArray {
            if obj is DateCellContent && isFirstObj {
                //如果是第一次, 將day的資訊丟到tmpdic
                tmpDictionary = [keyOfDateCell:[obj]]
                isFirstObj = false
            
            } else if obj is DateCellContent {
                //如果是天數type, 將之前的tmpDic＆tmpArray彙整到一天頁面的物件, 並將tmpDic更新為現在這個obj
                seperateFinishArray += [tmpDictionary,[keyOfScheduleAndTrafficCell:tmpArray]]
                
                tmpDictionary = [keyOfDateCell:[obj]]
                
            } else {
                //是交通＆景點的type, 存到tmpArray中
                let tmpObj = obj as! ScheduleAndTrafficCellContent
                tmpArray += [tmpObj]
            }
        }
        return seperateFinishArray
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
