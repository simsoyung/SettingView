//
//  ViewController.swift
//  SettingView
//
//  Created by 심소영 on 6/3/24.
//

import UIKit

enum SettingCell: Int, CaseIterable{
    case total, personal, others
    
    var mainCell: String {
        switch self {
        case .total: return "전체 설정"
        case .personal: return "개인 설정"
        case .others: return "기타"
        }
    }
    
    var subCell: [String] {
        switch self {
        case .total: return ["공지사항", "실험실", "버전 정보"]
        case .personal: return ["개인/보안","알림", "채팅", "멀티프로필"]
        case .others: return ["고객센터/도움말"]
        }
    }
}

class ViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingTableView()
        navigationItem.title = "설정"
    }
    
    func settingTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        let xib = UINib(nibName: SettingTableViewCell.identifier, bundle: nil)
        tableView.register(xib, forCellReuseIdentifier: SettingTableViewCell.identifier)
        tableView.rowHeight = 50
    }
    
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SettingCell.allCases[section].subCell.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return SettingCell.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.identifier, for: indexPath) as! SettingTableViewCell
        cell.textLabel?.text = SettingCell.allCases[indexPath.section].subCell[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return SettingCell.allCases[section].mainCell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
}

protocol IdProtocol: AnyObject {
    static var identifier: String { get }
}

extension UITableViewCell: IdProtocol {
    static var identifier: String {
        return String(describing: self)
    }
}
