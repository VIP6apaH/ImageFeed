import Foundation

import UIKit
final class SingleImageViewController: UIViewController {
    @IBAction private func didTapBackButton() {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didTapShareButton(_ sender: Any) {
        let items:[Any] = [image!]
        let shareTuch = UIActivityViewController(activityItems: items, applicationActivities: nil)
        present(shareTuch, animated: true, completion: nil)
    }
    
    var image: UIImage! {
        didSet {
            guard isViewLoaded else { return }
            imageFull.image = image
            rescaleAndCenterImageInScrollView(image: image)
            
            
        }
    }
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet private var imageFull: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.minimumZoomScale = 0.1
        scrollView.maximumZoomScale = 1.25
        imageFull.image = image
        imageFull.frame.size = image.size
        rescaleAndCenterImageInScrollView(image: image)
        
        
    }
    
    
    private func rescaleAndCenterImageInScrollView(image: UIImage) {
        let minZoomScale = scrollView.minimumZoomScale
        let maxZoomScale = scrollView.maximumZoomScale
        view.layoutIfNeeded()
        let visibleRectSize = scrollView.bounds.size
        let imageSize = image.size
        let hScale = visibleRectSize.width / imageSize.width
        let vScale = visibleRectSize.height / imageSize.height
        let scale = min(maxZoomScale, max(minZoomScale, max(hScale, vScale)))
        scrollView.setZoomScale(scale, animated: false)
        scrollView.layoutIfNeeded()
        let newContentSize = scrollView.contentSize
        let x = (newContentSize.width - visibleRectSize.width) / 2
        let y = (newContentSize.height - visibleRectSize.height) / 2
        scrollView.setContentOffset(CGPoint(x: x, y: y), animated: false)
    }
    
    private func goToCenter (){
        let horizontalInset = max(0, (scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5)
        scrollView.contentInset = UIEdgeInsets(top: 0, left: horizontalInset, bottom: 0, right: horizontalInset)
        let verticalInset = max(0, (scrollView.bounds.size.height - scrollView.contentSize.height * scrollView.zoomScale) * 0.5)
        scrollView.contentInset = UIEdgeInsets(top: verticalInset, left: horizontalInset, bottom: verticalInset, right: horizontalInset)
        
    }
    
}
extension SingleImageViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        imageFull
    }
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        self.goToCenter()
    }
}
