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

## 실행하기
1. 이 Template 레포를 베이스로 repo 만들기
2. 패키지명 변경
   - [iOS/Android 패키지명 변경 실행](#index-text)
   - 파일 모든 패키지명 변경 - cmd+shift+r 로 `package:flutter_starter_template` -> `package:패키지명` 
   - pubspec 내 패키지명 변경
3. flutter 초기화
   - `flutter create .` flutter 준비
   - `assets/confg/.env` 작성(API_BASE_URL 필수 작성)
   - `flutter clean` 실행 전 준비
   - `flutter pub get` 라이브러리 재다운
   - `scripts/code-generate.sh` code generator 실행
4. (선택) Firebase 설정 (설정하지 않을 시 `main.dart`서 firebase, notification config 주석처리 필수)
   - `firebase cli`, `flutterfire-cli` 설치 [Firebase 연동 - Firebase Core](#firebase-연동)
   - `firebase login:add 계정` 로 새로운 계정 추가
   - `firebase login:use 계정`로 새 계정 선택
   - (계정 선택 안될 시) `firebase login --reauth` 로 계정 전환
   - `flutterfire configure`로 자동설정
   - `firebase_options.dart` 파일 `lib/config` 밑으로 이동, `firebase_config` 파일 내 설정코드 주석 제거 
5. (선택) 푸시설정
   - [Firebase 연동 - Cloud Messaging(FCM) 설정](#firebase-연동)
   - Apple Developer 푸시설정 (하단 `Firebase 연동` 참고)
   - 푸시가 필요없다면 Xcode Capability 에서 background mode, push notificaiton 지우기
   - Android 푸시설정

<br/>

## 제공 기능
- Font(Pretendard) 설정
- 기반 디자인 시스템(Color, Space, Font, component)
- Bloc, DI, Retrofit 설정 코드
- Firebase 관련 설정 코드
- Notification, 딥링킹, 이벤트추적 Service
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

필수! - pubspec 내 `firebase_core` 추가

- 자동설정
  - [`flutterfire` 명령어로 자동 설정](https://firebase.google.com/docs/flutter/setup?hl=ko&platform=ios)하기
- 자동 설정 안하면
  - `android/`와 `android/app` 내 `build.gradle`의 [dependency 직접 설정](https://totally-developer.tistory.com/144) 혹은
  - iOS 셋팅(`flutterfire` 사용시 셋팅 불필요)
    - `ios/Runner` 하위에 다운받은 `GoogleService-Info.plist` 파일 넣기
    - 해당 파일은 .gitignore
  - Android 셋팅(`flutterfire` 사용시 셋팅 불필요)
    - `android/app` 하위에 다운받은 `google-services.json` 파일 넣기
    - 해당 파일은 .gitignore
- 오류 발생 가능성 있으니 [해당 블로그](https://bangu4.tistory.com/351) 참고

</div>
</details>

<details>
<summary>Cloud Messaging(FCM) 설정 + LocalNotification 설정</summary>
<div markdown="1">

- pubspec 내 `firebase_messaging` 추가
- pubspec 내 `flutter_local_notifications` 추가(Android는 앱이 포그라운드일때 알림이 안뜨므로 local noti로 띄어줘야함)
- android gradle 파일 설정 필요. but, `flutterfire`로 자동화
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

- iOS (info.plist에 값추가) - [해결](https://velog.io/@ayb226/Flutter-%EC%98%A4%EB%A5%98-%EB%AA%A8%EC%9D%8C-FIRMessaging-Remote-Notifications-proxy-enabled-%ED%95%B4%EA%B2%B0%EB%B2%95)
- iOS (AppDelegate에 값추가) - [해결](https://dev-nam.tistory.com/49)
- Android/iOS의 Local Notification을 위한 추가 설정 - [Local Notification](https://medium.com/doohyeon-kim/flutter-local-notification-9db501508d75)
- FCM 퍼미션 요청, 컨트롤 코드는 템플릿 코드에 존재
- 주의 : FCMToken은 만료기간있으니 앱 킬때마다 업데이트하기

</div>
</details>

<details>
<summary>Crashlytics 설정</summary>
<div markdown="1">

- [블로그](https://deku.posstree.com/en/flutter/firebase/crashlytics/)
- [공식문서](https://firebase.flutter.dev/docs/crashlytics/usage)
- podspec 내 `firebase_crashlytics` 추가
- android gradle 파일 설정 필요. but, `flutterfire`로 자동화

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

<br />

### 권한 요청 관리
- 권한 요청을 관리하는 라이브러리가 존재한다. [permission_handler](https://pub.dev/packages/permission_handler)

<br />  

### 로컬 노티피케이션 설정  
- [플랫폼별 추가 필요설정](https://medium.com/doohyeon-kim/flutter-local-notification-9db501508d75)
- [로컬 노티피케이션 설정](https://velog.io/@tygerhwang/FLUTTER-Local-Notifications2)

<br />

## 알면 좋은 것들

### 토막상식 1.1 - Android 배포 관련
1. Key Hash(Relase, Debug)  
서드파티 서비스들이 해당 앱을 인증하는데 사용됨. Debug는 개발용, Release는 배포용. 어플리케이션 생성시 미리 만들어지므로 따로 생성할 필요 없고 추출만 아래와 같이 하면 됨.

Debug. 하지만 여러 앱을 개발 중인 경우 debug.keystore가 겹치므로 제대로 된 값이 안나올 경우가 많음. Debug 키의 경우 어플리케이션 코드로 뽑는게 편함
```bash 
keytool -exportcert -alias androiddebugkey -keystore ~/.android/debug.keystore | openssl sha1 -binary | openssl base64`
```  
Release  
```bash
keytool -exportcert -alias androidReleasekey -keystore ~/.android/release.keystore | openssl sha1 -binary | openssl base64
```

2. KeyStore (Keystore랑 다른거!)  
개발자가 앱을 서명할 때 사용하는 파일. 앱을 서명하면 앱이 개발자에 의해 만들어졌다는 것을 증명하고 앱이 변경되지 않았음을 보장한다. Google Play Console에 앱 업로드시 사용하는 인증키.
안드로이드 시스템에서 Java 환경에서 사용되는 KeyStore 형식인 JKS(Java KeyStore)를 사용한다. 생성방법은 아래와 같다.
```bash
keytool -genkey -v -keystore ~/lettering.jks -keyalg RSA -keysize 2048 -validity 10000 -alias lettering -storetype JKS 
```

3. Signing Key  
Google Play Console에 자동 생성하는 인증키. 스토어에서 앱이 위조되지 않음을 증명함. 인증된 앱만 유저가 다운로드할 수 있음.

<br />

### 토막상식 1.2 - iOS 배포 관련
iOS는 생략한다! 라는 자신감

<br />

### 토막상식 2 - DeepLink
- **(공통) URI Scheme**
  - Scheme을 이용한 방식. 해당 Scheme을 사용하는 앱을 킨다.
  - iOS는 info.plist에 Scheme을 등록해야하고, Android는 Manifest에 등록한다.
  - ex) `myapp://path?query=123`
- **(iOS) Universal Link**
  - 웹 링크로 iOS 앱을 여는 방식으로 보안이 강화되었고 사용자 경험이 원활하다. 단, 서버측 설정이 필요하다.(apple-app-site-association json형식 파일 저장)
  - Capability - Associated Domains - 추가 - `applinks:{서버 호스트명}` 등록
  - Deffered Deep Linking을 직접 지원하지는 않아 개발자가 구현해야한다. 이것도 빡세니 써드파티 솔루션을 사용하자. 
  - 앱이 설치되어 있다면 해당 앱으로 이동, 앱이 설치되어 있지 않다면 스토어로 이동
  - ex) `https://{서버 호스트명}/path?query=123`
- **(Andoird) App Link**
  - 웹 링크로 Andoird 앱을 여는 방식으로 보안이 강화되었고 사용자 경험이 원활하다. 단, 서버측 설정이 필요하다.(assetlinks.json 파일 저장)
  - AndroidManifest.xml - activity MainActivity - meta-data로 flutter_deeplinking_enabled, intent-filter 추가 필요
  - Deffered Deep Linking을 직접 지원하지는 않아 개발자가 구현해야한다. 이것도 빡세니 써드파티 솔루션을 사용하자.
  - 앱이 설치되어 있다면 해당 앱으로 이동, 앱이 설치되어 있지 않다면 스토어로 이동
  - ex) `https://{서버 호스트명}/path?query=123`
- **써드파티 솔루션**
  - 하나의 링크로 웹, iOS 앱, Android 앱, 스토어, Deffered Deep Linking 가능하도록 지원 
  - Firebase Dynamic Link, AppsFlyer 등이 존재함

<br />

### 토막상식 3 - AndroidManifest.xml 파일
- <activity> 태그
  - 사용자가 앱과 상호작용할 수 있는 UI를 제공. Acitivity 클래스를 속성으로 가진다.
  - 처음 실행될 MainActivity는 기본으로 들어가고, 카카오 로그인 같이 다른 화면을 띄워주기 위해 Activity를 추가한다.
- activity 태그 내 <intent-filter> 내
  - 액티비티가 어떤 Intent를 처리할지 actions, category, data로 정의한다. Intent란 앱 구성요소간 작업을 요창하거나 정보를 전달하는데 사용되는 메세지 객체이다.
    - actions : 인텐트의 액션을 정의
    - category : 인텐트의 카테고리
    - data : 인텐트와 연관된 데이터의 URI를 정의
  - 정의된actions, category, data에 해당하는 메세지를 받으면 해당 Activity를 실행한다. 
