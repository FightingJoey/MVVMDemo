//
//  TableViewController.swift
//  MVVMDemo
//
//  Created by Geselle-Joy on 2017/12/20.
//  Copyright © 2017年 zhengtou. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "简单MVVM，实现拆分Controller"
        case 1:
            cell.textLabel?.text = "实现数据双向绑定"
        default:
            cell.textLabel?.text = "猿题库iOS客户端架构设计"
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let viewC: UIViewController
        switch indexPath.row {
        case 0:
            viewC = SimpleMVVMTableViewController(style: .grouped)
            self.push(viewC)
        case 1:
            viewC = DataBindLoginViewController()
            self.push(viewC)
        default:
            viewC = YuanTableViewController(style: .grouped)
            self.push(viewC)
        }
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
