part of 'cubit.dart';

class DataDataProvider {
 static Future<Data> fetch() async {
  var request;
 try {
 request = await http.get(Uri.parse('http://127.0.0.1:8000/'));
 return Data.fromJson(request.body);
    } catch (e) {
 throw Exception("Internal Server Error ${request.body}: $e");
    }
  }
  
 static Future<Data> generateText(Data data) async {
  var request;
 try {
  final jsonBody =jsonEncode(data); 
 request = await http.post(Uri.parse('http://127.0.0.1:8000/generate_text/'), headers: {'Content-Type': 'application/json'}, body: jsonBody);
 return Data(generatedText:  request.body);
    } catch (e) {
      if (request != null) {
        throw Exception("Internal Server Error ${request.body}: $e");
      }
      else {
        throw Exception("Internal Server Error: $e");
      }
    }
  }
}