# APNs 에 필요한 것들 받기..

## APNs(Apple Push Notification Service)는 애플 개발자 화면에서 인증서(Certificate)와 키를 생성해야 사용할 수 있다. 
<br>

# Identifier

1. Identifier 가 없다면 새로 등록한다.

![](/iOS/Push%20Notification/images/identifier_process1.png)


![](/iOS/Push%20Notification/images/identifier_process2.png)

2. 등록 시 Push Notifications 체크

![](/iOS/Push%20Notification/images/identifier-process3.png)

![](/iOS/Push%20Notification/images/identifier-process4.png)

![](/iOS/Push%20Notification/images/identifier-process5.png)

저장 후, Push Notification 에 대한 Configure 버튼 활성 가능 상태로 나옴.

![](/iOS/Push%20Notification/images/identifier-process6.png)

Configure 누르면, 아래와 같이 Certificate 생성할 수 있는 화면 등장!
![](/iOS/Push%20Notification/images/identifier-process7.png)

![](/iOS/Push%20Notification/images/identifier-process8.png)
여기서 아래를 보면, 
To manually generate a Certificate, you need a **Certificate Signing Request(CSR)** file from your Mac 이라고 나온다.

<br>

# CSR 생성

1. 키체인 접근
2. 좌측 위 키체인 접근 탭 선택 
3. 인증서 지원 -> 인증 기관에서 인증서 요청
4. 디스크에 저장

![](/iOS/Push%20Notification/images/CSR_Sample.png)

아래와 같이 생성된 CSR 파일을 추가해준 후 Continue
![](/iOS/Push%20Notification/images/certificate-process2.png)

![](/iOS/Push%20Notification/images/certificate-process3.png)

하면 다음과 같이 Certificate 에 추가된다!

Identifier 에 다시 가서 다운로드 하면, 
![](/iOS/Push%20Notification/images/certificate-process4.png)

아래와 같은 file 을 얻을 수 있다.

![](/iOS/Push%20Notification/images/certificate-process5.png)


<br><br>
<hr>

# Certificate (위 과정 수행 전 Identifier 가 이미 있는 경우)
<br>
<br>





1. Certificates 옆 + 선택

![](/iOS/Push%20Notification/images/certificate-process1.png)

2. Apple Push Notification service SSL 항목 선택
<br>

![](/iOS/Push%20Notification/images/publishing_certificate1.png)

<hr>

![](/iOS/Push%20Notification/images/certificate-process6.png)

그 후 App ID 선택

![](/iOS/Push%20Notification/images/certificate-process7.png)

CSR 발급 (위 과정 참고)

<!-- 그런데 왜.. Certificate 이 없고, Identifier 에도 Push Notification 이 등록되어있지 않은 상태에서도 Push 가 오는걸까?  -->