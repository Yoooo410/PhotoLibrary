//
//  PhotoInfoViewController.swift
//  PhotoLibrary
//
//  Created by Derrick Park on 2017-07-21.
//  Copyright © 2017 Derrick Park. All rights reserved.
//

import UIKit

class PhotoInfoViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    var photo: Photo! {
        didSet{
            navigationItem.title = photo.title
        }
    }
    var store: PhotoStore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        store.fetchImage(for: photo) { (result) in
            switch result {
            case let .success(image):
                self.imageView.image = image
            case let .failure(error):
                print("Error fetching image for photo: \(error)")
            }
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "showTags"?:
            let navController = segue.destination as! UINavigationController
            let tagController = navController.topViewController as! TagsViewController
            
            tagController.store = store
            tagController.photo = photo
            
        case "showFavorite"?:
            let navController = segue.destination as! UINavigationController
            let favoriteController = navController.topViewController as! FavoriteViewController
            
            favoriteController.
        default:
            preconditionFailure("Unexpected Segue Identifier.")
        }
    }
}
