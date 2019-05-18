//
//  collectionCell.swift
//  desafioIos
//
//  Created by Felipe Silva Lima on 5/12/19.
//  Copyright © 2019 Felipe Silva Lima. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON
import RealmSwift

class collectionCell: UICollectionViewCell {

    var link: MovieViewController?
    
    let realm = try! Realm()
    
    let favorites = Favorites()
    
    @IBOutlet weak var movieView: UIImageView!
    
    @IBOutlet weak var moviesLabel: UILabel!
    
    @IBOutlet weak var favoriteButton: UIButton!
    
    var buttonToggle: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setCollectionCell(image: UIImage, text: String){
        
        moviesLabel.numberOfLines = 2
        moviesLabel.adjustsFontSizeToFitWidth = true
        self.movieView.image = image
        self.moviesLabel.text = text
    }
    
    func favoriteSave() {
        do{
            let realm = try Realm()
            try realm.write {
                realm.add(favorites)
            }
        }catch {
            print("Error initializing new realm: \(error)")
        }
    }
    
    func favoriteInfo() {
        
        if let movieInfo = link?.movieInfo(cell: self) {
            favorites.realmTitle = movieInfo.title
            favorites.realmDate = movieInfo.releaseDate
            favorites.realmDescription = movieInfo.overview
            favorites.realmPoster = movieInfo.posterPath
        }
    }

    @IBAction func favoriteButtonPressed(_ sender: Any) {
        
        if buttonToggle == false {

            favoriteButton.setImage(UIImage(named: "favorite_gray_icon"), for: .normal)
            buttonToggle = true
        }
            
        else {
            favoriteInfo()
            favoriteSave()
            favoriteButton.setImage(UIImage(named: "favorite_full_icon"), for: .normal)
            buttonToggle = false
        }
        
        //Perfoming persistance data of the
        
    }
}

