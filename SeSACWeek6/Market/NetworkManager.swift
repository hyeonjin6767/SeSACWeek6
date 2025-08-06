//
//  NetworkManager.swift
//  SeSAC7Week6
//
//  Created by Jack on 8/6/25.
//

import Foundation
import Alamofire



//final을 붙이면 상속이 안된다.
//final을 붙이지 않으면 / 컴파일 타임에 어떤 메서드가 실행이 될지 명확하게 알기는 어렵다
//final을 붙이면 / 재정의(override)도, 상속도 안되서 컴파일 타임에 어떤 메서드가 실행이 될지 명확히 알 수 있다(상속 못받으니 다른곳에서 안쓰인다는것도 알고 재정의도 안되기 때문에 정확히 이 메서드만 실행이 된다는 걸 알수 있음): 그러면 런타임 상황에서 할일이 상대적으로 많이 줄어든다(컴터의 할일을 줄여주는 컴파일 최적화: 파이널로 정확한 연결고리를 알려주는 샘)
//열거형, 구조체는 클래스와 달리 상속될 수도 없으니 얘들이 가진 메서드가 컴파일 타임에 실행될지 명확히 알수 있기 때문에 "final calss", "enum", "struct"는 컴파일 타임에 실행될지 알 수 있는 요소가 되므로 이 3가지는 "컴파일 최적화"라고 한다: 컴파일 타임에 미리 연결고리들을 명확히 알려주면 런타임전에 할 일들을 많이 줄어들 수 있으니 최적화를 달성할 수 있다

//Method Dispatch : 메서드가 컴파일타임(빌드하는 시간)에 실행(이미 정해져 있는 것이기 때문에:static dispatch 방식)이 되는게 결정되는지 런타임에 실행(dynamic dispatch 방식)이 되는게 결정이 되는지 얘기를 해주는 것.
//다이나믹 디스패치(ex.클래스안에 메서드)로 동작을 하는 것은 스태틱 메서드로 동작하는 것보다는 상대적으로 성능이 떨어짐 : 그래서 final를 클래스를 붙이면 스태틱 디스패치 방식으로 동작하게끔 변경이 되면서 성능을 조금 달성할 수 있다. + struct, enum은 메서드가 재정의가 될 수가 없으니까 기본적으로 스태틱 디스패치 방식으로 동작을 함

//즉, "상속받아 쓰지 않을 클래스에는 static dispatch 방식으로 동작할 수 있게 final을 붙여라"

class Coffee { //부모
    func make() {}
}
class Americano: Coffee { //자식
    
    //make에 대한 재정의 : final를 붙여서 상속불가인 부모이면 메서드의 재정의도 불가
    override func make() {
        super.make() //슈퍼가 없으면 부모는 실행안되고, 있으면 부모가 실행이 되고
    }
}


//상속할 필요가 없는 클래스는 final(상속불가로 만듬)로 쓰자

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() { }
     
    func callRequest(completionHandler: @escaping ([Coin]) -> Void) {
        
        
        Americano().make() //아메리카노라는 인스턴스의 메이크 메서드를 실행
        //이건 아메리카노의 메이크인가 커피의 메이크인가, 부모가 얼마나 많은지 는 위에 것만 보고 알 수는 없음..
        //컴파일 타임에서는 메이크라는 메서드가 어디까지 실행되는지, 누구의 메이크가 실행되는지 알 수 없음
        
        
        let url = "https://api.upbit.com/v1/market/all"
        AF.request(url, method: .get)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: [Coin].self) { response in
                print(#function, "두번째")
                switch response.result {
                case .success(let value):
                    print("success", value)
                    completionHandler(value)
                case .failure(let error):
                    print("fail", error)
                }
            }
        print(#function, "세번째")
    }
    
}

