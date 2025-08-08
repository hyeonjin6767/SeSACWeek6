//
//  DecodableViewController.swift
//  SeSACWeek6
//
//  Created by 박현진 on 8/7/25.
//

import UIKit


struct Movie: Decodable {
    
    let movieTitle: String
    let likeCount: Int
    let director: String
    
    let isTopRank: Bool
    
    //자동채움
    enum CodingKeys: String, CodingKey {
        case movieTitle = "movie_title"
        case likeCount = "like_count"
        case director
    }
    //자동채움
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.movieTitle = try container.decode(String.self, forKey: .movieTitle)
        self.likeCount = try container.decode(Int.self, forKey: .likeCount)
        // 디렉터에 널값을 받으려면 decodeIfPresent로 변경
        self.director = try container.decodeIfPresent(String.self, forKey: .director) ?? "감독 없음" //옵셔널을 위에 스트링에 처리하지 않고 여기에서 ??로 처리 : 서버에서 옵셔널 값이 들어온다해도 잘 처리하기 위한 : 서버관리가자 키를 갑자기 바꾸거나 문제가 생겼을 때의 미리 대처할 수 있는 방법
        
        self.isTopRank = (10000...).contains(likeCount) ? true : false
        
    }
    
    //    enum CodingKeys: String, CodingKey { //식판에다 넣어줄 때 매칭해주는 애(데이터를 받아서 식판에 담아주는 중간 역할): 내부적으로 구현이 이 이넘은 되어잇음
    //        case movieTitle = "movie_title"
    //        case likeCount = "like_count"
    //        case director = "director"
    //    }
    
}

//Alamofire의 responseDecodable을 사용을 하지 않고 디코딩을 할 수 있는 다양한 방법
//서버에 요청을 해서 response로 받는 제이슨 구조를 어떻게 식판에 담는 과정인지
// 서버요청시 responseDecodable 코드 안에 어떤 로직들이 들어있을까 하는 이야기

/*
 
 1. 디코딩을 할 때, 키값이 다르다면(스펠링주의) 디코딩이 실패한다.
 2. 옵셔널로 해결하기 : 근데 앱이 터지진 않겟지만 원하는 값을 담을 수 없음
 3. 디코딩 전략: 1. CodingKey()를 활용해서 외부데이터와 매칭
    디코딩 전략: 2. snakecase(언더바?) cf.카멜케이스 / keyDecodingStrategy, keyEncodingStrategy
    디코딩 전략: 3. init으로 해결하기 decode / decodeIfPresent()
 
  */

class DecodableViewController: UIViewController {

    //문자열 안에 제이슨 구조랑 똑같은 친구를 한번 놓아보자
    let movie = """
        { 
        "movie_title": "좀비딸", 
        "like_count": 12345,
        "director": null //외부값을 가져올땐 옵셔널이 널
        }
        """
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        if director == nil {
//
//        }
        
        
        
        //"responseDecodable이 하고 있는 기능" :  아래 두 단계
        
        // 1단계 : 데이터를 변환해주기
        
        //movie데이터를 바이너리같은 형식(010101같은)으로 바꾸어서 //스트링 타입을 데이터 타입으로 변환해줌: 데이터를 바꿔줘야 식판에 담아 줄 수 있음: 그 다음 식판에 넣는 작업
        guard let data = movie.data(using: .utf8) else {
            print("실패")
            return
        }
        // 2단계 : 변환한 데이터를 식판에 담기
        
        //이제 변환한 데이터를 구조체로(식판) 담아보자: do try catch구문으로 :
        do { //식판에 데이터가 잘 담긴다면 아래 실행 : try JSONDecoder().decode : 여태썼던 responseDecodable
            let value = try JSONDecoder().decode(Movie.self, from: data) //JSONDecoder라는 클래스
            dump(value) //value: 서버통신에서 성공시 가져왔던 값
        } catch {
            print(error)
        }
        
        
        
        
        
        let decoder = JSONDecoder()
//        decoder.keyDecodingStrategy = .convertFromSnakeCase //
        

    }
    
}
