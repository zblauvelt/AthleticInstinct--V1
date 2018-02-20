//
//  CreateCategoryVC.swift
//  AthleticInstinct
//
//  Created by Zachary Blauvelt on 2/19/18.
//  Copyright © 2018 ZackBlauvelt. All rights reserved.
//

import UIKit
import Firebase

class CreateCategoryVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate,UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var categoryNameLbl: UITextField!
    @IBOutlet weak var pickCategory: UITextField!
    
    var createdCategories = [String]()
    var imagePicker: UIImagePickerController!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getCreatedCategories()
        getCategoryPickers(pickCategory)
        //Creating imagepicker
        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            categoryImage.image = image
            categoryImage.contentMode = .scaleToFill
        } else {
            print("ZACK: A valid image wasn't selected.")
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBAction func addImage(_ sender: Any) {
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func saveAndContinueTapped(_ sender: Any) {
        
        if let newCategory = categoryNameLbl.text {
            if createdCategories.contains(newCategory) {
                showAlert(message: CreateCategoryError.duplicateName.rawValue)
            } else {
                if let categoryName = categoryNameLbl.text, let categoryImage = categoryImage.image {
                    let newCategory = WorkOutCategory(name: categoryName)
                    
                    do {
                        try newCategory.createCategory(category: newCategory, image: categoryImage)
                    } catch CreateCategoryError.invalidCategoryName {
                        showAlert(message: CreateCategoryError.invalidCategoryName.rawValue)
                    } catch CreateCategoryError.invalidImage {
                        showAlert(message: CreateCategoryError.invalidImage.rawValue)
                    } catch let error {
                        showAlert(message: "\(error)")
                    }
                }
            }
        } else {
            showAlert(message: CreateCategoryError.invalidCategoryName.rawValue)
        }
    }
    
    func showAlert(message: String) {
        let alertController = UIAlertController(title: "" , message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .cancel) { action in
            return
        }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    
    func getCreatedCategories() {
        DataService.ds.REF_CATEGORY.observe(.value, with: { (snapshot) in
            if let snapshot = snapshot.children.allObjects as? [FIRDataSnapshot] {
                self.createdCategories.removeAll()
                for snap in snapshot {
                    print("SNAP: \(snap)")
                    if let categoryData = snap.value as? Dictionary<String, String> {
                        let key = snap.key
                        let category = WorkOutCategory(CategoryName: key, categoryData: categoryData)
                        self.createdCategories.append(category.name)
                    }
                }
            }
        })
    }
    
    //MARK: PickerView Delegates & DataSource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return createdCategories.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return createdCategories[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.pickCategory.text = createdCategories[row]
    }
    
    //MARK: TextField Delegate
    func textFieldDidBeginEditing(_ textField : UITextField) {
        self.getCategoryPickers(pickCategory)
    }
    
    func getCategoryPickers(_ textField : UITextField){
        let categoryPickerView = UIPickerView()
        categoryPickerView.delegate = self
        textField.inputView = categoryPickerView
        
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 40))
        
        toolBar.barStyle = UIBarStyle.blackTranslucent
        toolBar.tintColor = UIColor.white
        
        let cancel = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.cancel, target: self, action: #selector(CreateCategoryVC.cancelPressed(sender:)))
        
        let done = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(CreateCategoryVC.donePressed(sender:)))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: nil)
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width/3, height: 40))
        
        label.font = UIFont.systemFont(ofSize: 14)
        
        label.textColor = UIColor.white
        
        label.text = "Pick a Category"
        
        label.textAlignment = NSTextAlignment.center
        
        let textButton = UIBarButtonItem(customView: label)
        
        toolBar.setItems([cancel, flexSpace, textButton, flexSpace, done], animated: true)
        
        pickCategory.inputAccessoryView = toolBar
    }
    //MARK:- Button
    @objc func donePressed(sender: UIBarButtonItem) {
        pickCategory.resignFirstResponder()
    }
    
    @objc func cancelPressed(sender: UIBarButtonItem) {
        pickCategory.resignFirstResponder()
    }

    
    
}
