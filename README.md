# 🧮 Calculator App

## 개요

이번 프로젝트는 계산기 앱을 만드는 것이 목표입니다. 보통 iOS 개발에는 **Storyboard 방식**과 **CodeBase 방식**이 존재하며, 이번 프로젝트는 CodeBase 방식으로 앱을 구현하였습니다.
---

## 프로젝트 정보

- **개발 기간**: 2024. 11. 15 ~ 2024. 11. 22 (7일)
- **개발 도구**: Xcode16.0, Swift, UIKit ,SnapKit
- **주요 목표**: CodeBase 방식으로 iOS 앱 구현, AutoLayout 적용

---
## 주요기능
- 사칙연산: 덧셈, 뺄셈, 곱셈, 나눗셈 기능 제공
- 초기화 : AC 버튼으로 계산기를 초기화
- 반응형 UI: SnapKit을 이용해 모든 화면 크기에서 동작

## 구현 단계
### **Lv.1 ~ Lv.5 (UI 구현)**
#### 💡 Lv.1 - Label 구현하기
#### 💡 Lv.2 - Button 구현하기 (HorizontalStackView 이용)
#### 💡 Lv.3 - Button 구현하기 (VerticalStackView 이용)
#### 💡 Lv.4 - 버튼 생성 로직 최적화
#### 💡 Lv.5 - 버튼을 원형으로 구현
### **Lv.6 ~ Lv.8 (로직 구현)**
#### 💡 Lv.6 - 버튼 클릭 시 Label에 값 띄우기
#### 💡 Lv.7 - 초기화 버튼 기능 구현
#### 💡 Lv.8 - 계산 버튼 기능 구현
---
### 개발과정 집중 포인트
 - **AutoLayout** 적용방식
    - **NSLayoutConstraint 방식**:
      ```swift
      NSLayoutConstraint.activate([
          label.heightAnchor.constraint(equalToConstant: 100),
          label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
          label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
          label.topAnchor.constraint(equalTo: view.topAnchor, constant: 200)
      ])
      ```
    - **SnapKit 방식**:
      ```swift
      label.snp.makeConstraints {
          $0.height.equalTo(100)
          $0.leading.equalToSuperview().offset(30)
          $0.trailing.equalToSuperview().offset(-30)
          $0.top.equalToSuperview().offset(200)
      }
      ```
  - 반복되는 버튼 생성 로직을 메서드로 분리
  - `map`을 활용하여 버튼을 동적으로 생성.
  - 연산자 버튼과 숫자 버튼의 색상 차이를 고려하여 조건별로 색상 설정.
---

## 🎯 트러블슈팅
[트러블 슈팅 및 과정](https://velog.io/@jeffapd_/swiftproject%EA%B3%84%EC%82%B0%EA%B8%B0-d9mm6erj#lv1--5)
