//
//  YuanViewModel.swift
//  MVVMDemo
//
//  Created by Geselle-Joy on 2017/12/21.
//  Copyright © 2017年 zhengtou. All rights reserved.
//

import UIKit

class YuanViewModel {
    
    var sections: Array<HomeSection>
    
    static func viewModel(dataSource: Array<HomeSection>) -> YuanViewModel {
        return YuanViewModel(dataSource)
    }
    
    init(_ dataSource: Array<HomeSection>) {
        self.sections = dataSource
    }
    
    init() {
        self.sections = []
    }
    
    func selectCell(_ section: Int, _ row: Int, controller: UIViewController) {
        let url = sections[section].items[row].url
        let webActivity = BrowserWebViewController(url: URL(string: url)!)
        controller.push(webActivity)
    }
    
}
