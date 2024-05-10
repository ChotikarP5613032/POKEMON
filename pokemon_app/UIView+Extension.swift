import UIKit

extension UIView {
    @IBInspectable
    var cornerRadius: CGFloat {
        set { layer.cornerRadius = newValue }
        get { return layer.cornerRadius }
    }
    
    @IBInspectable
    var alpha: CGFloat {
        set { self.alpha = newValue }
        get { return self.alpha }
    }
    
    @IBInspectable
    var borderWeight: CGFloat {
        set { layer.borderWidth = newValue }
        get { return layer.borderWidth}
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        set { layer.borderColor = newValue?.cgColor }
        get {  guard let color = layer.borderColor else {
            return nil
        }
        return UIColor(cgColor: color)}
    }
}
