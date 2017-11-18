//
//  SizeFilterViewController.swift
//  D2PCurvedModal_Example
//
//  Created by Pradheep Rajendirane on 18/11/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit

class SizeFilterViewController: UIViewController {

    fileprivate let reuseIdentifier = "sizeCell"
    
    var data:[String] = []
    var selectedItems:[Int] = []
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        layout.itemSize = CGSize(width: 75, height: 75)
        layout.minimumInteritemSpacing = 40
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
                
                if let cell = collectionView.cellForItem(at: index) as? SizeCell {
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

extension SizeFilterViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier,
                                                         for: indexPath) as? SizeCell {
            
            cell.sizeLabel.text = data[indexPath.row]
            
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

extension SizeFilterViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? SizeCell {
            cell.setUpSelectedStyle()
            selectedItems.append(indexPath.row)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? SizeCell {
            cell.setUpUnselectedStyle()
            
            if let index = selectedItems.index(of: indexPath.row) {
                selectedItems.remove(at: index)
            }
        }
    }
    
}
