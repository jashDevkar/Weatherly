import 'package:http/http.dart' as http;
import 'dart:convert';


/*
this file is responsible for fetching data from the url passed

*/


class Weather{
  String url;
  Weather({required this.url});

  Future requestData()async{
    var uri  = Uri.parse(url);
    var data  = await http.get(uri);
    if(data.statusCode == 200){
      var decodedData  = jsonDecode(data.body);
      return decodedData;
    }
    else{
      return Future.error('Data not recieved');
    }



  }

}
