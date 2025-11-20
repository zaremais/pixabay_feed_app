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

import '../../features/pixabay/data/datasourses/pixabay_remote_data_source.dart'
    as _i1015;
import '../../features/pixabay/data/repositories/pixabay_repository._impl.dart'
    as _i773;
import '../../features/pixabay/domain/repositories/pixabay_domain_repository.dart'
    as _i603;
import '../../features/pixabay/domain/usecases/get_image_usecase.dart' as _i793;
import '../../features/pixabay/presentation/notifier/image_notifire.dart'
    as _i339;
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
    gh.factory<_i339.ImagesNotifier>(() => _i339.ImagesNotifier());
    gh.lazySingleton<_i1015.PixabayRemoteDataSource>(
      () => _i1015.PixabayRemoteDataSourceImpl(gh<_i667.DioClient>()),
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
    return this;
  }
}
