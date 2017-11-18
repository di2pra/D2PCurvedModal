//
//  ColorFilterViewController.swift
//  D2PCurvedModal_Example
//
//  Created by Pradheep Rajendirane on 18/11/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit

class ColorFilterViewController: UIViewController {
    
    fileprivate let reuseIdentifier = "colorCell"
    
    var data:[Color] = []
    var selectedItems:[Int] = []
    
    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        layout.itemSize = CGSize(width: 150, height: 30)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        collectionView.collectionViewLayout = layout
        collectionView.allowsMultipleSelection = true
        
        for index in selectedItems {
            collectionView.selectItem(at: IndexPath(row: index, section: 0), animated: false, scrollPosition: .centeredHorizontally)
        }
        
        
        
    }

    
    /*override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if animated {
            let indexPath = collectionView.indexPathsForVisibleItems
            
            for index in indexPath {
                
                if let cell = collectionView.cellForItem(at: index) as? ColorCell {
                    cell.animateCell()
                }
            }
        }
     
    }*/

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ColorFilterViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier,
                                                         for: indexPath) as? ColorCell {
            
            cell.colorView.backgroundColor = data[indexPath.row].color
            cell.colorName.text = data[indexPath.row].name
            
            if cell.isSelected {
                cell.setUpSelectedStyle()
            } else {
                cell.setUpUnselectedStyle()
            }
            
            return cell
        } else {
            
            return UICollectionViewCell()
        }
        
        
    }
}


extension ColorFilterViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? ColorCell {
            cell.setUpSelectedStyle()
            selectedItems.append(indexPath.row)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? ColorCell {
            cell.setUpUnselectedStyle()
            
            if let index = selectedItems.index(of: indexPath.row) {
                selectedItems.remove(at: index)
            }
        }
    }
    
}
