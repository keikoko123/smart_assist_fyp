import 'package:dio/dio.dart';
import '../constants/constants.dart';

//! https://gnews.io/dashboard
//!　https://newsapi.org/docs/endpoints/everything
//todo https://data.gov.hk/tc-data/dataset/hk-lcsd-event-event-leisure/resource/ecc6c632-2905-4f6b-934d-39d284bdc3fe
class NewsService {
  final Dio _dio = Dio(
      BaseOptions(baseUrl: ApiUrls.baseUrl2, responseType: ResponseType.json));

  fetchNews() async {
    var response = await _dio.get(              //! &apikey= 90019eeba918949ff555180431975bb5
        'v4/top-headlines?country=hk&category=health&apikey=90019eeba918949ff555180431975bb5');
    return response.data;
  }
//     fetchNews() async {

//     var response = await _dio.get('v2/top-headlines?country=hk&category=health&apiKey=6456e71cd3b9460082aa7439170a75ea');
// https://gnews.io/api/v4/top-headlines?country=hk&category=health&apikey=e2bed46843ef5fcfbc6cbf6a9e006c45
//     return response.data;

//   }

  fetchNewsBySearching(String title) async {
    //  var response = await _dio.get('v2/everything?q='+title+'&apiKey=6456e71cd3b9460082aa7439170a75ea');
    var response = await _dio.get('v4/search?q=' +
        '旅遊' +
        '&country=hk&apikey=e2bed46843ef5fcfbc6cbf6a9e006c45');

    //  var response = await _dio.get('v2/everything?q='+ '護老'+'&sortBy=popularity&apiKey=6456e71cd3b9460082aa7439170a75ea');

    return response.data;
  }

  fetchNewsBySearching2(String tag) async {
    if (tag == '0') {
      tag = '養生';
    } else if (tag == '1') {
      tag = '病痛';
    } else if (tag == '2') {
      tag = '飲食';
    } else if (tag == '3') {
      tag = '康樂';
    } else if (tag == '4') {
      tag = '文化';
    }
    //  var response = await _dio.get('v2/everything?q='+title+'&apiKey=6456e71cd3b9460082aa7439170a75ea');
    var response = await _dio.get('v4/search?q=' +
        tag + '&country=hk&apikey=e2bed46843ef5fcfbc6cbf6a9e006c45');

    //  var response = await _dio.get('v2/everything?q='+ '護老'+'&sortBy=popularity&apiKey=6456e71cd3b9460082aa7439170a75ea');

    return response.data;
  }
}
