//
//  DetailViewController.swift
//  Project1
//
//  Created by alexander on 02/10/2019.
//

import UIKit

class DetailViewController: UIViewController {

    // MARK: Properties
    @IBOutlet weak var imageView: UIImageView!
    
    var seletedPicture: Picture?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        
        if let pictureToLoad = seletedPicture {
            let path = Common.getDocumentsDirectory().appendingPathComponent(pictureToLoad.image)
            imageView.image = UIImage(contentsOfFile: path.path)
            title = pictureToLoad.caption
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = false
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
