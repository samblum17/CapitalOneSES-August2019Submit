//
//  EducationViewController.swift
//  CapitalOneSES-August2019Submit
//
//  Created by Sam Blum on 6/11/19.
//  Copyright © 2019 Sam Blum. All rights reserved.
//

import UIKit
import SafariServices

/*This VC loads information for lesson plans, people, and places using a segmented control and the same tableView layout for each API pull
*/
class EducationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {


//Variable set up to hold objects used throughout controller for each segment
    var activityIndicatorView: UIActivityIndicatorView!
    var abbreviation: String?
    
    let questionItemController = StoreQuestionsController()
    var returnedQuestionData = [QuestionData]()
    
    let peopleItemController = StorePeopleController()
    var returnedPeopleData = [PeopleData]()
    
    let placesItemController = StorePlacesController()
    var returnedPlacesData = [PlacesData]()
    
    @IBOutlet var questionTableView: UITableView!
    @IBOutlet var educationSegmentControl: UISegmentedControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Allow cell to have dynamic height
        questionTableView.estimatedRowHeight = 260.0
        questionTableView.rowHeight = UITableView.automaticDimension

        }
    
//Show network indicator before data loads and then load data for each segment
    override func viewWillAppear(_ animated: Bool) {
        activityIndicatorView.startAnimating()
        questionTableView.separatorStyle = .none
        fetchMatchingQuestions()
        fetchMatchingPeople()
        fetchMatchingPlaces()
    }
    
//Load network indicator on background view
    override func loadView() {
        super.loadView()
        
        activityIndicatorView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        
        questionTableView.backgroundView = activityIndicatorView
    }
    
//Pull question data from NPS API and load into respective variables
    func fetchMatchingQuestions() {
        
        self.returnedQuestionData = []
        questionTableView.reloadData()
        
        //Set up query dictionary to search any park
        let query: [String: String] = [
            "parkCode" : abbreviation!,
            "api_key" : "0deJt7XudkZrb2wSMFjaLYrHQESBWIQHMNeuM7o1"
        ]
        //Call the itemController to fetch items
        questionItemController.fetchItems(matching: query, completion: { (returnedQuestionData) in
            
            //Load in returned data and update views
            DispatchQueue.main.async {
                if let returnedQuestionData = returnedQuestionData {
                    self.returnedQuestionData = returnedQuestionData
                    self.activityIndicatorView.stopAnimating()
                    self.questionTableView.separatorStyle = .singleLine
                    self.questionTableView.reloadData()
                    
                    //When no results, show alert message
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                    if self.returnedQuestionData.count == 0 {
                        let alertController = UIAlertController(title: "No results", message: "No lessons to display. Either the park you selected does not have lesson information to display or network connection was lost. Please try again or check the NPS website for more info.", preferredStyle: .alert)
                        alertController.addAction(UIAlertAction(title: "Okay", style: .default, handler: {_ in
                            self.navigationController?.popViewController(animated: true)
                        }))
                        self.present(alertController, animated: true, completion: nil)
                    }
                    }
                } else {
                    //Accounts for API load error
                    print("Unable to reload")
                }
            }
        }
        )
    }
    
//Pull people data from NPS API and load into respective variables
    func fetchMatchingPeople() {
        
        self.returnedPeopleData = []
        questionTableView.reloadData()
        
        //Set up query dictionary to search any park
        let query: [String: String] = [
            "parkCode" : abbreviation!,
            "api_key" : "0deJt7XudkZrb2wSMFjaLYrHQESBWIQHMNeuM7o1"
        ]
        //Call the itemController to fetch items
        peopleItemController.fetchItems(matching: query, completion: { (returnedPeopleData) in
            
            //Load in returned data and update views
            DispatchQueue.main.async {
                if let returnedPeopleData = returnedPeopleData {
                    self.returnedPeopleData = returnedPeopleData
                    self.activityIndicatorView.stopAnimating()
                    self.questionTableView.separatorStyle = .singleLine
                    self.questionTableView.reloadData()
                } else {
                    //Accounts for API load error
                    print("Unable to reload")
                }
            }
        }
        )
    }
    
//Pull places data from NPS API and load into respective variables
    func fetchMatchingPlaces() {
        
        self.returnedPlacesData = []
        questionTableView.reloadData()
        
        //Set up query dictionary to search any park
        let query: [String: String] = [
            "parkCode" : abbreviation!,
            "api_key" : "0deJt7XudkZrb2wSMFjaLYrHQESBWIQHMNeuM7o1"
        ]
        //Call the itemController to fetch items
        placesItemController.fetchItems(matching: query, completion: { (returnedPlacesData) in
            
            //Load in returned data and update views
            DispatchQueue.main.async {
                if let returnedPlacesData = returnedPlacesData {
                    self.returnedPlacesData = returnedPlacesData
                    self.activityIndicatorView.stopAnimating()
                    self.questionTableView.separatorStyle = .singleLine
                    self.questionTableView.reloadData()
                } else {
                    //Accounts for API load error
                    print("Unable to reload")
                }
            }
        }
        )
    }
    
/*Reload data respective to current segment when segment is switched and display error messages accordingly
*/
    @IBAction func segmentSwitched(_ sender: UISegmentedControl) {
        /*Use following line to control what happens when each index selected:
            educationSegmentControl.selectedSegmentIndex */
        
        questionTableView.reloadData()
        
        //When no results, show alert message
        if educationSegmentControl.selectedSegmentIndex == 1 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            if self.returnedPeopleData.count == 0 {
                let alertController = UIAlertController(title: "No results", message: "No people to display. Either the park you selected does not have relevant people information to display or network connection was lost. Please try again or check the NPS website for more info.", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Okay", style: .default, handler: {_ in
                    self.navigationController?.popViewController(animated: true)
                }))
                self.present(alertController, animated: true, completion: nil)
            }
            }
        } else if educationSegmentControl.selectedSegmentIndex == 2 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
        if self.returnedPlacesData.count == 0 {
            let alertController = UIAlertController(title: "No results", message: "No places to display. Either the park you selected does not have relevant places information to display or network connection was lost. Please try again or check the NPS website for more info.", preferredStyle: .alert)
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
        if educationSegmentControl.selectedSegmentIndex == 0 {
            return returnedQuestionData.count
            
        } else if educationSegmentControl.selectedSegmentIndex == 1 {
            return returnedPeopleData.count
            
        } else if educationSegmentControl.selectedSegmentIndex == 2 {
            return returnedPlacesData.count
            
        } else {
            return 0
        }

    }

//Load data into cells
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = questionTableView.dequeueReusableCell(withIdentifier: "questionCell", for: indexPath) as! QuestionTableViewCell
        
//Lesson segment
        if educationSegmentControl.selectedSegmentIndex == 0 {
        //When data returned
        if !(returnedQuestionData.count == 0){
            var questionItem = returnedQuestionData[indexPath.row]

        //Mutate returned grade data from JSON for simplicity
            var grade = "Appropiate Grade Level: "
            var returnedGrade = questionItem.gradeLevel ?? "All"
            if let dotRange = returnedGrade.range(of: ":") {
                returnedGrade.removeSubrange(dotRange.lowerBound..<returnedGrade.endIndex)
            }
            grade += returnedGrade
            
        //Load in attributes
            cell.titleLabel.text = questionItem.title
            cell.questionLabel.text = questionItem.question
            cell.gradeLevelLabel.text = grade
            cell.urlButton.setTitle(questionItem.url, for: .normal)
            
            //Open safari view controller on url button tap
            cell.urlButtonAction = { [unowned self] in
                if let url = URL(string: questionItem.url ?? "nps.gov/") {
                    let safariViewController = SFSafariViewController(url: url)
                    self.present(safariViewController,animated: true, completion: nil)
                }
            }
            }
            
//People segment
        } else if educationSegmentControl.selectedSegmentIndex == 1 {
            //When data returned
            if !(returnedPeopleData.count == 0){
                var peopleItem = returnedPeopleData[indexPath.row]
                
                //Load in attributes
                cell.titleLabel.text = peopleItem.title
                cell.questionLabel.text = peopleItem.description
                cell.gradeLevelLabel.isHidden = true
                cell.urlButton.setTitle(peopleItem.url, for: .normal)
                
                //Open safari view controller on url button tap
                cell.urlButtonAction = { [unowned self] in
                    if let url = URL(string: peopleItem.url ?? "nps.gov/") {
                        let safariViewController = SFSafariViewController(url: url)
                        self.present(safariViewController,animated: true, completion: nil)
                    }
                }
            }
//Places segment
        } else if educationSegmentControl.selectedSegmentIndex == 2 {
            //When data returned
            if !(returnedPlacesData.count == 0){
                var placesItem = returnedPlacesData[indexPath.row]
                
                //Load in attributes
                cell.titleLabel.text = placesItem.title
                cell.questionLabel.text = placesItem.description
                cell.gradeLevelLabel.isHidden = true
                cell.urlButton.setTitle(placesItem.url, for: .normal)
                
                //Open safari view controller on url button tap
                cell.urlButtonAction = { [unowned self] in
                    if let url = URL(string: placesItem.url ?? "nps.gov/") {
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

