//
//  ViewController.swift
//  To do
//
//  Created by Takuma Jimbo on 2017/02/18.
//  Copyright © 2017年 Takuma Jimbo. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var titleArray:[String] = []
    var contentArray:[String] = []
    var thumbnailArray:[UIImage] = []
    
    var row: Int!
    var editBool: Bool = true
    @IBOutlet var thumbnail: UIImageView? = CustomTableViewCell().thumbnail
    @IBOutlet var titleLabel: UILabel? = CustomTableViewCell().titleLabel
    @IBOutlet var contentLabel: UILabel? = CustomTableViewCell().contentLabel
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.leftBarButtonItem = editButtonItem
        
        
        var testArray = [UIImage!]()
        var tempArray = saveData().saveData.data(forKey: "thumbnail")
        
        var firstTimeLaunch: Bool! = saveData().saveData.bool(forKey: "launch")
        if firstTimeLaunch == nil{
            firstTimeLaunch = true
        }else{
            firstTimeLaunch = false
        }
        
        //        if firstTimeLaunch == true{
        //            saveData().saveData.removeObject(forKey: "thumbnail")
        //            saveData().saveData.removeObject(forKey: "title")
        //            saveData().saveData.removeObject(forKey: "content")
        //        }else{
        //            //print("not your first time, is it?")
        //        }
        //
        saveData().saveData.set(firstTimeLaunch, forKey: "launch")
        tempArray = saveData().saveData.data(forKey: "thumbnail")
        
        if tempArray == nil{
        }else{
            testArray = NSKeyedUnarchiver.unarchiveObject(with: tempArray!) as! [UIImage]!
        }
        
        if testArray.count == 0{
            //print("nopic")
        }else{
            thumbnailArray = testArray
            contentArray = saveData().saveData.object(forKey: "content") as! [String]
            titleArray = saveData().saveData.object(forKey: "title") as! [String]
            //            print("yeah, its there")
            //            print(thumbnailArray)
            //            print(contentArray)
            //            print(titleArray)
        }
        tableView.delegate = self
        tableView.dataSource = self
        
        saveData().saveData.set(contentArray, forKey: "content")
        saveData().saveData.set(tempArray, forKey: "thumbnail")
        saveData().saveData.set(titleArray, forKey: "title")
        
        tableView.reloadData()
        //        print("contents")
        //        print(thumbnailArray)
        //        print(contentArray)
        //        print(titleArray)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return thumbnailArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        cell.titleLabel.text = titleArray[indexPath.row]
        cell.thumbnail.image = thumbnailArray[indexPath.row]
        cell.contentLabel.text = contentArray[indexPath.row]
        return cell
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.isEditing = editing
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        
        return true
    }
    
    
    //    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    //        //それからtableの更新
    //        tableView.deleteRows(at: [NSIndexPath(row : indexPath.row, section: 0) as IndexPath], with: UITableViewRowAnimation.fade)
    //
    //        print("1")
    //
    //        //先にデータの更新
    //        titleArray.remove(at: indexPath.row)
    //        contentArray.remove(at: indexPath.row)
    //        thumbnailArray.remove(at: indexPath.row)
    //
    //        print("2")
    //
    //        // userdefaultに保存
    //        let tempArray = NSKeyedArchiver.archivedData(withRootObject: thumbnailArray)
    //        saveData().saveData.set(titleArray, forKey: "title")
    //        saveData().saveData.set(contentArray, forKey: "content")
    //        saveData().saveData.set(thumbnailArray, forKey: "thumbnail")
    //    }
    //}
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print("Deleted")
            titleArray.remove(at: indexPath.row)
            contentArray.remove(at: indexPath.row)
            thumbnailArray.remove(at: indexPath.row)
            
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            let tempArray = NSKeyedArchiver.archivedData(withRootObject: thumbnailArray)
            saveData().saveData.set(titleArray, forKey: "title")
            saveData().saveData.set(contentArray, forKey: "content")
            saveData().saveData.set(thumbnailArray, forKey: "thumbnail")
            
            func editTap(_ sender: Any) {
                editBool = false
                if editBool == false {
                    
                }
                
                
            }
            
            
        }
        
    }
}
class saveData{
    var saveData: UserDefaults = UserDefaults.standard
}

