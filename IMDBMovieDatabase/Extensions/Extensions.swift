//
//  Extensions.swift
//  IMDBMovieDatabase
//
//  Created by Mina Maged on 1/14/22.
//

import Foundation
import UIKit
import NVActivityIndicatorView

extension UIApplication {
    
    class func topViewController(controller: UIViewController? = UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
}

extension Collection {
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

extension UIViewController {
    func displayAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

func isRunningUnitTests() -> Bool {
    let env = ProcessInfo.processInfo.environment
    if let injectBundle = env["XCInjectBundle"] {
        return NSString(string: injectBundle).pathExtension == "xctest"
    }
    return false
}

@IBDesignable
extension UIView {
    
    func startProgressAnim() {
        let activityIndicatorView = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50), type: .circleStrokeSpin)
        activityIndicatorView.color = .systemOrange
        self.addSubview(activityIndicatorView)
        self.bringSubviewToFront(activityIndicatorView)
        
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        
        activityIndicatorView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        activityIndicatorView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        activityIndicatorView.startAnimating()
    }
    
    func stopProgressAnim() {
        for view in self.subviews {
            if let activityView = view as? NVActivityIndicatorView {
                activityView.stopAnimating()
                activityView.removeFromSuperview()
                break
            }
        }
    }
    
    
    func pinEdgesToSuperviewBounds(margin: CGFloat = 0) {
        guard let superview = self.superview else {
            print("Error! `superview` was nil – call `addSubview(view: UIView)` before calling `pinEdgesToSuperviewBounds()` to fix this.")
            return
        }

        self.translatesAutoresizingMaskIntoConstraints = false
        self.topAnchor.constraint(equalTo: superview.topAnchor, constant: margin).isActive = true
        self.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -margin).isActive = true
        self.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: margin).isActive = true
        self.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -margin).isActive = true

    }
    
    @IBInspectable
        var cornerRadius: CGFloat {
            get {
                return layer.cornerRadius
            }
            set {
                layer.cornerRadius = newValue
            }
        }

        @IBInspectable
        var borderWidth: CGFloat {
            get {
                return layer.borderWidth
            }
            set {
                layer.borderWidth = newValue
            }
        }

        @IBInspectable
        var borderColor: UIColor? {
            get {
                let color = UIColor.init(cgColor: layer.borderColor!)
                return color
            }
            set {
                layer.borderColor = newValue?.cgColor
            }
        }

        @IBInspectable
        var shadowRadius: CGFloat {
            get {
                return layer.shadowRadius
            }
            set {
                layer.shadowRadius = newValue
            }
        }
    
        @IBInspectable
        var shadowOffset : CGSize{

            get{
                return layer.shadowOffset
            }set{

                layer.shadowOffset = newValue
            }
        }

        @IBInspectable
        var shadowColor : UIColor{
            get{
                return UIColor.init(cgColor: layer.shadowColor!)
            }
            set {
                layer.shadowColor = newValue.cgColor
            }
        }
    
        @IBInspectable
        var shadowOpacity : Float {

            get{
                return layer.shadowOpacity
            }
            set {

                layer.shadowOpacity = newValue

            }
        }
}
