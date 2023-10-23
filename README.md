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
│   ├── datasource # db, network, & interceptor
│   ├── dto # request, response 및 db model
│   └── repository # 도메인별 repo
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