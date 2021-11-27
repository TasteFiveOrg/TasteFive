//
//  RecipeFeedViewController.swift
//  TasteFive
//
//  Created by Sadia Taher on 11/25/21.
//

import UIKit
import Parse

class RecipeFeedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!

    var categorie: PFObject!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50 //sample number of rows shown. The number represents how many rows are shown
        // it should be recipies.count where recipies refers to the title of the recipe that the user gives
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell") as! RecipeCell
        
        //the code replacing this should say, ... = cell.titleLabel.text = title (this is what the class is called in parse)
        // same thing for the upvotes
        
        return cell
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
