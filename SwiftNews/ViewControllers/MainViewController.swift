//
//  ViewController.swift
//  SwiftNews
//
//  Created by Vineet Sansare on 9/7/19.
//  Copyright © 2019 Loblaw. All rights reserved.
//

import UIKit
import Foundation

class MainViewController: UIViewController {
    
    @IBOutlet private (set) var tableView: UITableView!
    private var articles: [Article]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNewsDataSource()
    }
    
    //MARK: Private Methods
    
    private func setupNewsDataSource() {
        getSwiftNews()
    }
    
    private func setupUI() {
        title = "Swift News"
        setupTableViewUI()
    }
    
    private func setupTableViewUI() {
        let articleListCellNib = UINib(nibName: ArticleListCell.identifier, bundle: Bundle.main)
        tableView.register(articleListCellNib, forCellReuseIdentifier: ArticleListCell.identifier)
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: CGFloat.leastNonzeroMagnitude))
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 150
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showArticleDetails" {
            let viewController = segue.destination  as? ArticleDetailsViewController
            if let articleData = sender as? ArticleData {
                viewController?.articleData = articleData
            }
        }
    }
    
    //MARK: API calls
    
    private func getSwiftNews() {
        ProgressView.shared.showProgressViewNow()
        
        let getSwiftNewsDO = GetSwiftNewsDO()
        getSwiftNewsDO.prepareRequestWithParameters(parameters: nil)
        getSwiftNewsDO.queryTheServer  {
            (baseDO:BaseDO!) in
            
            ProgressView.shared.hideProgressView()
            
            if(baseDO.serverErrorBO != nil) {
                if(baseDO.serverErrorBO!.isSessionExpired) {
                    // Check for session based APIs
                }
                else if(baseDO.serverErrorBO!.errorText != nil) {
                    let errorTextToDisplay = baseDO.serverErrorBO!.errorText!
                    let alertController = UIAlertController(title: "Something's Wrong!", message: errorTextToDisplay, preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "Ok!", style: .default, handler: nil)
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)
                }
            } else {
                // Response received successfully.
                if let getSwiftNewsResponse = (getSwiftNewsDO.responseData as? GetSwiftNewsResponse) {
                    self.articles = getSwiftNewsResponse.data?.articles
                    self.tableView.reloadData()
                }
            }
        }
    }
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = self.articles?.count else { return 0 }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let article = self.articles?[indexPath.row], let cell = tableView.dequeueReusableCell(withIdentifier: ArticleListCell.identifier, for: indexPath) as? ArticleListCell {            
            cell.updateUI(with: article.data as! ArticleListDisplayable)
            cell.selectionStyle = .none
            cell.setNeedsLayout()
            
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let articleData = self.articles?[indexPath.row].data {
            performSegue(withIdentifier: "showArticleDetails", sender: articleData)
        }
    }
}

