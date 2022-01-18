

import UIKit

class FailureView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    var completion : (() -> ())?
    
    class func instanceFromNib() -> FailureView {
        return UINib(nibName: "FailureView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! FailureView
    }
    
    @IBAction func tryAgainPressed(_ sender: Any) {
        if let completion = self.completion {
            completion()
        }
    }
    

}
