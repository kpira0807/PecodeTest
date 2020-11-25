import UIKit

class NewsTableViewCell: UITableViewCell {
    
    @IBOutlet var titleActicleLabel: UILabel!
    @IBOutlet var nameSourseLabel: UILabel!
    @IBOutlet var authorLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var imageViewNews: ImageView!
    @IBOutlet var view: CustomView!
    
    static let identifier = "NewsTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "NewsTableViewCell",
                     bundle: nil)
    }
}
