
import UIKit
import CoreData

class TableViewController: UITableViewController {
        
    var dataModel: DataModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Главная"
        setupNavigationAppearance()
        setupTable()
        loadData()
    }
    
    func setupNavigationAppearance () {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .systemPurple
        appearance.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .bold),
                                          NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.standardAppearance = appearance;
        navigationController?.navigationBar.scrollEdgeAppearance =  navigationController?.navigationBar.standardAppearance
    }
    
    func setupTable() {
        tableView.register(UINib(nibName: String(describing: TableViewCell.self), bundle: nil), forCellReuseIdentifier: "TableViewCell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.backgroundColor = .secondarySystemBackground
    }
    
    func loadData () {
        DataLoader().loadPosts { model in
            DispatchQueue.main.async {
                self.dataModel = model
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.dataModel?.posts.count ?? 0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        
        if let post = self.dataModel?.posts[indexPath.row] {
            cell.titleLabel?.text = post.title
            cell.subtitleLabel?.text = post.preview_text
            cell.likesCount?.text = "\(post.likes_count)"
            cell.dateLabel.text = post.formattedDateString()
            
            if cell.subtitleLabel.numberOfVisibleLines > 2 {
                cell.showMoreButtonView.isHidden = false
                cell.showMoewButton.addTarget(self, action: #selector(showMoreButtonAction(_:)), for: .touchUpInside)
                if dataModel?.expandedPosts.contains(post.postId) == true {
                    cell.subtitleLabel.numberOfLines = 0
                    cell.showMoewButton.setTitle("Show less", for: .normal)
                } else {
                    cell.subtitleLabel.numberOfLines = 2
                    cell.showMoewButton.setTitle("Show more", for: .normal)
                }
            } else {
                cell.showMoreButtonView.isHidden = true
            }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let post = dataModel?.posts[indexPath.row]
        DataLoader().loadPostById(id: post?.postId as? Int ?? 0)
        performSegue(withIdentifier: "goToOnePosts", sender: post)
        tableView.deselectRow(at: indexPath, animated: true)
     
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let article = sender as? Post {
            (segue.destination as? OnePostsViewController)?.post = article
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    @objc func showMoreButtonAction(_ sender: UIButton) {
        let viewFrame = tableView.convert(sender.bounds, from: sender)
        let cellCenter = CGPoint(x: viewFrame.midX, y: viewFrame.midY)
        if let indexPath = tableView.indexPathForRow(at: cellCenter), let post = dataModel?.posts[indexPath.row] {
            if dataModel?.expandedPosts.contains(post.postId) == false {
                dataModel?.expandedPosts.append(post.postId)
            } else {
                dataModel?.expandedPosts.removeAll(where: { postId in
                    post.postId == postId
                })
            }
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }

    // MARK: - sorting
    @IBAction func presentSortOptionsActionSheet(_ sender: Any) {
        
        let alertController = UIAlertController(title: "Sort Posts", message: nil, preferredStyle: .actionSheet)
        
        let sortByDateAction = UIAlertAction(title: "Sort by time ᐁ", style: .default, handler: { (action) -> Void in
            self.sortPostsByDate(ascending: false)
        })
        alertController.addAction(sortByDateAction)

        let sortByDateActionAccending = UIAlertAction(title: "Sort by time ᐃ", style: .default, handler: { (action) -> Void in
            self.sortPostsByDate(ascending: true)
        })
        alertController.addAction(sortByDateActionAccending)

        let sortByLikesAction = UIAlertAction(title: "Sort by likes ᐁ", style: .default, handler: { (action) -> Void in
            self.sortPostsByLikes(ascending: false)
        })
        alertController.addAction(sortByLikesAction)

        let sortByLikesActionAccending = UIAlertAction(title: "Sort by likes ᐃ", style: .default, handler: { (action) -> Void in
            self.sortPostsByLikes(ascending: true)
        })
        alertController.addAction(sortByLikesActionAccending)
        
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) -> Void in
        })
        alertController.addAction(cancelButton)
        
        self.navigationController!.present(alertController, animated: true, completion: nil)
    }
    
    func sortPostsByDate(ascending: Bool) {
        self.dataModel?.sortPostsByDate(ascending: ascending)
        self.tableView.reloadData()
    }
    
    func sortPostsByLikes(ascending: Bool) {
        self.dataModel?.sortPostsByRating(ascending: ascending)
        self.tableView.reloadData()
    }
}

