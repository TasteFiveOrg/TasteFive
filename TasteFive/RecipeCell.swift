//
//  RecipeCell.swift
//  TasteFive
//
//  Created by andy on 11/26/21.
//

import UIKit

class RecipeCell: UITableViewCell {

    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeTitle: UILabel!
    @IBOutlet weak var ingredientsLabel: UILabel!
    @IBOutlet weak var ingredientsText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
