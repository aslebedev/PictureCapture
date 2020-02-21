//
//  TableViewController.swift
//  PictureCapture
//
//  Created by alexander on 14.11.2019.
//  Copyright © 2019 alexander. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var pictures = [Picture]()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "My Pictures"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewPicture))
        
        DispatchQueue.global(qos: .userInitiated).async {
            let defaults = UserDefaults.standard
            if let savedPeople = defaults.object(forKey: "pictures") as? Data {
                let jsonDecoder = JSONDecoder()
                
                do {
                    self.pictures = try jsonDecoder.decode([Picture].self, from: savedPeople)
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                } catch {
                    print("Failed to load people")
                }
            }
        }
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }

        let imageName = UUID().uuidString
        let imagePath = Common.getDocumentsDirectory().appendingPathComponent(imageName)

        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: imagePath)
        }

        dismiss(animated: true)
        
        let today = Date()
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        let picture = Picture(caption: "New photo \(formatter.string(from: today))", image: imageName)
        pictures.append(picture)
        tableView.reloadData()
        //  Если поставить save в конце метода, то save все равно будет дергаться до того как будет показан алерт
        self.save()
        
        let ac = UIAlertController(title: "How would you like to caption this photo?", message: nil, preferredStyle: .alert)
        
        ac.addTextField()
        
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        ac.addAction(UIAlertAction(title: "OK", style: .default) { [weak self, weak ac] _ in
            guard let newCaption = ac?.textFields?[0].text else { return }
            if newCaption.isEmpty { return }
            
            self?.pictures.last?.caption = newCaption
            self?.tableView.reloadData()
            self?.save()
        })
        
        self.present(ac, animated: true)
    }

    func save() {
        let jsonEncoder = JSONEncoder()
        if let savedData = try? jsonEncoder.encode(pictures) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: "pictures")
        } else {
            print("Failed to save people.")
        }
    }
    
    @objc func addNewPicture() {
        let picker = UIImagePickerController()
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
           picker.sourceType = .camera
        }
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    // MARK: - Table view data source    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return pictures.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        let path = Common.getDocumentsDirectory().appendingPathComponent(self.pictures[indexPath.row].image)
        cell.imageView?.image = UIImage(contentsOfFile: path.path)
        cell.textLabel?.text = self.pictures[indexPath.row].caption
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.seletedPicture = pictures[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
