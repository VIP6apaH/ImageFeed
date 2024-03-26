import Foundation
import UIKit
class ProfileViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profilePhoto()
        lable()
        outButton()
    }
    
    
    private func lable() {
        let fioLable = UILabel()
        let nikLable = UILabel()
        let textLable = UILabel()
        
        fioLable.text = "Екатерина Новикова"
        nikLable.text = "@ekaterina_nov"
        textLable.text = "Hello, world!"
        
        fioLable.textColor = .white
        nikLable.textColor = UIColor(named: "YP gray")
        textLable.textColor = .white
        
        fioLable.font = UIFont(name: "SF Pro Обычный ", size:23)
        nikLable.font = UIFont(name: "SF Pro Обычный ", size:13)
        textLable.font = UIFont(name: "SF Pro Обычный ", size:13)
        
        
        fioLable.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(fioLable)
        nikLable.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nikLable)
        textLable.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(textLable)
        
        
        NSLayoutConstraint.activate([
            fioLable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 110),
            fioLable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            nikLable.topAnchor.constraint(equalTo: fioLable.bottomAnchor, constant: 8),
            nikLable.leadingAnchor.constraint(equalTo: fioLable.leadingAnchor),
            textLable.topAnchor.constraint(equalTo: nikLable.bottomAnchor, constant: 8),
            textLable.leadingAnchor.constraint(equalTo: fioLable.leadingAnchor),
        ])
    }
    
    func profilePhoto() {
        let profileImage = UIImage(named: "Photo")
        let imageView = UIImageView(image: profileImage)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        
        imageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 70).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
    }
    
    func outButton() {
        let outButton = UIButton()
        outButton.setImage(UIImage(named:"ipad.and.arrow.forward"), for: .normal)
        
        outButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(outButton)
        
        outButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        outButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 55).isActive = true
        outButton.widthAnchor.constraint(equalToConstant: 44).isActive = true
        outButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
    }
}


