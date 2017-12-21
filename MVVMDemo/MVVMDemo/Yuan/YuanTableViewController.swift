//
//  YuanTableViewController.swift
//  MVVMDemo
//
//  Created by Geselle-Joy on 2017/12/21.
//  Copyright © 2017年 zhengtou. All rights reserved.
//

import UIKit

class YuanTableViewController: UITableViewController {

    var viewModel: YuanViewModel = YuanViewModel()
    
    var dataController: DataController = DataController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.estimatedRowHeight = 100
        self.tableView.register(UINib.init(nibName: "SimpleMVVMTableViewCell", bundle: nil), forCellReuseIdentifier: "SimpleMVVMTableViewCell")
        
        fetchData()
    }
    
    func fetchData() {
        dataController.getData {
            self.renderView()
        }
    }
    
    func renderView() {
        let viewModel = YuanViewModel.viewModel(dataSource: dataController.sections)
        self.bindData(viewModel: viewModel)
    }
    
    func bindData(viewModel: YuanViewModel) {
        self.viewModel = viewModel
        self.tableView.reloadData()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.viewModel.sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.sections[section].items.count
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SimpleMVVMTableViewCell = tableView.dequeueReusableCell(withIdentifier: "SimpleMVVMTableViewCell", for: indexPath) as! SimpleMVVMTableViewCell
        let item = self.viewModel.sections[indexPath.section].items[indexPath.row]
        cell.gankTitle?.text = item.desc
        cell.gankAuthor.text = item.who
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.viewModel.selectCell(indexPath.section, indexPath.row, controller: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
