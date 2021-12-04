//
//  PostViewController.swift
//  TasteFive
//
//  Created by Abdullah Saleh on 11/27/21.
//

import UIKit
import AlamofireImage
import Parse

class PostViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titletext: UITextField!
    @IBOutlet weak var instructionsText: UITextField!
    
    @IBOutlet weak var ingredientText: UITextField!
    
    
    @IBOutlet weak var categoryTextField: UITextField!
    
 
    var categoriesList = [String]()
    
    var categoryDict = [String:PFObject]()
    
    //categoryDict["Chinese"] =
    var pickerView = UIPickerView()
    override func viewDidLoad() {
        super.viewDidLoad()

        let query = PFQuery(className: "Categories")
        
        query.findObjectsInBackground { (objects, error) -> Void in
            if error == nil {
                //no error in fetch
                
                if let returnedobjects = objects {
                    for object in returnedobjects{
                        self.categoriesList.append(object["CategoryName"] as! String)
                        self.categoryDict[object["CategoryName"] as! String] = object
                    }
                }
            }
            
        }
        // Do any additional setup after loading the view.
        pickerView.delegate = self
        pickerView.dataSource = self
        
        categoryTextField.inputView = pickerView
        categoryTextField.textAlignment = .center
    }
    
    @IBAction func onSubmitButton(_ sender: Any) {
        let post = PFObject(className: "Posts")
                
        post["ingredients"] = ingredientText.text!
        post["instructionsText"] = instructionsText.text!
        post["author"] = PFUser.current()!
        post["title"] = titletext.text!
        post["category"] = self.categoryDict[categoryTextField.text ?? "NONE"]
                
        let imageData = imageView.image!.pngData()
        let file = PFFileObject(name: "image.png", data: imageData!)
                
        post["image"] = file
                
        post.saveInBackground{ (success, error) in
            if success {
                self.dismiss(animated: true, completion: nil)
                print("saved!")
            } else {
                print("error!")
            }
        }
    }
    
    @IBAction func onCameraButton(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
            
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
        } else {
            picker.sourceType = .photoLibrary
        }
        
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
           let image = info[.editedImage] as! UIImage
           
           let size = CGSize(width: 300, height: 300)
           let scaledImage = image.af.imageScaled(to: size)
           
           imageView.image = scaledImage
           dismiss(animated: true, completion: nil)
       }
       
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension PostViewController: UIPickerViewDelegate,UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categoriesList.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categoriesList[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        categoryTextField.text = categoriesList[row]
        categoryTextField.resignFirstResponder()
    }
    
    
}
