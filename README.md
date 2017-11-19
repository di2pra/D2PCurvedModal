# D2PCurvedModal

[![CI Status](http://img.shields.io/travis/di2pra/D2PCurvedModal.svg?style=flat)](https://travis-ci.org/di2pra/D2PCurvedModal)
[![Version](https://img.shields.io/cocoapods/v/D2PCurvedModal.svg?style=flat)](http://cocoapods.org/pods/D2PCurvedModal)
[![License](https://img.shields.io/cocoapods/l/D2PCurvedModal.svg?style=flat)](http://cocoapods.org/pods/D2PCurvedModal)
[![Platform](https://img.shields.io/cocoapods/p/D2PCurvedModal.svg?style=flat)](http://cocoapods.org/pods/D2PCurvedModal)

![Screenshot of Demo App](https://github.com/di2pra/D2PCurvedModal/blob/master/image/D2PCurvedModal.gif)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.
The Example project use the modal as a Color/Size Picker.

### How to Use?

1) First install the Pod and import the module `D2PCurvedModal` to your file
```Swift
import D2PCurvedModal
```


2) Instantiate `D2PCurvedModalTransition` and `D2PCurvedModalPercentDrivenTransition` inside your `UIViewController`
```Swift
let percentDrivenTransition = D2PCurvedModalPercentDrivenTransition()
let transition = D2PCurvedModalTransition()
```


3) Your `UIViewController` must conform the `UIViewControllerTransitioningDelegate` protocol, with these appropriate methods
```Swift
extension ViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {`
       
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
```


4) Inside the action method (to open the modal) instantiate the view controllers that will appear embedded into the D2PCurvedModal and instantiate `D2PCurvedModal`, to finally use the method `setUpViewOf(viewController:)` 
```Swift

@IBAction func openModal(_ sender: Any) {

 let myCustomVC = MyCustomVC(nibName: "MyCustomVC", bundle: Bundle(for: MyCustomVC.self))
 let modalVC = D2PCurvedModal(nibName: "D2PCurvedModal", bundle: Bundle(for: D2PCurvedModal.self))
 
 modalVC.setUpViewOf(viewController: tabBarVC)
 
 modalVC.containerHeight = 200
 modalVC.delegate = self
 modalVC.transitioningDelegate = self
 percentDrivenTransition.attachToViewController(viewController: modalVC)
 
 present(modalVC, animated: true, completion: nil)
 
}

```


That's it! You're all set!!



## Documentation
All of the methods and properties available for **D2PCurvedModal** are documented below.


### Change the modal container height
##### The `containerHeight` Property
Use the `containerHeight` property of `D2PCurvedModal` to change the height of the container view. (Default: 300)
Example usage:
```Swift
 modalVC.containerHeight = 200
```


### Change the modal background color
##### The `backgroundColor` Property
Use the `backgroundColor` property of `D2PCurvedModal` to change the background color of the modal view. (Default: .white)
Example usage:
```Swift
 modalVC.backgroundColor = .orange
```



### Delegate
**D2PCurvedModal** uses a delegate to receive modal change events. The delegate object must conform to the `D2PCurvedModalDelegate` protocol, which is composed of the method:

- `modalWillOpen(modalVC: D2PCurvedModal)`  
Tells the delegate that the view of the specified modal view controller is about to be displayed.

- `modalWillClose(modalVC: D2PCurvedModal)`  
Tells the delegate that the view of the specified modal view controller is about to be removed.

## Requirements

No Requirement

## Installation

D2PCurvedModal is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'D2PCurvedModal'
```

## Author

di2pra, pas495@gmail.com

## Credits
Credits to [Johny Vino](https://www.behance.net/johnyvino) for the UI Design inspiration. [FlatIcon](https://www.flaticon.com/) for the icons.

## License

D2PCurvedModal is available under the MIT license. See the LICENSE file for more info.
