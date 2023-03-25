# Layout Subviews Methods

# Layout subviews 관련 Methods 란?

- **ViewController**관련 method인 **viewWillAppear**, **viewDidAppear 등**이 존재하듯이, 레이아웃이 결정되기 전, 후 subviews 의 methods 가 존재

- **UIKit** 에는 **ViewController** 의 등장과 연관된 부가적인 작업을 할 수 있도록 다양한 methods 가 존재
- **Layout** **Subviews** 역시 레이아웃이 결정되는 과정 중에 레이아웃과 연관된 부가적인 작업들을 수행할 수 있도록 **UIKit 에** 몇 가지 methods 가 존재
<br><br>
 

# ViewController에서 레이아웃이 결정되는 과정

- **viewWillLayoutSubviews()** method 호출
- **ViewController**의 ContentView 가 **layoutSubviews()** method 호출 (ContentView: UITableView 의 Cell 에 존재)
    - **layoutSubviews()**: 현재 레이아웃 정보들을 바탕으로 새로운 레이아웃 정보를 계산
    - 이후 뷰 계층구조를 순회하면서 모든 하위 뷰들이 동일한 method  호출
- 레이아웃 정보의 변경사항을 뷰들에 반영
- **viewDidLayoutSubviews()** method 호출
<br><hr><br>
# Layout subviews관련 Method
<br>
# viewWillLayoutSubviews()

- View의 bounds가 변하면 view는 하위 views의 위치를 조정하는데, **레이아웃이 결정되기 전에** 다음과 같은 작업을 수행하고자 할때 이 method 를 override하여 사용
    - views를 추가하거나 제거
    - views의 크기나 위치를 업데이트
    - layout constraints를 업데이트
    - view와 관련된 기타 properties 를 업데이트

# layoutSubviews()

- 뷰의 크기가 변경될 때마다 이에 대응하여 views의 크기&위치 변경되어야 함 -> AutoLayout을 사용하면 각 뷰의 ’**autoresizingMask’** property를 설정하여 상위 뷰의 크기가 변경되었을 때 어떻게 대응할 지 규칙을 정할 수 있음
    
    
- 뷰의 크기에 변경이 발생하면 우선 하위 views의 autoresizing 동작을 적용하는데, 변경사항을 반영하기 위하여 **layoutSubviews()** method 를 호출 (이 method 역시 하위 views에서도 연쇄적으로 호출 됨)

# viewDidLayoutSubviews()

- 레이아웃이 결정되고 나서 아래와 같은 일을 수행하고자 할 때 이 method 를 override하여 사용
    - 다른 뷰들의 컨텐트 업데이트
    - 뷰들의 크기나 위치를 최종적으로 조정
    - 테이블의 데이터를 reload


출처: https://ios-development.tistory.com/195