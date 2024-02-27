import UIKit
import Foundation
extension UIViewController {
    func showToast(message: String) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        
        self.present(alertController, animated: true, completion: nil)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            alertController.dismiss(animated: true, completion: nil)
        }
    }
}
