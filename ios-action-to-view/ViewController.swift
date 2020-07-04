//
//  ViewController.swift
//  ios-action-to-view
//
//  Created by Samrith Yoeun on 7/4/20.
//  Copyright © 2020 Sammi Yoeun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let imageView = UIImageView(frame: CGRect(x: 50, y: 50, width: 50, height: 50))
        imageView.image = UIImage(systemName: "arrow.up.right.circle.fill")
        imageView.contentMode = .scaleAspectFit
        
        imageView.action = {
            UIAlertController.show("You have tapped the image", in: self)
        }
        
        self.view.addSubview(imageView)
        
        
    }

}
extension UIAlertController {
    static func show(_ message: String, title: String = "", in viewController: UIViewController) {
        let alertController = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        let okayAction = UIAlertAction.init(title: "ok", style: .default, handler: nil)
        alertController.addAction(okayAction)
        viewController.present(alertController, animated: true, completion: nil)
    }
}

extension UIView {
    private struct AssociatedObject {
        static var key = "action_closure_key"
    }

    var action: ( () ->Void)? {
        get {
            return objc_getAssociatedObject(self, &AssociatedObject.key) as? ()->Void
        }
        set {
            objc_setAssociatedObject(self, &AssociatedObject.key, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            addAction( #selector(viewDidTapped(sender:)), in: self)
        }
    }

    @objc func viewDidTapped(sender: Any) {
        action?()
    }
    
    func addAction(_ selector: Selector, in target: Any) {
        let tapGuesture = UITapGestureRecognizer(target: target, action: selector)
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(tapGuesture)
    }
    
}
