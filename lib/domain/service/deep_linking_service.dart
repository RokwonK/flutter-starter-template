
import 'package:flutter_starter_template/data/data_source/data_source.dart';

class DeepLinkingService {
  DeepLinkingService({
    required this.dataSource
  });

  final LocalKeyValueDataSource dataSource;

  // Remote Notification(FCM), Local Notification 받았을때 저장
  void saveDeepLink({Map<String, dynamic>? remoteData, String? localData}) {
    // 바로 해당 페이지를 보여줄 수 있을까?
    // AppBloc이 생긴상태인지 확인할 필요가 있음
  }

  // 처리되지 않은 DeepLink 가져오기
  void getDeepLinkInfo() {
    // 언제 불러오는지가 관건
  }
}


enum DeepLinkEvent {
  post,
  repost;
}