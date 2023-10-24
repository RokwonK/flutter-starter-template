#!/bin/bash

# 사용 전 해당 파일에 part '~.g.dart' 붙였는지 확인
flutter pub run build_runner build --delete-conflicting-outputs