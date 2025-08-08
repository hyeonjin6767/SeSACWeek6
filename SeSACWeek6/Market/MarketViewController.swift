//
//  MarketViewController.swift
//  SeSAC7Week6
//
//  Created by Jack on 8/6/25.
//

import UIKit
import SnapKit

final class MarketViewController: UIViewController {

    lazy var tableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .orange
        tableView.rowHeight = 60
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MarketTableViewCell.self, forCellReuseIdentifier: MarketTableViewCell.identifier)
        return tableView
    }()
   
    var list: [Coin] = [
        Coin(market: "비트코인", korean_name: "코인", english_name: "Coin"),
        Coin(market: "이더리움", korean_name: "이더", english_name: "Eth"),
        Coin(market: "비트코인", korean_name: "비트", english_name: "BTC")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        print(total(a: 3, b: 5))
        print(total(a: 3.5, b: 3.8583))
        
        //Jack에는 어떤 타입이 들어가도 괜춘
        total(a: 67, b: 34)
        total(a: 2.35, b: 4.535)
        total(a: 3, b: 3)
        
        //UIView관련은 다 들어가도 괜춘
        setCornerRadius(a: view)
        
        //어떤 타입도 괜찮은 더미데이터
        DummyData(title: "dgg", sub: 777)
        DummyData(title: view, sub: 9798)
        
        //우리가 쓰던 배열도 제네릭이었음!
        let a: [Int] = [1,2,3] //위아래 원래 같은 의미
        let b: Array<Int> = [8]
        //어레이도 구조체라 재정의도 가능:  인스턴스 생성도 가능
        let c = Array<Int>()
        

        
        callRequest()
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    func callRequest() {
        NetworkManager.shared.callRequest { value in
            self.list = value
            self.tableView.reloadData()
        }
     
    }
}

extension MarketViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: MarketTableViewCell.identifier, for: indexPath) as! MarketTableViewCell
        let row = list[indexPath.row]
        cell.nameLabel.text = row.coinOverview
        cell.backgroundColor = .blue
        
        return cell
    }
    
}

extension MarketViewController {
    func configureHierarchy() {
        view.addSubview(tableView)
    }
    
    func configureLayout() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func configureView() {
        view.backgroundColor = .white
    }
}

