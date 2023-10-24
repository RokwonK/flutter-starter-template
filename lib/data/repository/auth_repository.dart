import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'auth_repository.g.dart';

@RestApi()
abstract class AuthRepository {
  factory AuthRepository(Dio dio, {String baseUrl}) = _AuthRepository;

  @GET("/{id}")
  Future<void> getRestaurantDetail({
    @Path() required String id,
  });
}
