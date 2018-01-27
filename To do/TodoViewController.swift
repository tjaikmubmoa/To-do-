//
//  todoViewController.swift
//  To do
//
//  Created by Takuma Jimbo on 2017/02/18.
//  Copyright © 2017年 Takuma Jimbo. All rights reserved.
//

import UIKit

class TodoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate ,UITextFieldDelegate{
    
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var contentTextView: UITextView!
    @IBOutlet var thumbnailImageView: UIImageView!
    
    var titleArray = [String!]()
    var contentArray = [String!]()
    var thumbnailArray = [UIImage!]()
    
    var titlefield: String!
    
    var savePlan: UserDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        titleTextField.delegate = self
    
        titleArray = saveData().saveData.object(forKey: "title") as! [String]
        contentArray = saveData().saveData.object(forKey: "content") as! [String]
        let tempImageArray = saveData().saveData.data(forKey: "thumbnail")
        var testImageArray = [UIImage!]()
        
        if tempImageArray == nil{
            //print("nope, Nothing here")
        }else{
            testImageArray = NSKeyedUnarchiver.unarchiveObject(with: tempImageArray!) as! [UIImage?]
            //print("yeah we got some stuff")
        }
        
        thumbnailArray = testImageArray
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        titlefield = titleTextField.text!
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func selectThumbnail() {
        
        let imagePickerController: UIImagePickerController = UIImagePickerController()
        
        imagePickerController.sourceType = UIImagePickerControllerSourceType.photoLibrary
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        
        self.present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let image: UIImage = info[UIImagePickerControllerEditedImage] as! UIImage
        
        thumbnailImageView.image = image
        
        picker.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func save(sender: UIBarButtonItem) {
        titleArray.append(titleTextField.text!)
        contentArray.append(contentTextView.text!)
        thumbnailArray.append(thumbnailImageView.image!)
        let tempArray = NSKeyedArchiver.archivedData(withRootObject: thumbnailArray)
//        print(thumbnailArray)
//        print(titleArray)
//        print(contentArray)
//        print(titleTextField.text!)

        saveData().saveData.set(titleArray, forKey: "title")
        saveData().saveData.set(contentArray, forKey: "content")
        saveData().saveData.set(tempArray, forKey: "thumbnail")
        
        navigationController?.popViewController(animated: true)
        
    }

}

/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destinationViewController.
 // Pass the selected object to the new view controller.
 }
 */


