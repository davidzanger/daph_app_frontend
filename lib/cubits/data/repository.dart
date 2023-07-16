part of 'cubit.dart';

class DataRepository {
 Future<Data> fetch() => DataDataProvider.fetch();
}

class DataRepositoryRequest {
 Future<Data> generateText(Data body) => DataDataProvider.generateText(body);
}