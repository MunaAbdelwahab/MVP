//
//  personListViewController.swift
//  DesignPatternMVP
//
//  Created by Muna Abdelwahab on 3/22/21.
//

import UIKit
import NVActivityIndicatorView

class personListViewController: UIViewController, personListView {
    
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var showReloadButton: UIButton!
    
    
    var presenter : personListPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = personListPresenter(view: self)
    }

    func startLoading() {
        activityIndicatorView.startAnimating()
    }
    
    func finishLoading() {
        activityIndicatorView.stopAnimating()
    }
    
    func reloadTableView() {
        tableView.reloadData()
    }
    
    @IBAction func showReloadTapped(_ sender: Any) {
        presenter.getPerson()
    }
    
}

extension personListViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.person.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "personListViewController")
        cell?.textLabel?.text = presenter.person[indexPath.row].first_name
        cell?.detailTextLabel?.text = String(presenter.person[indexPath.row].age)
        return cell!
    }

}
