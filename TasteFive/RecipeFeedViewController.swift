//
//  RecipeFeedViewController.swift
//  TasteFive
//
//  Created by Sadia Taher on 11/25/21.
//

import UIKit
import Parse
import AlamofireImage

class RecipeFeedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!

    var categorie: PFObject!
    var posts = [PFObject]()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let query = PFQuery(className: "Posts")
        query.whereKey("category", equalTo: categorie ?? "ksg8SVfZvV")
        query.includeKey("author")
        query.limit = 20
        
        query.findObjectsInBackground { (posts, error) in
            if posts != nil {
                self.posts = posts!
                self.tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
        //sample number of rows shown. The number represents how many rows are shown
        // it should be recipies.count where recipies refers to the title of the recipe that the user gives
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell") as! RecipeCell
        
        let post = posts[indexPath.row]
        
        cell.recipeTitle.text = post["title"] as? String
        cell.ingredientsLabel.text = "Ingredients:"
        cell.ingredientsText.text = post["ingredients"] as? String
        
        let imageFile = post["image"] as! PFFileObject
        let urlString = imageFile.url!
        let url = URL(string: urlString)!
        
        cell.recipeImage.af_setImage(withURL: url)
        //let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell") as! RecipeCell
        


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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("Loading the next screen")
        
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: cell)!
        let post = posts[indexPath.row]
        
        let detailsViewController = segue.destination as! RecipeDetailsViewController
        detailsViewController.post = post
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
