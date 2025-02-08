
import 'package:dio/dio.dart';


class RmApi {

  static Dio _dio = new Dio();

  static void configureDio(){
    _dio.options.baseUrl = 'https://rickandmortyapi.com/api';
  }

  static Future httpGet(String path)async{

    try{

      final resp = await _dio.get(path);

      if ( resp.statusCode == 200 ){
        return resp.data;
      }
      return '';

    } on DioException catch(e){
      if ( e.response?.statusCode == 404 ){
        return '';
      }else {
        throw('Error');
      }
    }

  }











}
