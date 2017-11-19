# D2PCurvedModal

[![CI Status](http://img.shields.io/travis/di2pra/D2PCurvedModal.svg?style=flat)](https://travis-ci.org/di2pra/D2PCurvedModal)
[![Version](https://img.shields.io/cocoapods/v/D2PCurvedModal.svg?style=flat)](http://cocoapods.org/pods/D2PCurvedModal)
[![License](https://img.shields.io/cocoapods/l/D2PCurvedModal.svg?style=flat)](http://cocoapods.org/pods/D2PCurvedModal)
[![Platform](https://img.shields.io/cocoapods/p/D2PCurvedModal.svg?style=flat)](http://cocoapods.org/pods/D2PCurvedModal)

<table>
  <tr>
    <th><img alt="Demo Gif" src="https://github.com/di2pra/D2PCurvedModal/blob/master/image/D2PCurvedModal.gif" width="300"></th>
    <th><img alt="Screenshot 1" src="https://github.com/di2pra/D2PCurvedModal/blob/master/image/screenshot_1.png" width="300"></th>
    <th><img alt="Screenshot 2" src="https://github.com/di2pra/D2PCurvedModal/blob/master/image/screenshot_2.png" width="300"></th>`
  </tr>
</table>

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.
The Example project use the modal as a Color/Size Picker.

## How to Use?

1) First install the Pod and import the module `D2PCurvedModal` to your file
```Swift
import D2PCurvedModal
```


2) Instantiate `D2PCurvedModalTransition` and `D2PCurvedModalPercentDrivenTransition` inside the your presenting `ViewController`
```Swift
let percentDrivenTransition = D2PCurvedModalPercentDrivenTransition()
let transition = D2PCurvedModalTransition()
```


3) For the purpose of the transition animation your presenting `ViewController` must conform the `UIViewControllerTransitioningDelegate` protocol, with these appropriate methods
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


4) Inside the action method (to open the modal) instantiate the view controllers that will appear embedded into the D2PCurvedModal and instantiate `D2PCurvedModal`, to finally use the method `setUpViewOf(viewController:)` of `D2PCurvedModal`
```Swift

@IBAction func openModal(_ sender: Any) {

    let myCustomVC = MyCustomVC(nibName: "MyCustomVC", bundle: Bundle(for: MyCustomVC.self))
    let modalVC = D2PCurvedModal(nibName: "D2PCurvedModal", bundle: Bundle(for: D2PCurvedModal.self))
 
    modalVC.setUpViewOf(viewController: myCustomVC)
 
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
##### The `containerHeight` Property (CGFloat) (Default: 300)
Use the `containerHeight` property of `D2PCurvedModal` to change the height of the container view.
Example usage:
```Swift
 modalVC.containerHeight = 200
```


### Change the modal background color
##### The `bgColor` Property (UIColor) (Default: .white)
Use the `bgColor` property of `D2PCurvedModal` to change the background color of the modal view.
Example usage:
```Swift
 modalVC.bgColor = .orange
```

### Change the modal title
##### The `modalTitle` Property (String) (Default: "")
Use the `modalTitle` property of `D2PCurvedModal` to change the title of the modal.
Example usage:
```Swift
 modalVC.modalTitle = "Filter"
```

### Change the modal title color
##### The `modalTitleColor` Property (UIColor) (Default: .lightGray)
Use the `modalTitleColor` property of `D2PCurvedModal` to change the title text color.

### Change the close button background color
##### The `closeBtnBgColor` Property (UIColor) (Default: #FD4741)
Use the `closeBtnBgColor` property of `D2PCurvedModal` to change the background color of the modal close button.


### Change the close button tint color
##### The `closeBtnTintColor` Property (UIColor) (Default: .white)
Use the `closeBtnTintColor` property of `D2PCurvedModal` to change the tint color of the modal close button.

### Access the container view controller
##### The `containerVC` Property (UIViewController)
Use the `containerVC` property of `D2PCurvedModal` to access the view controller of the view that is embedded into the `D2PCurvedModal`.

### Manually close the modal view
##### The `close(animated: Bool, completion: (() -> Void)?)` method
Use the `close` method of `D2PCurvedModal` to manually close the modal.





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

[Di2pra](https://twitter.com/di2pra) [LinkedIn](https://www.linkedin.com/in/di2pra/)

## Credits
Credits to [Johny Vino](https://www.behance.net/johnyvino) for the UI Design inspiration. [FlatIcon](https://www.flaticon.com/) for the icons.

## License

D2PCurvedModal is available under the MIT license. See the LICENSE file for more info.
