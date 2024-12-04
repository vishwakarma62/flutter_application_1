import 'package:postervibe/data/network/api/all_event_and_event_poast_api.dart';
import 'package:postervibe/data/network/api/app_version/app_version_api.dart';
import 'package:postervibe/data/network/api/business_api.dart';
import 'package:postervibe/data/network/api/dashboard_api.dart';
import 'package:postervibe/data/network/api/auth_api.dart';
import 'package:postervibe/data/network/api/my_post_api.dart';
import 'package:postervibe/data/network/api/search_event_api.dart';
import 'package:postervibe/data/network/api/user_api.dart';
import 'package:postervibe/data/network/dio_client.dart';
import 'package:postervibe/data/repository/all_event_and_post_repository.dart';
import 'package:postervibe/data/repository/app_version_repo.dart';
import 'package:postervibe/data/repository/business_repo.dart';
import 'package:postervibe/data/repository/dashboard_repo.dart';
import 'package:postervibe/data/repository/auth_repository.dart';
import 'package:postervibe/data/repository/my_post_repo.dart';
import 'package:postervibe/data/repository/search_event_repo.dart';
import 'package:postervibe/data/repository/user_repo.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> setup() async {
  getIt.registerSingleton(Dio());

  getIt.registerSingleton(DioClient(getIt<Dio>()));

  getIt.registerSingleton(AuthenticationApi(dioClient: getIt<DioClient>()));
  getIt.registerSingleton(DashBoardApi(dioClient: getIt<DioClient>()));
  getIt.registerSingleton(BusinessApi(dioClient: getIt<DioClient>()));
  getIt.registerSingleton(UserAPi(dioClient: getIt<DioClient>()));
  getIt.registerSingleton(SearchEventApi(dioClient: getIt<DioClient>()));
  getIt.registerSingleton(AllEventAndPostApi(dioClient: getIt<DioClient>()));
    getIt.registerSingleton(AppVersionApi(dioClient: getIt<DioClient>()));
     getIt.registerSingleton(MyPostApi(dioClient: getIt<DioClient>()));

  getIt.registerSingleton(AuthRepository(getIt.get<AuthenticationApi>()));
    getIt.registerSingleton(MyPostRepo(getIt.get<MyPostApi>()));
  getIt.registerSingleton(AppVersionRepo(getIt.get<AppVersionApi>()));
  getIt.registerSingleton(AllEventAndPostRepo(getIt.get<AllEventAndPostApi>()));
  getIt.registerSingleton(SearchRepository(getIt.get<SearchEventApi>()));
  getIt.registerSingleton(USerRespository(getIt.get<UserAPi>()));
  getIt.registerSingleton(DashBoardRepository(getIt.get<DashBoardApi>()));
  getIt.registerSingleton(BusinessRepository(getIt.get<BusinessApi>()));
}
