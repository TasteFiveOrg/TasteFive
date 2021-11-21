//
//  FeedViewController.swift
//  TasteFive
//
//  Created by James Zou on 11/19/21.
//

import UIKit
import Parse


class FeedViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    var categories = [PFObject]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell") as! CategoryCell
        
        let category = categories[indexPath.row]
        
        cell.categoryLabel.text = category["CategoryName"] as! String
        
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        let query = PFQuery(className: "Categories")
        query.limit = 5
        query.findObjectsInBackground{(Categories,error) in
            if Categories != nil{
                self.categories = Categories!
                self.tableView.reloadData()
            }
            
        }
    }
    
  
    @IBOutlet weak var tableView: UITableView!
    @IBAction func onLogOutButton(_ sender: Any) {
        PFUser.logOut()
        
        let main = UIStoryboard (name: "Main", bundle: nil)
        
        let loginViewController = main.instantiateViewController(identifier: "LoginViewController")
        
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let delegate = windowScene.delegate as? SceneDelegate else { return }
        
        delegate.window?.rootViewController = loginViewController
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
