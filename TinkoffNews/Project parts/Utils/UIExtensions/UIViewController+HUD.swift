//
// Created by Danil Pestov on 13.10.16.
// Copyright (c) 2016 HOKMT. All rights reserved.
//
import UIKit

extension UIViewController {
    func showAlert(with error: NSError, additionalAction: (() -> Void)? = nil) {
        var message = error.localizedDescription
        if message.isEmpty {
            message = error.domain
        }
        showOkAlert(title: NSLocalizedString("errorAlertTitle", comment: ""), message: NSLocalizedString(message, comment: ""), additionalAction: additionalAction)
    }
    
    func showOkAlert(title: String, message: String? = "", additionalAction: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: NSLocalizedString("alertOkTitle", comment: ""), style: .cancel) { _ in
            alert.dismiss(animated: true, completion: nil)
            if let action = additionalAction {
                action()
            }
        }
        
        alert.addAction(okAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func showHud(_ view: UIView? = nil) {
//        MBProgressHUD.showAdded(to: view ?? self.view, animated: true)
    }
    
    func hideHud(_ view: UIView? = nil) {
//        for subView in (view ?? self.view).subviews {
//            if let hud = subView as? MBProgressHUD {
//                hud.removeFromSuperViewOnHide = true
//                hud.hide(animated: true)
//            }
//        }
    }
    
    func showStatusHud() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func hideStatusHud() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
}
