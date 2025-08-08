//
//  DateViewController.swift
//  SeSACWeek6
//
//  Created by 박현진 on 8/7/25.
//

import UIKit
import SnapKit


//"Error Handling" - do try catch

//오류 처리 패턴: 컴파일러가 오류의 타입을 인정하게 된다 :
enum BoxOffficeValidationError: Error { //Error프로토콜을 채택하면 모두가 봤을 떄 에러인 상황인걸 알 수 있음 : 오류 처리 패턴
    //케이스명은 모두가 알아 볼 수 있게 풀어서 잘 만들자
    //케이스로 오류의 상황을 명시
    case emptyString
    case isNotInt
    case isNOtDate
}




class DateViewController: UIViewController {

    
    let textF = UITextField() //ex.20150101형태라 하자 공백,문자열,숫자8자리 안되거나 하는 예외처리를 해보자
    let button = UIButton()
    let label = UILabel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white

        configure()
        
        button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        
        
    }
   
    @objc func buttonClicked() {
        
        guard let text = textF.text else {
            print("텍스트필드 글자가 nil입니다.")
            return
        }
        
        /*
        do {
            let _ = try validateUserInput(text: text)
            label.text = "검색이 가능"
        } catch let error { //error: 애플이 미리 만들어준 값 : let error해도 되고 아래 스위치구문으로도 써도 됨
            
        }
         
        
        do {
            let _ = try validateUserInput(text: text)
            label.text = "검색이 가능"
        } catch {
            switch error { //캐치구문에서는 error에 대한 상수를 애플이 내부적으로 자동완성으로 만들어줌: fix를 통해 : error의 타입이 자동으로 박스오피스로 특정됨 :그래서 아래 자동완성 가능
            case .emptyString:
                <#code#>
            case .isNotInt:
                <#code#>
            case .isNOtDate:
                <#code#>
            }
        }
        */
        //do try catch를 위의 2가지 형태로도 작성 가능
        
        //if else와 같아 : "catch 에러 케이스"는 else if같은 개념
        do { //참일때
            let _ = try validateUserInput(text: text) //이프옆에 쓰고 싶은 거를 try구문에 씀 : "일단은 시도"를 해봐라 : 불타입말고 에러타입으로 result에 들어오면 캐치가 어떤 에러타입인지 확인하고 캐치가 안되고 성공되면 result(_로 생략가능)에 return true값을 넣고 끝
            //result는 사용도 가능하고 와일드카드 식별자로 생략도 가능
            label.text = "검색이 가능"
            
        } catch BoxOffficeValidationError.emptyString { //잘못했을 때
            label.text = "빈문자는 검색할 수 없음"
        } catch BoxOffficeValidationError.isNotInt { //else if같은 개념
            label.text = "문자열은 검색할 수 없음"
        } catch BoxOffficeValidationError.isNOtDate {
            label.text = "날짜가 아니면 검색할 수 없음"
        } catch {
            label.text = "BoxOffficeValidationError 에러가 아닌 에러 발생" //최종떨이까지 해줘야 에러가 해결은 되지만 이넘에는 3개만 있는데 왜?
        }
        // 1.enum error 3개를 모두 다 catch로 했는데도 왜 떨이 처리(catch {})가 필요한가 : 만일의 케이스도 대비한다.
        // 2.박스오피스 에러 3개를 다 처리했더라도 AFError(alamofire에러)나 애플의 Errorr가 발생한다면?
        // 3. 귀찮더라도 try! try?보다 do try catch를 쓰자
        // 4. (새로운 문법) : swift6 "Type Throws"(다른 오류가 들어오지 않는 상황으로 "제약"을 줄 수 있다.) : 박스오피스에러에서만 에러가 들어올 수 있게 지정해주는것 : 그전에는 모든 곳의 에러가 들어올 수 잇는 상태였는데 최근에 새로 생김: throws(BoxOffficeValidationError)이렇게 기입 가능 :  스로우에 들어가는 에러가 박스오피스에껏만 이라고. 그러면 스로우 뒤에 생략도 가능 :  떨이처리도 생략 가능해짐!
        
        
        //한 줄로도 가능은 하지만 비추 : 축약형
        //try!는 리절트 타입은 불 타입이라 오류가 발생하면 nil이 들어갈 수 없어서 무조건 앱이 터짐: 느낌표는 쓰지마: 두 트라이를 스는걸 더 권장
        let result = try? validateUserInput(text: text) //트라이 옵셔널 두 안의 구문을 : 오류발생하면 리절트의 닐 값이 담김
        print(result) //오류발생시 닐 값으로 담기고 아니면 불타입이 담김
        // 그냥 try == do try catch문과 같아
        // try? : 트라이 옵셔널 == catch가 발생할 수 있는 상황에 대해 다 nil로 떨어짐
        // try! : (에러가 발생할 가능성 백프로 없어) :do 구문(성공 케이스) 부분 빼고 나머지 다 nil: 앱 터짐 주의 : 사용하지마
//
        
//        if validateUserInput(text: text) {
//            label.text = "검색이 가능"
//        } else {
//            label.text = "검색할 수 없음"
//        }
    }
    
    // 에러 핸들링으로 바꿔보자(사용자의 잘못) :  "열거형"을 통해서 핸들링
    
    // true빼고 나머지는 다 잘못 된거다!
    // false도 어떤 false인지 구체적으로 알고 싶다!
    // 규칙 : 에러를 발생할 수 있다는 걸 알리기 위해 throw 키워드를 선언
    //throw 키워드가 표시된 함수 : "throw function"
    func validateUserInput(text: String) throws(BoxOffficeValidationError) -> Bool { //throws : 이유가 여러개일수 있으니까 s가 붙어 : 리턴(throw)의 기능이 있다
        
        //빈값일때,
        guard !(text.isEmpty) else {
            print("빈 값")
            //리턴을 스로우로 변경 : false의 구체적인 이유를 던져줌: 리턴처럼 여기서 함수가 끝남
            throw .emptyString // == return false // throw BoxOffficeValidationError.emptyString
        }
        //숫자인지 아닌지,
        guard Int(text) !=  nil else {
            print("숫자가 아님")
            throw .isNotInt //박스오피스 생략가능 : 위에 "스로우스"에 지정해줘서
        }
        
        //하나 더 추가 : 애플이 기본적으로 지원해주는 에러 중에 하나를 투가 가능 : 애플이 만들어둔 Error프로토콜을 채택받고 있어서 가능
//        guard Int(text) !=  nil else {
//            print("숫자가 아님")
//            throw Error.asAFError(<#T##self: Error##Error#>) //애플에서 기본적으로 제공하는 에러로 바꿀수도 있음
//            //throw AFError. //Alamofire에러도 있음
//        }
        
        
        //날짜 형태로 변환이 되는지 안되는지
        guard checkDateFormat(text: text) else {
            print("숫자지만 날짜 형태가 아님")
            throw .isNOtDate
        }
        return true
    }
//    func validateUserInput(text: String) -> Bool {
//        
//        //빈값일때,
//        guard !(text.isEmpty) else {
//            print("빈 값")
//            return false
//        }
//        //숫자인지 아닌지,
//        guard Int(text) !=  nil else {
//            print("숫자가 아님")
//            return false
//        }
//        //날짜 형태로 변환이 되는지 안되는지
//        guard checkDateFormat(text: text) else {
//            print("숫자지만 날짜 형태가 아님")
//            return false
//        }
//        return true
//    }
    
    func checkDateFormat(text: String) -> Bool {
        let format = DateFormatter()
        format.dateFormat = "yyyyMMdd"
        return format.date(from: text) == nil ? false : true
    }
   
    func configure() {
        
        view.addSubview(textF)
        view.addSubview(button)
        view.addSubview(label)

        textF.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        button.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.top.equalTo(textF.snp.bottom).offset(20)
        }
        label.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.top.equalTo(button.snp.bottom).offset(20)

        }
        
        textF.placeholder = "텍스트필드"
        button.setTitle("버튼", for: .normal)
        label.text = "레이블"
        button.backgroundColor = .red
        label.backgroundColor = .yellow
    }

}
