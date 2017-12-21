//
//  SimpleMVVMTableViewController.swift
//  MVVMDemo
//
//  Created by Geselle-Joy on 2017/12/20.
//  Copyright © 2017年 zhengtou. All rights reserved.
//

import UIKit

extension UIViewController {
    func push(_ viewC: UIViewController) {
        self.navigationController?.pushViewController(viewC, animated: true)
    }
}
// 实现数据绑定
extension SimpleMVVMTableViewController {
    var ob_isRefresh:Obserable<Bool>.ObserableType {
        return { value in
            if value {
                self.tableView.reloadData()
            }
        }
    }
}

class SimpleMVVMTableViewController: UITableViewController {
    
    var viewModel: SimpleMVVMViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.estimatedRowHeight = 100
        self.tableView.register(UINib.init(nibName: "SimpleMVVMTableViewCell", bundle: nil), forCellReuseIdentifier: "SimpleMVVMTableViewCell")
        
        
        
        /*
         MVVM里的页面跳转，有两种方式：
         1. 传入controller
         2. 实现一个跳转block
         */
        
        /*
         self.viewModel = SimpleMVVMViewModel(block: {
             self.tableView.reloadData()
         })
         self.viewModel.getData()
         */
        self.viewModel = SimpleMVVMViewModel(block: {
//            self.tableView.reloadData()
        }, push: { (viewC) in
            self.push(viewC)
        })
        self.viewModel.isRefresh.bind(to: self.ob_isRefresh)
        self.viewModel.getData()
    }

    // MARK: - Table view data source

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
        self.viewModel.selectCell(indexPath.section, indexPath.row)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
