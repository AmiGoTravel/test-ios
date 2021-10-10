import UIKit

protocol Storyboarded {
    static func instantiate() -> Self
}

extension Storyboarded where Self: UIViewController {
    static func instantiate() -> Self {
        let fullName = NSStringFromClass(self)
        let controllerName = fullName.components(separatedBy: ".")[1]
        let storyboardName = controllerName.components(separatedBy: "ViewController")[0]
        let storyboard = UIStoryboard(name: storyboardName, bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: controllerName) as! Self
    }
}
