// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/boards/data/datasources/board_remote_datasource_impl.dart'
    as _i5;
import '../../features/boards/data/repository/board_repository.dart' as _i60;
import '../../features/boards/domain/repository/board_domain_repository.dart'
    as _i505;
import '../../features/boards/domain/usecases/get_board_use_case.dart' as _i358;
import '../../features/boards/presentation/providers/board_notifire.dart'
    as _i2;
import '../../features/pixabay/data/datasourses/pixabay_remote_data_source.dart'
    as _i1015;
import '../../features/pixabay/data/repositories/pixabay_repository._impl.dart'
    as _i773;
import '../../features/pixabay/domain/repositories/pixabay_domain_repository.dart'
    as _i603;
import '../../features/pixabay/domain/usecases/get_image_usecase.dart' as _i793;
import '../../features/pixabay/presentation/notifier/pixabay_notifire.dart'
    as _i897;
import '../network/dio_client.dart' as _i667;
import '../network/logger_interceptors.dart' as _i455;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.factory<_i455.LoggerInterceptor>(() => _i455.LoggerInterceptor());
    gh.factory<_i667.DioClient>(() => _i667.DioClient());
    gh.factory<_i2.BoardNotifier>(() => _i2.BoardNotifier());
    gh.factory<_i897.PixabayNotifier>(() => _i897.PixabayNotifier());
    gh.lazySingleton<_i1015.PixabayRemoteDataSource>(
      () => _i1015.PixabayRemoteDataSourceImpl(gh<_i667.DioClient>()),
    );
    gh.lazySingleton<_i5.BoardRemoteDataSource>(
      () => _i5.BoardRemoteDataSourceImpl(gh<_i667.DioClient>()),
    );
    gh.lazySingleton<_i603.PixabayDomainRepository>(
      () => _i773.PixabayRepositoryImpl(
        remote: gh<_i1015.PixabayRemoteDataSource>(),
      ),
    );
    gh.factory<_i793.GetImageUsecase>(
      () => _i793.GetImageUsecase(
        repository: gh<_i603.PixabayDomainRepository>(),
      ),
    );
    gh.lazySingleton<_i505.BoardDomainRepository>(
      () => _i60.BoardRepositoryImpl(remote: gh<_i5.BoardRemoteDataSource>()),
    );
    gh.factory<_i358.GetBoardUseCase>(
      () =>
          _i358.GetBoardUseCase(repository: gh<_i505.BoardDomainRepository>()),
    );
    return this;
  }
}
