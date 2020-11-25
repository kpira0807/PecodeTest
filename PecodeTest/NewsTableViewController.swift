import UIKit
import Foundation

class NewsTableViewController: UITableViewController {
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // register cell for table
        tableView.register(NewsTableViewCell.nib(), forCellReuseIdentifier: NewsTableViewCell.identifier)
        
        requesNews()
    }
    
    var acticle = [Articles]()
    
    func requesNews() {
        activityIndicator.startAnimating()
        let url = "https://newsapi.org/v2/top-headlines?country=ua&apiKey=d254fa58173f4bbcbca714f93d225ff6"
        
        URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: {data, response, error in
            
            // Validation
            guard let data = data, error == nil else {
                print("Error 1: \(error)")
                return
            }
            // Convert data to models
            var json: NewsAPI?
            do {
                json = try JSONDecoder().decode(NewsAPI.self, from: data)
            }
            catch {
                print("Error 2: \(error)")
            }
            
            guard let result = json else {
                return
            }
            
            let arcticle = result.articles
            self.acticle.append(contentsOf: arcticle)
            print(result.status.count)
            
            // Update user interfase
            DispatchQueue.main.async {
                self.activityIndicator.isHidden = true
                self.activityIndicator.stopAnimating()
                self.tableView.reloadData()
            }
            
        }).resume()
    }
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return acticle.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell") as? NewsTableViewCell  else {return UITableViewCell()}
        
        let acticles = acticle[indexPath.row]
        cell.titleActicleLabel.text = acticles.title        
        cell.nameSourseLabel.text = acticles.source.name
        cell.authorLabel.text = acticles.author
        cell.descriptionLabel.text = acticles.description
        cell.imageViewNews.set(urlString: acticles.urlToImage  ?? "")
        
        if indexPath.row % 2 == 0 {
            cell.view.layer.borderColor = UIColor.purpurColor.cgColor
        } else {
            cell.view.layer.borderColor = UIColor.greenColor.cgColor
        }
        
        return cell
    }
}
