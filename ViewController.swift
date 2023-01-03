//
//  ViewController.swift
//  RxSwift Intro
//
//  Created by Cristian Macovei on 02.01.2023.
// A small introduction into RxSwift showcasing a TableView functionality and the key differences to using the Delegate properties

import UIKit
import RxSwift
import RxCocoa

struct Product {
    let imageName: String
    let title: String
}

struct ProductViewModel {
    
    // items is of type PublishSubject which has a collection of type 'Product'.
    var items = PublishSubject<[Product]>()
    
    func fetchItems() {
        let products = [
        Product(imageName: "house", title: "Home"),
        Product(imageName: "gear", title: "Settings"),
        Product(imageName: "person.circle", title: "Profile"),
        Product(imageName: "airplane", title: "Flights"),
        Product(imageName: "bell", title: "Activity")
        ]
        // Tell our items that the next collection is products
        items.onNext(products)
        // Tell our items (publisher), allow the observer that the data has changed and is completed
        items.onCompleted()
    }
    
}

class ViewController: UIViewController {

    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self
                       , forCellReuseIdentifier: "cell")
        return table
    }()
    
    private var viewModel = ProductViewModel()
    
    private var bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        tableView.frame = view.bounds
        bindTableData()
        
    }
    
    func bindTableData() {
        //Bind items to table
        viewModel.items.bind(to: tableView.rx.items(
            cellIdentifier: "cell",
            cellType: UITableViewCell.self)
        ) { row, model, cell in
            cell.textLabel?.text = model.title
            cell.imageView?.image = UIImage(systemName: model.imageName)
        }.disposed(by: bag)
        
        //Bind a model selected handler
        tableView.rx.modelSelected(Product.self).bind { product in
            print(product.title)
        }.disposed(by: bag)
        
        //Fetch our items
        viewModel.fetchItems()
        
    }


}

