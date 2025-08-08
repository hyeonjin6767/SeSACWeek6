//
//  UIViewController+Extension.swift
//  SeSACWeek6
//
//  Created by 박현진 on 8/7/25.
//

import Foundation
import UIKit

//Generic

/*
 
 + 과제이후 : 공통적인 제약을 뭘로 두어야 할지 어려워 : Numeric말고도 나눗셈,곱하기를 할 수 있는 프로토콜은 다른 것이 존재함
 
 
 */



extension UIViewController {
    
    //여러개 다른 타입 반복적으로 써야 한다는 단점...
    
    // Jack(임의의 네이밍)만 바꿔주면 되는 형태 : Generic(꺽새) :근데 출력은 괜찮은데 덧셈을 하려면 왜 문제가 생길까(그냥 네모박스라서 막 불타입도 들어가고 테이블뷰도 다 들어갈 수 있어서 뎃셈이 문제) :  타입의 제약
    // 모든 타입이 들어갈 수 있는 장점이 있지만 덧셈같은 타입의 제약이 존재 : "클래스기반 제약", "프로토콜 기반(Numeric, 등등)으로 제약"
    //
    
    func total<Jack: Numeric>(a: Jack, b: Jack) -> Jack { //Jack에 Numeric이라는 제약을 주는 방법: 이제 테이블뷰같은건 못들어감
        print(b)
        //return a
        return a + b
    }
    
    
    
    
    //제네릭 사용시 주의점 : 꼭 "사용"을 해줘야
    //꺽새 안에 내용을 "타입 파라미터"(SeSAC) : 전세계적으로 공통으로 T를 많이 사용함(타입파라미터의 약자) : 여기 타입파라미터에도 제약을 줘야함:cornerRadius를 갖고 있을 것 같은 UIView로 제약을 주자 : UIView라는 클래스 제약을 줬다.
    
    //제네릭을 사용할 경우, 선언된 함수에서는 어떤 타입이 들어올 지 알 수 없고, 직접 실행하거나 활용할 떄 타입이 나중에 들어오게 됨: 즉 타입을 유추할 수 없음(사용하려는 곳에서 호출할 때 그때 타입이 결정이 됨): 아래 형태(실행하기 전까지)일때는 T의 타입을 알 수가 없는 제네릭의 단점아닌 단점
    //괜히 제네릭으로 이곳저곳 적용해보고 직접 사용해봐야 함
    //베열이 제네릭 구조로 되어 있음 :
    //심화: 1. swiftUI : Generic ParameterPack(제네릭 파라미터의 갯수를 무한대로 쓸 수 있다?: 최근등장) 2. 역제네릭 타입: 제네릭은 타입을 알 수 없고 사용할 때만 알 수 있는데 역제네릭은 타입을 알지만 귀찮아서 모르게 하는? : opaque type, some view
    func setCornerRadius<T: UIView>(a: T) {
        a.layer.cornerRadius = 10
        a.clipsToBounds = true
    }
//    func setCornerRadius<SeSAC>(a: SeSAC) {
//        a.layer.cornerRadius = 10
//        a.clipsToBounds = true
//    }
    //반복적
//    func setCornerRadius(a: UIImageView) {
//        a.layer.cornerRadius = 10
//        a.clipsToBounds = true
//    }
//    func setCornerRadius(a: UILabel) {
//        a.layer.cornerRadius = 10
//        a.clipsToBounds = true
//    }
//    func setCornerRadius(a: UIButton) {
//        a.layer.cornerRadius = 10
//        a.clipsToBounds = true
//    }
//    
    
    
    
    
    
//    func total<Jack>(a: Jack, b: Jack) -> Jack {
//        print(b)
//        return a
//        //return a + b
//    }
    
//    func total(a: Int, b: Int) -> Int {
//        
//        return a + b
//    }
//    
//    func total(a: Double, b: Double) -> Double {
//        
//        return a + b
//    }
//    
//    func total(a: Float, b: Float) -> Float {
//        
//        return a + b
//    }
}
