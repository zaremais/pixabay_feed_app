abstract class BaseUsecase<T, P> {
  Future<T> execute({required P params});
}

class NoParams {
  const NoParams();
}
