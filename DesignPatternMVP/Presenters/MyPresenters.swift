//
//  MyPresenters.swift
//  DesignPatternMVP
//
//  Created by Muna Abdelwahab on 3/22/21.
//

import Foundation

protocol personListView : class {
    func startLoading()
    func finishLoading()
    func reloadTableView()
}

protocol personListViewPresenter {
    init(view: personListView)
    func getPerson()
}

class personListPresenter : personListViewPresenter {
    
    weak var view : personListView?
    var person : [Person]
    
    required init(view: personListView) {
        self.view = view
        self.person = [Person]()
    }
    
    func getPerson() {
        
        view?.startLoading()
        
        let url = URL(string: "https://learnappmaking.com/ex/users.json")
        let request = URLRequest(url: url!)
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task = session.dataTask(with: request) { [self] (data, response, error) in
            do{
                let decoder = JSONDecoder()
                let personArray = try decoder.decode([Person].self, from: data!)
                person = personArray
                DispatchQueue.main.async {
                    view?.reloadTableView()
                    view?.finishLoading()
                }
            }catch let error{
                print(error)
            }
        }
        task.resume()
    }
    
}
