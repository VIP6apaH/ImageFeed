import Foundation
import UIKit
final class ImagesListCell: UITableViewCell {
    
  static let reuseIdentifier = "ImagesListCell"

    @IBOutlet var LikeButtom: UIButton!
    @IBOutlet var cellImage: UIImageView!
    @IBOutlet var dateLabel: UILabel!

}

class GradientView:UIView {
    private let gradientlayer = CAGradientLayer()
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupGradient()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientlayer.frame = bounds
        

    }
    private func setupGradient() {
        self.layer.addSublayer(gradientlayer)
        let blackColor = UIColor.black
        gradientlayer.colors = [blackColor.withAlphaComponent(0.0).cgColor, blackColor.withAlphaComponent(1.0).cgColor]
    }
}


