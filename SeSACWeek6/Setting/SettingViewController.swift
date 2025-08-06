//
//  SettingViewController.swift
//  SeSAC7Week6
//
//  Created by Jack on 8/6/25.
//

import UIKit
import SnapKit


//디자이너가 섹션 "순서 변경 수정"을 요구할 경우 대비 : enum을 사용하면 case의 순서만 변경하면 간단해짐
//열거형 배열
enum Setting: String, CaseIterable { //CaseIterable이라는 프로토콜 채택
    case setting = "설정" //고유한 내용(중복불가)이 케이스에 들어가
    case personal = "개인정보"
    
    
    case push = "푸시설정" //하나더 추가할 경우
    
    
    case version = "버전정보"
    
    //각각의 케이스에 대해 배열을 받아보자: 디테일이라는 연산프로퍼티를 활용
    var detail: [String] { //여기 순서는 상관X
        switch self {
        case .setting:
            return ["알림", "채팅", "친구"]
        case .version:
            return ["개인정보처리방침", "오픈소스라이센스", "기타"]
        case .personal:
            return ["프로필 수정", "회원탈퇴"]
        case .push:
            return ["eth", "rfh", "svgsd", "sds"]
        }
    }
}

class SettingViewController: UIViewController {
    
    //let list = ["설정", "버전정보", "개인정보"]
    //위에꺼 대신 "열거형 배열" 사용
    let list = Setting.allCases //만들어둔 "순서대로" 가져옴
    
//    let detail = ["알림", "채팅", "친구"]
//    let info = ["프로필 수정", "회원탈퇴"]
//    let version = ["개인정보처리방침", "오픈소스라이센스", "기타"]
    //위로 디테일 연산프로퍼티로 복붙함
    
    lazy var tableView = {
        let tableView = UITableView()
        tableView.rowHeight = 80
        tableView.delegate = self
        tableView.allowsSelection = false
        tableView.dataSource = self
        tableView.register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.identifier)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        //디테일 연산프로퍼티를 어떻게 가져올까 : 찍어보자
        print(Setting.personal.rawValue)
        print(Setting.personal.detail)
        print(Setting.personal.detail[0])
        print(Setting.personal.detail[1])

    
        
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
}

extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    
    //섹션을 만들어보자
    func numberOfSections(in tableView: UITableView) -> Int {
        
        //return list.count
        return Setting.allCases.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        //섹션 제목
        
        
        //return list[section].rawValue //rawValue:뒤에 스트링 타입을 가져옴
        return Setting.allCases[section].rawValue
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
//        if section == 0 {
//            return detail.count
//        } else if section == 1 {
//            return version.count
//        } else {
//            return info.count
//        }
        
//        if section == 0 {
//            return Setting.setting.detail.count
//        } else if section == 1 {
//            return Setting.version.detail.count
//        } else {
//            return Setting.personal.detail.count
//        }
        
//        if section == 0 {
//            return Setting.allCases[0].detail.count
//        } else if section == 1 {
//            return Setting.allCases[1].detail.count
//        } else {
//            return Setting.allCases[2].detail.count
//        }
//
//        if section == 0 {
//            return Setting.allCases[section].detail.count
//        } else if section == 1 {
//            return Setting.allCases[section].detail.count
//        } else {
//            return Setting.allCases[section].detail.count
//        }
        
        return Setting.allCases[section].detail.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.identifier, for: indexPath) as? SettingTableViewCell else {
            return UITableViewCell()
        }
        
        
//        if indexPath.section == 0 {
//            let row = detail[indexPath.row]
//            cell.settingLabel.text = row
//            
//        } else if indexPath.section == 1 {
//            let row = version[indexPath.row]
//            cell.settingLabel.text = row
//            
//        } else {
//            let row = info[indexPath.row]
//            cell.settingLabel.text = row
//        }
        
//        if indexPath.section == 0 {
//            let row = Setting.setting.detail[indexPath.row]
//            cell.settingLabel.text = row
//            
//        } else if indexPath.section == 1 {
//            let row = Setting.version.detail[indexPath.row]
//            cell.settingLabel.text = row
//            
//        } else {
//            let row = Setting.personal.detail[indexPath.row]
//            cell.settingLabel.text = row
//        }
        
//        if indexPath.section == 0 {
//            let row = Setting.allCases[0].detail[indexPath.row]
//            cell.settingLabel.text = row
//            
//        } else if indexPath.section == 1 {
//            let row = Setting.allCases[1].detail[indexPath.row]
//            cell.settingLabel.text = row
//            
//        } else {
//            let row = Setting.allCases[2].detail[indexPath.row]
//            cell.settingLabel.text = row
//        }
        
        let row = Setting.allCases[indexPath.section].detail[indexPath.row]
        cell.settingLabel.text = row
        
        
        return cell
        
    }
}


extension SettingViewController {
    
    func configureHierarchy() {
        view.addSubview(tableView)
    }
    
    func configureLayout() {
        
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
    }
    
    func configureView() {
        navigationItem.title = "네비게이션 타이틀"
        view.backgroundColor = .white
    }
}
