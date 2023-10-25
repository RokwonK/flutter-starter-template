# flutter_starter_template

flutter를 이용하여 빠르게 앱을 만들고 배포하기 위한 템플릿 레포.

### Dart 및 Flutter 버전
- dart `3.1.3`
- flutter  `3.13.6`  

<br />

### 디렉터리 구조
```bash
/lib
├── config # firebase, DI, Retrofit 등 설정
├── data
│   ├── datasource # db, network(retrofit 쓰면 필요없긴함)
│   ├── dto # request, response 및 db model
│   └── repository 
│   │	├── network # remote data_source 사용
│   │	└── local # local data source 사용
├── domain
│   └── usecase
├── presentation
│   ├── page
│   ├── style # 기본 디자인 시스템
│   │	├── color
│   │	├── space
│   │	├── image
│   │	└── font
│   └── component # 기본 컴포넌트 & 만들어질 컴포넌트
│       ├── base
│       └── button
└── global
    ├── constant
    ├── enum
    └── manager # notification 등
```

<br />

### 제공 기능
- Font(Pretendard) 설정
- 기반 디자인 시스템(Color, Space, Font, component)
- Bloc, DI, Retrofit 설정 코드
- Firebase 관련 설정 코드
- Network, LocalDB 접근 코드
- App Icon 생성기
- Splash 생성기

<br />

### 의존 라이브러리 및 버전
- App Icon 자동생성
  - flutter_launcher_icons `0.13.1`
- Splash 생성
  - flutter_native_splash `2.3.4`
- 상태관리  
  - flutter_bloc `8.1.3`
  - bloc `8.1.2`
  - equatable `2.0.5`
- Code Generator
  - build_runner `< 4.0.0` 
  - json_serializable `6.6.2`
  - freezed `2.3.4`
- Network
  - dio `5.1.2`
  - retrofit `< 5.0.0`
- ETC
  - 시간 포맷 - intl `0.18.1`
  - 로거 - logger `2.0.0`

<br />

### 패키지 이름 변경 
```bash
$ flutter pub add change_app_package_name
$ flutter pub run change_app_package_name:main {com.새로운.패키지명}
```

<br />

### 앱 이름 변경
iOS
- `ios/Runner/Info.plist` 파일
- `CFBundleDisplayName` 아래 값을 원하는 앱 이름으로 변경

Android
- `/android/app/src/main/AndroidManifest.xml` 파일
- `<application> 태그 - android:label` 의 속성값을 앱 이름으로 변경

<br />

### 자동 생성 파일 숨기기
- Android studio -> Preferences -> Editor -> File Types -> "ignore files and folders"
- Add `*.g.dart` , `*.freezed.dart`

<br />

### Firebase 연동
`flutterfire` cli 를 사용하면 pubspec에 따라 자동으로 설정해줘서 간편함(fcm 제외)  

<details>
<summary>Firebase Core</summary>
<div markdown="1">

- pubspec 내 `firebase_core` 추가
- `android/`와 `android/app` 내 `build.gradle`의 [dependency 직접 설정](https://totally-developer.tistory.com/144) 혹은 [`flutterfire` 명령어로 자동 추가](https://firebase.google.com/docs/flutter/setup?hl=ko&platform=ios)하기
- 오류 발생 가능성 있으니 [해당 블로그](https://bangu4.tistory.com/351) 참고

</div>
</details>

<details>
<summary>Cloud Messaging(FCM) 설정</summary>
<div markdown="1">

- pubspec 내 `firebase_messaging` 추가  
- pubspec 내 `flutter_local_notifications` 추가(Android는 앱이 포그라운드일때 알림이 안뜨므로 local noti로 띄어줘야함)
- iOS 설정
  1. Apple Developer - Keys - 인증키 생성(APNs 기능 포함) - p8 파일 Firebase에 등록
  2. Apple Developer - Identifiers - App ID(bundle ID) - 추가할 기능(Push Noti, 필요하다면 Sign in apple도!) 선택해서 만들기
  3. Xcode 내 Capability `Push Notifications` 추가
  4. Xcode 내 Capability `Background Modes` 추가 - Backgroud Fetch, Remote Notifications 체크
  5. Firebase에 등록 - 인증키(p8) 및 팀ID(Apple Developer - Store Connect에서 확인 가능)
- Android 설정  
  1. `android/app/src/main/AndroidMenifest.xml`에 meta-data 추가 - 푸시메시지 우선순위 높이기
  ```xml
    <application
          android:label="flutter_velog_sample"
          android:name="${applicationName}"
          android:icon="@mipmap/ic_launcher"
          android:requestLegacyExternalStorage="true" 
          android:usesCleartextTraffic="true">

          <meta-data
              android:name="com.google.firebase.messaging.default_notification_channel_id"
              android:value="high_importance_channel" />
        ...
        ...
  ```
  2. `android/app/src/main/AndroidMenifest.xml` 최상단 <activity>에 intnent-filter 추가 - 푸시메시지 클릭시 메시지에 담긴 정보를 받을 수 있음
  ```xml
  <activity
            android:name=".MainActivity"
            android:exported="true"
            android:launchMode="singleTop"/>
          ...
		  ...
          <intent-filter>
                <action android:name="FLUTTER_NOTIFICATION_CLICK" />
                <category android:name="android.intent.category.DEFAULT" />
          </intent-filter>    
        </activity>
  ```
  3. 퍼미션 추가 - <manifest xmlns: ~> 바로 하단에 추가
  ```xml
  <uses-permission android:name="android.permission.ACCESS_NOTIFICATION_POLICY"/>
  ```
  
- FCM 퍼미션 요청, 컨트롤 코드는 템플릿 코드에 존재
- 주의 : FCMToken은 만료기간있으니 앱 킬때마다 업데이트하기

</div>
</details>

<details>
<summary>Crashlytics 설정</summary>
<div markdown="1">

- [공식문서](https://firebase.flutter.dev/docs/crashlytics/usage)

</div>
</details>

<details>
<summary>Event 설정</summary>
<div markdown="1">

- [공식문서](https://firebase.flutter.dev/docs/analytics/get-started)
- [참고 블로그](https://velog.io/@tygerhwang/Flutter-Firebase-Events-GAGoogle-Analytics-%EC%82%AC%EC%9A%A9%ED%95%B4-%EB%B3%B4%EA%B8%B0)

</div>
</details>

<br />  

### Deep Linking
2025년 8월까지 FDL(Firebase Dynamic Link)에 따른 딥링킹 솔루션 필요
- [Appsflyer 플랜](https://www.appsflyer.com/ko/pricing/)
- [Appsflyer flutter plugin](https://github.com/AppsFlyerSDK/appsflyer-flutter-plugin/blob/master/doc/DeepLink.md)