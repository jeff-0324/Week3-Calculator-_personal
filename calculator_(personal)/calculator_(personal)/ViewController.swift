import UIKit
import SnapKit

class ViewController: UIViewController {
    static var result: String = "0"
    let arragne: [[String]] = [ ["7", "8", "9", "+"],
                                ["4", "5", "6", "-"],
                                ["1", "2", "3", "*"],
                                ["AC", "0", "=", "/"] ]
    let colorOperator: [String] = ["+", "-", "*", "/", "=", "AC"]
    let operators: [String] = ["+", "-", "*", "/"]
    let defaultColor = CGColor(red: 77/255, green: 77/255, blue: 77/255, alpha: 1.0)
    
    // Label 생성
    static var label: UILabel = {
        let label = UILabel()
        label.text = result
        label.textColor = .white
        label.backgroundColor = .black
        label.textAlignment = .right
        label.font = .boldSystemFont(ofSize: 60)
        label.adjustsFontSizeToFitWidth = true      // 텍스트 크기를 label 너비에 맞게 조정
        label.minimumScaleFactor = 0.5              // 글자 크기의 최소비율을 0.5까지 조정
        label.numberOfLines = 1
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    // 초기 세팅
    func configureUI() {
        // 뷰의 배경색 설정
        view.backgroundColor = .black
        
        // MARK: - Button
        // 버튼 생성
        let buttons: [[UIButton]] = arragne.map{$0.map{makeButton(titleValue: String($0))}}
        
        // 버튼을 만드는 메서드
        func makeButton(titleValue: String) -> UIButton {
            // 각 버튼의 값을 이용해 색상을 추가
            let color: UIColor = colorOperator.contains(titleValue) ? .orange : UIColor(cgColor: defaultColor)
            let button = UIButton()
            button.setTitle(titleValue, for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.titleLabel?.font = .boldSystemFont(ofSize: 30)
            button.backgroundColor = color
            button.frame.size.height = 80
            button.frame.size.width = 80
            button.layer.cornerRadius = 40
            button.addTarget(self, action: #selector(tappedButton), for: .touchUpInside)
            return button
        }
        
        // MARK: - HorizontalStackView
        // 각 라인의 버튼을 하나의 스택뷰로 선언
        let stakViews: [UIStackView] = buttons.map { makeHorizontalStackView($0) }
        
        // HorizontalStackView 생성하는 메서드
        func makeHorizontalStackView(_ views: [UIView]) -> UIStackView {
            let stackView = UIStackView(arrangedSubviews: views)
            stackView.axis = .horizontal
            stackView.backgroundColor = .black
            stackView.spacing = 10
            stackView.distribution = .fillEqually
            return stackView
        }
        
        // MARK: - VerticalStackView
        // 하나의 VerticalStackView 생성
        let verticalStackView = makeVerticalStackView(stakViews)
        
        // VerticalStackView 생성하는 메서드
        func makeVerticalStackView(_ views: [UIView]) -> UIStackView {
            let stackView = UIStackView(arrangedSubviews: views)
            stackView.axis = .vertical
            stackView.backgroundColor = .black
            stackView.spacing = 10
            stackView.distribution = .fillEqually
            return stackView
        }
        
        // View에 모든 요소들 추가
        [ViewController.label, verticalStackView]
            .forEach { view.addSubview($0) }
        
        //MARK: - Layout
        // label 레이아웃 설정
        ViewController.label.snp.makeConstraints {
            $0.height.equalTo(100)
            $0.leading.equalToSuperview().offset(30)
            $0.trailing.equalToSuperview().offset(-30)
            $0.top.equalToSuperview().offset(200)
        }
        
        // 각 라인의 HorizontalStackView의 레이아웃 설정
        [stakViews].forEach(horizontalStackViewLayout(stackView:))
        
        // 각 라인의 Layout 설정 메서드
        func horizontalStackViewLayout(stackView: [UIStackView]) {
            for index in stackView {
                index.snp.makeConstraints {
                    $0.height.equalTo(80)
                }
            }
        }
        
        // verticalStackView의 Layout 설정
        verticalStackView.snp.makeConstraints {
            $0.width.equalTo(350)
            $0.top.equalTo(ViewController.label.snp.bottom).offset(60)
            $0.centerX.equalToSuperview()
        }
    }
}

// MARK: - 동작과 계산 로직을 아래에 따로 분리
extension ViewController {
    // 버튼으로 받은 입력값 처리
    @objc func tappedButton(_ sender: UIButton) {
        guard let title = sender.currentTitle else { return }
        
        // 중복된 연산자 입력 방지
        if let lastValue = ViewController.result.last,
           operators.contains(String(lastValue)) && operators.contains(title) { return }
        
        // switch문을 이용한 버튼 기능구현
        switch title {
        case "AC" :
            let calculateResult = resetResult()
            changeLabelValue(calculateResult)
        case "=" :
            let calculateResult = String(calculate(expression: ViewController.result) ?? 0)
            changeLabelValue(calculateResult)
            resetResult()   // 계산 후 result값 초기화
        default :
            if ViewController.result.first == "0" {
                ViewController.result = ""
            }
            appendValue(title)
            changeLabelValue(ViewController.result)
        }
    }
    
    // 리셋버튼 적용
    func resetResult() -> String {
        ViewController.result = "0"
        return ViewController.result
    }
    
    // 입력 받은 숫자를 추가
    func appendValue(_ value: String) {
        ViewController.result.append(value)
    }
    
    // label의 값을 변경 (UI 업데이트)
    func changeLabelValue(_ value: String?) {
        guard let value = value else {return}
        DispatchQueue.main.async {
            ViewController.label.text = String(value)
        }
    }
    
    // 최종적으로 값을 계산해 반환하는 메서드
    func calculate(expression: String) -> Int? {
        let expression = NSExpression(format: expression)
        if let result = expression.expressionValue(with: nil, context: nil) as? Int {
            return result
        } else {
            return nil
        }
    }
}

// preview 메서드
#Preview {
    ViewController()
}






