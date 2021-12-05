//
//  ProfileViewController.swift
//  TasteFive
//
//  Created by Sadia Taher on 11/25/21.
//

import UIKit

import AlamofireImage

import Parse



class ProfileViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    var post: PFObject!
    var categorie: PFObject!
    var posts = [PFObject]()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {

        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout

        layout.minimumLineSpacing = 4
        layout.minimumInteritemSpacing = 4
        let width = (view.frame.size.width - layout.minimumInteritemSpacing) / 2
        layout.itemSize = CGSize(width: width, height: width * 3/2)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let query = PFQuery(className: "Posts")
        query.whereKey("author", equalTo: PFUser.current())
        query.includeKey("author")
        query.limit = 20
        query.findObjectsInBackground { (posts, error) in
            if posts != nil {
                self.posts = posts!
                self.collectionView.reloadData()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileGridCell", for: indexPath) as! ProfileGridCell
        
        let post = posts[indexPath.item]
        
        cell.recipeTitleLabel.text = post["title"] as? String
        cell.instructionsText.text = post["instructionsText"] as? String
        cell.ingredientLabel.text = post["ingredients"] as? String
        let imageFile = post["image"] as! PFFileObject
        let urlString = imageFile.url!
        let url = URL(string: urlString)!

        cell.recipeImage.af_setImage(withURL: url)

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
