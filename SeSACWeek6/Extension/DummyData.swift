//
//  DummyData.swift
//  SeSACWeek6
//
//  Created by 박현진 on 8/7/25.
//

import Foundation
import UIKit


/*
다양한 API를 호출하면서.. 다양한 내용들을 받아볼 수 있었을텐데..
이 데이터들이 다 타입이 다양해서
 다양한 타입의 데이터들을 받을 수 있는 더미데이터를 만들어보자
 

*/

//여러타입을 받고 싶다면 쉼표쓰고 여러개 나열 가능: U : 2개이상 잘 안써
struct DummyData<T, U> {
    let title: T
    let sub: U
}

//이렇게 여러 구조체를 만드는 대신 제네릭
struct DummyTrend {
    let id: Int
    let genreIds: [Int]
    
}
struct DummyImage {
    let path: String
    let id: Int
    
}
struct DummySearch {
    
    
}
struct Dummy {
    
    
}
