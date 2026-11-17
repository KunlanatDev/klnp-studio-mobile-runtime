import '../../domain/repositories/runtime_repository.dart';
import '../datasources/runtime_remote_data_source.dart';

class RuntimeRepositoryImpl implements RuntimeRepository {
  final RuntimeRemoteDataSource remoteDataSource;

  RuntimeRepositoryImpl(this.remoteDataSource);

  @override
  Future<Map<String, dynamic>> fetchDocument(String pageId) {
    return remoteDataSource.fetchDocument(pageId);
  }
}

