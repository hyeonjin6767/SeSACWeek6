//
//  ViewController.swift
//  SeSACWeek6
//
//  Created by 박현진 on 8/4/25.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //이런게 생각보다 잘 안됐던 이유: 버전의 문제 ios15이후로 ui와 네비게이션/탭바가 조금 달라짐..
        //네비/탭바의 Appearance 개념 등장 : standard(스크롤이 되는 화면의 ui) & scrollEdge(스크롤이 안되는 화면에 대한 ui)
        navigationController?.navigationBar.tintColor = .yellow

    }


}

