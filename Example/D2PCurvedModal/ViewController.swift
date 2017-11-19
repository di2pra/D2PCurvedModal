//
//  ViewController.swift
//  D2PCurvedModal
//
//  Created by di2pra on 11/18/2017.
//  Copyright (c) 2017 di2pra. All rights reserved.
//


import UIKit
import D2PCurvedModal

class ViewController: UIViewController {
    
    @IBOutlet weak var selectedColorLabel: UILabel!
    @IBOutlet weak var selectedSizeLabel: UILabel!
    
    let percentDrivenTransition = D2PCurvedModalPercentDrivenTransition()
    let transition = D2PCurvedModalTransition()
    
    let color:[Color] = [
        Color(color: .black, name: "Black"),
        Color(color: .magenta, name: "Magenta"),
        Color(color: .yellow, name: "Yellow"),
        Color(color: .orange, name: "Orange"),
        Color(color: .cyan, name: "Cyan"),
        Color(color: .blue, name: "Blue"),
        Color(color: .brown, name: "Brown"),
        Color(color: .purple, name: "Purple"),
        Color(color: UIColor(rgb: 0xE08283), name: "New York Pink"),
        Color(color: UIColor(rgb: 0x9A12B3), name: "Seance"),
        Color(color: UIColor(rgb: 0x36D7B7), name: "Turquoise"),
        Color(color: UIColor(rgb: 0x00B16A), name: "Jade"),
        Color(color: UIColor(rgb: 0x59ABE3), name: "Picton Blue"),
        Color(color: UIColor(rgb: 0x336E7B), name: "Ming"),
        Color(color: UIColor(rgb: 0x67809F), name: "Hoki")
    ]
    
    let size:[String] = ["XS", "S", "M", "L", "XL", "XXL"]
    
    var selectedColor:[Int] = [] {
        didSet {
            if let label = selectedColorLabel {
                let joiner = ", "
                
                var elements:[String] = []
                
                for index in selectedColor {
                    elements.append(color[index].name)
                }
                
                let joinedStrings = elements.joined(separator: joiner)
                
                label.text = joinedStrings
            }
        }
    }
    
    var selectedSize:[Int] = [] {
        didSet {
            if let label = selectedSizeLabel {
                let joiner = ", "
                
                var elements:[String] = []
                
                for index in selectedSize {
                    elements.append(size[index])
                }
                
                let joinedStrings = elements.joined(separator: joiner)
                
                label.text = joinedStrings
            }
        }
    }
    
    @IBAction func resetSelection(_ sender: Any) {
        selectedSize = []
        selectedColor = []
    }
    
    @IBAction func openModal(_ sender: Any) {
        
        if let tabBarVC = storyboard?.instantiateViewController(withIdentifier: "tabBarController") as? TabBarController {
            
            if let colorVC = tabBarVC.viewControllers![0] as? ColorFilterViewController {
                colorVC.data = color
            }
            
            if let sizeVC = tabBarVC.viewControllers![1] as? SizeFilterViewController {
                sizeVC.data = size
            }
            
            let modalVC = D2PCurvedModal(nibName: "D2PCurvedModal", bundle: Bundle(for: D2PCurvedModal.self))
            
            modalVC.setUpViewOf(viewController: tabBarVC)
            modalVC.modalTitle = "Filter"
            modalVC.containerHeight = 200
            modalVC.delegate = self
            modalVC.transitioningDelegate = self
            percentDrivenTransition.attachToViewController(viewController: modalVC)
            present(modalVC, animated: true, completion: nil)
            
        }
        
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension ViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        if presented is D2PCurvedModal {
            transition.opening = true
            return transition
        }
        
        return nil
        
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        if dismissed is D2PCurvedModal {
            transition.opening = false
            return transition
        }
        
        return nil
        
        
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        
        return percentDrivenTransition.transitionInProgress ? percentDrivenTransition : nil
        
    }
    
}

extension ViewController: D2PCurvedModalDelegate {
    
    func modalWillOpen(modalVC: D2PCurvedModal) {
        
        if let tabBarVC = modalVC.containerVC as? TabBarController {
            
            if let colorVC = tabBarVC.viewControllers![0] as? ColorFilterViewController {
                colorVC.selectedItems = selectedColor
            }
            
            if let sizeVC = tabBarVC.viewControllers![1] as? SizeFilterViewController {
                sizeVC.selectedItems = selectedSize
            }
        }
        
    }
    
    func modalWillClose(modalVC: D2PCurvedModal) {
        
        if let tabBarVC = modalVC.containerVC as? TabBarController {
            
            if let colorVC = tabBarVC.viewControllers![0] as? ColorFilterViewController {
                selectedColor = colorVC.selectedItems
            }
            
            if let sizeVC = tabBarVC.viewControllers![1] as? SizeFilterViewController {
                selectedSize = sizeVC.selectedItems
            }
        }
        
    }
    
}
