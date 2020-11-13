import 'dart:convert';
import 'ModelApi.dart';
import 'package:http/http.dart';
class FutureApi
{
  Response response;
  Map<String,dynamic> val;
  String url='https://api.covid19api.com/summary';
  Future getValue()
  async{
     response = await get(url);
    val=jsonDecode(response.body);

    return ModelApi.fromJson(jsonDecode(response.body));

  }
  Map<String,dynamic> vare(){return val;}

}