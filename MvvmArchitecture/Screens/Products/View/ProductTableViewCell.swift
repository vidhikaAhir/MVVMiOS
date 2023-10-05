//
//  ProductTableViewCell.swift
//  MvvmArchitecture
//
//  Created by Vidhika Ahir on 03/10/23.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

    @IBOutlet weak var productBGView: UIView!
    @IBOutlet weak var productTitleLbl: UILabel!
    @IBOutlet weak var productCategoryLbl: UILabel!
    @IBOutlet weak var ratingLbl: UILabel!
    @IBOutlet weak var ratingBtn: UIButton!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    var products : ProductsModelElement? {
        didSet {
            configureCellContent()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCellContent(){
        guard let products else { return }
        productTitleLbl.text = products.title
        productCategoryLbl.text = products.description
        priceLbl.text = "$\(products.price)"
        ratingBtn.setTitle("\(products.rating.rate)", for: .normal)
        imgView?.getImageFromUrl(url: products.image)
    }
    
}
