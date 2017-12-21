//
//  DataBindLoginViewController.swift
//  MVVMDemo
//
//  Created by Geselle-Joy on 2017/12/20.
//  Copyright © 2017年 zhengtou. All rights reserved.
//

import UIKit

extension UILabel {
    var ob_isHidden:Obserable<Bool>.ObserableType {
        return { value in
            self.isHidden = value
        }
    }
}

extension UIButton {
    var ob_isEnabled: Obserable<Bool>.ObserableType {
        return { value in
            self.isEnabled = value
            switch value {
            case true:
                self.backgroundColor = UIColor.blue
            case false:
                self.backgroundColor = UIColor.groupTableViewBackground
            }
        }
    }
    
}

class DataBindLoginViewController: UIViewController {

    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var usernamePromptL: UILabel!
    @IBOutlet weak var passwdTF: UITextField!
    @IBOutlet weak var passwdPromptL: UILabel!
    @IBOutlet weak var loginBtn: UIButton!
    
    var viewModel: DataBindLoginViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = DataBindLoginViewModel()
        viewModel.usernamePromptIsHidden.bind(to: self.usernamePromptL.ob_isHidden)
        viewModel.passwdPromptIsHidden.bind(to: self.passwdPromptL.ob_isHidden)
        viewModel.btnIsEnabled.bind(to: self.loginBtn.ob_isEnabled)
        
        self.usernameTF.addTarget(self, action: #selector(usernameTFDidChangeValue(_:)), for: UIControlEvents.editingChanged)
        self.passwdTF.addTarget(self, action: #selector(passwdTFDidChangeValue(_:)), for: UIControlEvents.editingChanged)
    }
    
    @objc func usernameTFDidChangeValue(_ TF: UITextField) {
        guard let username = TF.text else {
            return
        }
        viewModel.usernameChange(username)
    }
    
    @objc func passwdTFDidChangeValue(_ TF: UITextField) {
        guard let passwd = TF.text else {
            return
        }
        viewModel.passwdChange(passwd)
    }
    
    @IBAction func loginBtnClicked(_ sender: Any) {
        let str = "用户名：\(viewModel.model.username.value) \n 密码：\(viewModel.model.passwd.value)"
        print(str)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

