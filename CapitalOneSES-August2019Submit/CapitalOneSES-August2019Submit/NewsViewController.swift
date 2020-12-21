//
//  NewsViewController.swift
//  CapitalOneSES-August2019Submit
//
//  Created by Sam Blum on 6/11/19.
//  Copyright © 2019 Sam Blum. All rights reserved.
//

import UIKit
import SafariServices

/*This VC loads information for articles and news releases using a segmented control and the same tableView layout for each API pull
 */
class NewsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //Variable set up to hold objects used throughout controller for each segment
    var activityIndicatorView: UIActivityIndicatorView!
    var abbreviation: String?
    
    let newsItemController = StoreNewsController()
    var returnedNewsData = [NewsReleaseData]()
    
    let articleItemController = StoreArticlesController()
    var returnedArticleData = [ArticleData]()
    
    @IBOutlet var newsTableView: UITableView!
    @IBOutlet var newsSegmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Allow cell to have dynamic height
        newsTableView.estimatedRowHeight = 260.0
        newsTableView.rowHeight = UITableView.automaticDimension

        // Do any additional setup after loading the view.
    }
    
//Show network indicator before data loads and then load data for each segment
    override func viewWillAppear(_ animated: Bool) {
        activityIndicatorView.startAnimating()
        newsTableView.separatorStyle = .none
        fetchMatchingNews()
        fetchMatchingArticles()
    }

//Load network indicator on background view
    override func loadView() {
        super.loadView()
        
        activityIndicatorView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        
        newsTableView.backgroundView = activityIndicatorView
    }
    
    
//Pull news data from NPS API and load into respective variables
    func fetchMatchingNews() {
        
        self.returnedNewsData = []
        newsTableView.reloadData()
        
        //Set up query dictionary to search any park
        let query: [String: String] = [
            "parkCode" : abbreviation!,
            "api_key" : "0deJt7XudkZrb2wSMFjaLYrHQESBWIQHMNeuM7o1"
        ]
        //Call the itemController to fetch items
        newsItemController.fetchItems(matching: query, completion: { (returnedNewsData) in
            
            //Load in returned data and update views on highest priority queue
            DispatchQueue.main.async {
                if let returnedNewsData = returnedNewsData {
                    self.returnedNewsData = returnedNewsData
                    self.activityIndicatorView.stopAnimating()
                    self.newsTableView.separatorStyle = .singleLine
                    self.newsTableView.reloadData()
                } else {
                    //Accounts for API load error
                    print("Unable to reload")
                }
            }
        }
        )
    }
    
//Pull articles data from NPS API and load into respective variables
    func fetchMatchingArticles() {
        
        self.returnedArticleData = []
        newsTableView.reloadData()
        
        //Set up query dictionary to search any park
        let query: [String: String] = [
            "parkCode" : abbreviation!,
            "api_key" : "0deJt7XudkZrb2wSMFjaLYrHQESBWIQHMNeuM7o1"
        ]
        //Call the itemController to fetch items
        articleItemController.fetchItems(matching: query, completion: { (returnedArticleData) in
            
            //Load in returned data and update views
            DispatchQueue.main.async {
                if let returnedArticleData = returnedArticleData {
                    self.returnedArticleData = returnedArticleData
                    self.activityIndicatorView.stopAnimating()
                    self.newsTableView.separatorStyle = .singleLine
                    self.newsTableView.reloadData()
                } else {
                    //Accounts for API load error
                    print("Unable to reload")
                }
            }
        }
        )
    }
    
/*Reload data respective to current segment when segment is switched and display error messages accordingly */
    @IBAction func segmentSwitched(_ sender: UISegmentedControl) {
        
        newsTableView.reloadData()
        
        //When no results, show alert message
        if newsSegmentedControl.selectedSegmentIndex == 0 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            if self.returnedArticleData.count == 0 {
                let alertController = UIAlertController(title: "No results", message: "No articles to display. Either the park you selected does not have article information to display or network connection was lost. Please try again or check the NPS website for more info.", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Okay", style: .default, handler: {_ in
                    self.navigationController?.popViewController(animated: true)
                }))
                self.present(alertController, animated: true, completion: nil)
            }
            }
            
        }
        if newsSegmentedControl.selectedSegmentIndex == 1 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            if self.returnedNewsData.count == 0 {
                let alertController = UIAlertController(title: "No results", message: "No news releases to display. Either the park you selected does not have news release information to display or network connection was lost. Please try again or check the NPS website for more info.", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Okay", style: .default, handler: {_ in
                    self.navigationController?.popViewController(animated: true)
                }))
                self.present(alertController, animated: true, completion: nil)
            }
            }
       
        }
    }
    
//Number of rows corresponds to array item count in each segment
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if newsSegmentedControl.selectedSegmentIndex == 1 {
            return returnedNewsData.count

        } else if newsSegmentedControl.selectedSegmentIndex == 0 {
            return returnedArticleData.count

        } else {
            return 0
        }
        
    }
    
//Load data into cells
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = newsTableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as! NewsTableViewCell

            
//Articles segment
        if newsSegmentedControl.selectedSegmentIndex == 0 {
            //When data returned
            if !(returnedArticleData.count == 0){
                var articleItem = returnedArticleData[indexPath.row]

                //Load in attributes
                cell.titleLabel.text = articleItem.title
                cell.descriptionLabel.text = articleItem.description
                cell.urlButton.setTitle(articleItem.url, for: .normal)
                
                //Open safari view controller on url button tap
                cell.urlButtonAction = { [unowned self] in
                    if let url = URL(string: articleItem.url ?? "nps.gov/") {
                        let safariViewController = SFSafariViewController(url: url)
                        self.present(safariViewController,animated: true, completion: nil)
                    }
                }
            }
            
//News releases segment
        } else if newsSegmentedControl.selectedSegmentIndex == 1 {
            //When data returned
            if !(returnedNewsData.count == 0){
                var newsItem = returnedNewsData[indexPath.row]
                
                //Load in attributes
                cell.titleLabel.text = newsItem.title
                cell.descriptionLabel.text = newsItem.description
                cell.urlButton.setTitle(newsItem.url, for: .normal)
                
                //Open safari view controller on url button tap
                cell.urlButtonAction = { [unowned self] in
                if let url = URL(string: newsItem.url ?? "nps.gov/") {
                    let safariViewController = SFSafariViewController(url: url)
                    self.present(safariViewController,animated: true, completion: nil)
                }
            }
          }
        }
        return cell
    }
    
    
    
//Height of cells is dynamic
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
