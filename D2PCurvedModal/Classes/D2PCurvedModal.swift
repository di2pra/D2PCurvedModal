//
//  D2PCurvedModal.swift
//  D2PCurvedModal
//
//  Created by Pradheep Rajendirane on 18/11/2017.
//

import UIKit

@objc public protocol D2PCurvedModalDelegate: class {
    @objc optional func modalWillClose(modalVC: D2PCurvedModal)
    @objc optional func modalWillOpen(modalVC: D2PCurvedModal)
}

open class D2PCurvedModal: UIViewController {
    
    @IBOutlet weak private var headerCurveViewHeight: NSLayoutConstraint!
    @IBOutlet weak private var containerViewHeight: NSLayoutConstraint!
    @IBOutlet weak var visualEffectView: UIVisualEffectView!
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var headerCurveView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak private var modalTitleLabel: UILabel!
    private var closeBtn: UIButton!
    
    public var backgroundColor: UIColor = .white
    public var closeBtnColor: UIColor = UIColor(red:0.99, green:0.28, blue:0.25, alpha:1.0) // #FD4741
    public var containerHeight: CGFloat = 300
    public var headerCurveHeight:CGFloat = 50
    public var containerVC: UIViewController?
    
    public var delegate:D2PCurvedModalDelegate?
    
    public var modalTitle:String! = "" {
        didSet {
            if let label = self.modalTitleLabel {
                label.text = modalTitle
            }
        }
    }
    
    public var modalTitleColor: UIColor! = .lightGray {
        didSet {
            if let label = self.modalTitleLabel {
                label.textColor = modalTitleColor
            }
        }
    }
    
    private var curveLayer = CAShapeLayer()
    
    /*lazy private var rectFrame: CGRect = {
        [unowned self] in
        
        let height = self.view.frame.height
        let width = self.view.frame.width
        
        return CGRect(x: -width * 1.5 + width*0.5, y: 0, width: width * 3, height: height * 2)
    }()*/
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        self.modalPresentationStyle = .overCurrentContext
        headerCurveView.backgroundColor = .clear
        containerView.backgroundColor = backgroundColor
        headerCurveViewHeight.constant = headerCurveHeight
        containerViewHeight.constant = containerHeight
        
        self.view.frame = UIScreen.main.bounds
        
        setUpCloseBtn()
        
        // Do any additional setup after loading the view.
        
    }
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.delegate?.modalWillOpen?(modalVC: self)
    }
    
    private func setUpCloseBtn() {
        
        closeBtn = UIButton(type: .custom)
        self.headerCurveView.addSubview(closeBtn)
        
        // layout
        closeBtn.translatesAutoresizingMaskIntoConstraints  = false
        closeBtn.layer.cornerRadius = headerCurveHeight * 0.5
        closeBtn.clipsToBounds = true
        closeBtn.contentMode = .scaleToFill
        closeBtn.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        self.headerCurveView.addConstraints([
            NSLayoutConstraint(item: closeBtn, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: headerCurveHeight),
            NSLayoutConstraint(item: closeBtn, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: headerCurveHeight),
            NSLayoutConstraint(item: self.headerCurveView, attribute: .trailing, relatedBy: .equal, toItem: closeBtn, attribute: .trailing, multiplier: 1, constant: 40),
            NSLayoutConstraint(item: closeBtn, attribute: .centerY, relatedBy: .equal, toItem: self.headerCurveView, attribute: .centerY, multiplier: 1, constant: 0)])
        
        
        // style
        closeBtn.backgroundColor = closeBtnColor
        //closeBtn.adjustsImageWhenHighlighted = false
        closeBtn.tintColor = .white
        
        if let image = UIImage(named: "checkmark", in: Bundle(for: type(of: self)), compatibleWith: nil) {
            closeBtn.setImage(image, for: .normal)
        }
        
        if let image = UIImage(named: "checkmark_checked", in: Bundle(for: type(of: self)), compatibleWith: nil) {
            closeBtn.setImage(image, for: .highlighted)
        }
        
        
        // action
        closeBtn.addTarget(self, action: #selector(self.closePressed), for: .touchUpInside)
        
        
        
    }
    
    public func setUpViewOf(viewController vc: UIViewController) {
        self.containerVC = vc
    }
    
    public func close(animated: Bool, completion: (() -> Void)?) {
        self.dismiss(animated: animated, completion: completion)
    }
    
    @objc private func closePressed() {
        self.close(animated: true, completion: nil)
    }
    
    override open func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()
        
        _ = setupTopCurve
        _ = setupContainerView
    }
    
    override open func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        super.viewWillTransition(to: size, with: coordinator)
        
        coordinator.animate(alongsideTransition: nil) { _ in
            let path = UIBezierPath(ovalIn: self.getCurveFrame())
            self.curveLayer.path = path.cgPath
        }
        
        super.viewWillTransition(to: size, with: coordinator)
        
        
        
    }
    
    private func getCurveFrame() -> CGRect {
        let height = self.view.frame.height
        let width = self.view.frame.width
        
        return CGRect(x: -width * 1.5 + width*0.5, y: 0, width: width * 3, height: height * 2)
    }
    
    lazy private var setupContainerView: Void = {
        
        if let vc = containerVC {
            
            vc.willMove(toParentViewController: self)
            self.containerView.addSubview(vc.view)
            vc.view.translatesAutoresizingMaskIntoConstraints = false
            
            containerView.addConstraints([
                NSLayoutConstraint(item: vc.view, attribute: .top, relatedBy: .equal, toItem: self.containerView, attribute: .top, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: vc.view, attribute: .bottom, relatedBy: .equal, toItem: self.containerView, attribute: .bottom, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: vc.view, attribute: .trailing, relatedBy: .equal, toItem: self.containerView, attribute: .trailing, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: vc.view, attribute: .leading, relatedBy: .equal, toItem: self.containerView, attribute: .leading, multiplier: 1, constant: 0)])
            
            self.addChildViewController(vc)
            vc.didMove(toParentViewController: self)
            
        }
        
    }()
    
    lazy private var setupTopCurve: Void = {
        
        let path = UIBezierPath(ovalIn: getCurveFrame())
        curveLayer.path = path.cgPath
        
        curveLayer.fillColor = backgroundColor.cgColor
        
        let layerView = UIView(frame: .zero)
        layerView.translatesAutoresizingMaskIntoConstraints = false
        layerView.layer.addSublayer(curveLayer)
        
        headerCurveView.addSubview(layerView)
        
        headerCurveView.addConstraints([
            NSLayoutConstraint(item: layerView, attribute: .top, relatedBy: .equal, toItem: self.headerCurveView, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: layerView, attribute: .bottom, relatedBy: .equal, toItem: self.headerCurveView, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: layerView, attribute: .trailing, relatedBy: .equal, toItem: self.headerCurveView, attribute: .trailing, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: layerView, attribute: .leading, relatedBy: .equal, toItem: self.headerCurveView, attribute: .leading, multiplier: 1, constant: 0)
            ])
        
        headerCurveView.sendSubview(toBack: layerView)
        
        modalTitleLabel.text = modalTitle
        modalTitleLabel.textColor = modalTitleColor
        
    }()
    
    override open func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.delegate?.modalWillClose?(modalVC: self)
    }

    /*override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
