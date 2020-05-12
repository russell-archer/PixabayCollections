//
//  MetaDataViewController.swift
//  PixabayCollections
//
//  Created by Russell Archer on 11/05/2020.
//  Copyright © 2020 Russell Archer. All rights reserved.
//

import UIKit

class MetaDataViewController: UIViewController {

    var pixabayImage: PixabayImage?
    
    private let tableView = UITableView(frame: .zero)
    private var metadata: [String : String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard pixabayImage != nil else { return }
        metadata = MetaDataHelper.convertDataToDictionary(data: pixabayImage!)
        configureTableView()
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
       
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: UIConstants.padding),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -UIConstants.padding),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
       
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView(frame: .zero)  // Removes empty cells
        tableView.register(MetaDataCell.self, forCellReuseIdentifier: MetaDataCell.reuseId)
    }
}

extension MetaDataViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { 80 }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { metadata.count }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MetaDataCell.reuseId) as! MetaDataCell
        guard let propertyKey = MetaDataHelper.convertRowToDictKey(row: indexPath.row) else { return cell }
        cell.keyLabel.text = propertyKey
        cell.valLabel.text = metadata[propertyKey]
        return cell
    }
}

