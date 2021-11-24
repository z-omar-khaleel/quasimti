import 'dart:io';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiHelper {
  ApiHelper._();
  static ApiHelper apiHelper = ApiHelper._();

  Dio dio = Dio();

  static String baseUrl = 'https://qasimati.com/admin/api';

  getAllCountry(String lang) async {
    try {
      Response response = await dio.get('$baseUrl/$lang/countries',
          options: Options(
            followRedirects: false,
            validateStatus: (status) {
              return status <= 500;
            },
            headers: {'Connection': "keep-alive", 'device': "w"},
          ));
      if (response.statusCode == 200) {
        if (response.data['data'] == null) {
          return response.data;
        }

        return response.data['data'];
      } else {
        print("not enternet");
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  getSliders(String country) async {
    try {
      Response response = await dio.get(
        '$baseUrl/$country/countries/sliders',
        options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return status <= 500;
          },
          headers: {'Connection': "keep-alive", 'device': "w"},
        ),
      );
      if (response.statusCode == 200) {
        return response.data['sliders'];
      } else {
        return [];
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  getStores(String country, String lang) async {
    try {
      if (country == null) {
        print('error');
      } else {
        Response response = await dio.get('$baseUrl/stores/$country-$lang',
            options: Options(
              followRedirects: false,
              validateStatus: (status) {
                return status <= 500;
              },
              headers: {'Connection': "keep-alive", 'device': "w"},
            ));
        //   print(response);
        if (response.statusCode == 200) {
          return response.data['data'];
        }
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  getBestStores(String country, String lang) async {
    try {
      Response response =
          await dio.get('$baseUrl/stores/feature/$country-$lang',
              options: Options(
                followRedirects: false,
                validateStatus: (status) {
                  return status <= 500;
                },
                headers: {'Connection': "keep-alive", 'device': "w"},
              ));
      return response.data['data'];
    } on Exception catch (e) {
      print(e);
    }
  }

  getAllCouponInStore(String store, String country, String lang, int id) async {
    try {
      Response response = await dio.get(
        '$baseUrl/stores/$store/coupons/$country-$lang?user_id=$id',
        options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return status <= 500;
          },
          headers: {'device': "w", 'Connection': "keep-alive"},
        ),
      );
      if (response.statusCode == 200) {
        return response.data['coupons'];
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  getCategory(String lang) async {
    try {
      Response response = await dio.get(
        '$baseUrl/$lang/categories',
        options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return status <= 500;
          },
          headers: {'Accept': 'application/json', 'Connection': "keep-alive"},
        ),
      );
      if (response.statusCode == 200) {
        return response.data['data'];
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  getCouponsByCategory(
      String category, String country, String lang, int id) async {
    try {
      Response response = await dio.get(
          '$baseUrl/categories/$category/coupons/$country-$lang?user_id=$id',
          options: Options(
            followRedirects: false,
            validateStatus: (status) {
              return status <= 500;
            },
            headers: {
              'device': "w",
              'Accept': 'application/json',
              'Connection': "keep-alive"
            },
          ));
      if (response.statusCode == 200) {
        return response.data['coupons'];
      } else {
        return [];
      }
    } on Exception catch (e) {
      print("a00");
      print(e);
    }
  }

  getAllCoupon(String country, String lang, int id) async {
    try {
      Response response =
          await dio.get("$baseUrl/coupons/$country-$lang?user_id=$id",
              options: Options(
                followRedirects: false,
                validateStatus: (status) {
                  return status <= 500;
                },
                headers: {
                  'device': "w",
                  'Accept': 'application/json',
                  'Connection': "keep-alive"
                },
              ));

      if (response.statusCode == 200) {
        return response.data['data'];
      } else {
        return [];
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  register({String name, File url, String password, String email}) async {
    String path = url == null ? "" : url.path.split('/').last;

    try {
      var formData = FormData.fromMap({
        'name': name,
        'password': password,
        'url': url == null
            ? File
            : MultipartFile.fromFileSync(url.path, filename: path),
        'email': email,
      });

      Response response = await dio.post('$baseUrl/register',
          data: formData,
          options: Options(
            followRedirects: false,
            validateStatus: (status) {
              return status <= 500;
            },
            responseType: ResponseType.json,
            headers: {
              'Connection': "keep-alive",
              'Content-Type': 'multipart/form',
            },
          ));
      print(response);
      return response;
    } on DioError catch (e) {
      print(e);
    }
  }

  login(String password, String email) async {
    try {
      var data = {
        'password': password,
        'email': email,
      };
      Response response = await dio.post('$baseUrl/login',
          data: data,
          options: Options(
            followRedirects: false,
            validateStatus: (status) {
              return status <= 500;
            },
            headers: {
              'Connection': "keep-alive",
              'Content-Type': 'multipart/form',
              'Accept': 'application/json',
            },
          ));

      return response;
    } on DioError catch (e) {
      if (e.response.statusCode == 422) {
        return "";
      }
    }
  }

  addCoupon(
      {String nameStore,
      String linkstore,
      File urlStore,
      String countries,
      String code,
      String link,
      String descrption,
      String startDate,
      String endDate,
      int id,
      String type}) async {
    try {
      String path = urlStore == null ? "" : urlStore.path.split('/').last;
      SharedPreferences pref = await SharedPreferences.getInstance();
      String token = pref.get('token');
      var formData = FormData.fromMap({
        'name_store': nameStore,
        'link_store': linkstore,
        'url_store': MultipartFile.fromFileSync(urlStore.path, filename: path),
        'countries': countries,
        'code': code,
        'link': link,
        'type': type,
        'title_coupon': descrption,
        'start_date': startDate,
        'end_date': endDate,
        'user_id': id,
      });

      Response response = await dio.post('$baseUrl/coupons/create',
          data: formData,
          options: Options(
            followRedirects: false,
            validateStatus: (status) {
              return status <= 500;
            },
            headers: {
              'Content-Type': 'multipart/form',
              'Accept': 'application/json',
              'Authorization': "Bearer $token"
            },
          ));
      print(response.data);
      if (response.statusCode == 200) {
        return response.data;
      }
    } on Exception catch (e) {
      print(e);
      return "";
    }
  }

  vaildCoupon(String type, int id, String lang) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String token = pref.get('token');
      var data = {
        'coupon_id': id,
        'type_vote': type,
        'lang': lang,
      };
      Response response = await dio.post('$baseUrl/coupons/vote',
          data: data,
          options: Options(
            followRedirects: false,
            validateStatus: (status) {
              return status <= 500;
            },
            headers: {
              'Connection': "keep-alive",
              'Content-Type': 'multipart/form',
              'Accept': 'application/json',
              'Authorization': "Bearer $token"
            },
          ));
      return response.data;
    } on Exception catch (e) {
      print(e);
    }
  }

  search(String country, String lang, String query) async {
    try {
      Response response =
          await dio.get('$baseUrl/search/coupon/byStore/$country-$lang/$query',
              options: Options(
                followRedirects: false,
                validateStatus: (status) {
                  return status <= 500;
                },
                headers: {'device': "w", 'Connection': "keep-alive",


                },
              ));

      if (response.statusCode == 200) {
        return response.data['data'];
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  getUserByToken(String token) async {
    try {
      Response response = await dio.get(
        '$baseUrl/user',
        options: Options(
            followRedirects: false,
            validateStatus: (status) {
              return status <= 500;
            },
            headers: {
              'Connection': "keep-alive",
              'Content-Type': 'multipart/form',
              'Accept': 'application/json',
              'Authorization': "Bearer $token"
            }),
      );
      return response;
    } on Exception catch (e) {
      print(e);
    }
  }

  update(String name, File url, String password, String token) async {
    String path = url == null ? "" : url.path.split('/').last;
    try {
      var formData = FormData.fromMap({
        'name': name,
        'password': password,
        'image': url == null
            ? File
            : MultipartFile.fromFileSync(url.path, filename: path)
      });

      Response response = await dio.post('$baseUrl/edit/profile',
          data: formData,
          options: Options(
            followRedirects: false,
            validateStatus: (status) {
              return status <= 500;
            },
            responseType: ResponseType.json,
            headers: {
              'Connection': "keep-alive",
              'Content-Type': 'multipart/form',
              'Accept': 'application/json',
              'Authorization': "Bearer $token",
            },
          ));
      return response;
    } on DioError catch (e) {
      if (e.response.statusCode == 422) {
        print('ahmed');
      }
    }
  }

  addFavorite(String token, int id) async {
    try {
      Response response = await dio.post('$baseUrl/user/add/favorite/coupon',
          data: {'coupon_id': id},
          options: Options(
            followRedirects: false,
            validateStatus: (status) {
              return status <= 500;
            },
            responseType: ResponseType.json,
            headers: {
              'Connection': "keep-alive",
              'Content-Type': 'multipart/form',
              'Accept': 'application/json',
              'Authorization': "Bearer $token"
            },
          ));
      print(response.data);
      return response;
    } on Exception catch (e) {
      print(e);
    }
  }

  deleteFavorite(String token, int couponId) async {
    try {
      Response response =
          await dio.delete('$baseUrl/user/remove/favorite/coupon/$couponId',
              options: Options(
                followRedirects: false,
                validateStatus: (status) {
                  return status <= 500;
                },
                headers: {
                  'Connection': "keep-alive",
                  'Content-Type': 'multipart/form',
                  'Accept': 'application/json',
                  'Authorization': "Bearer $token"
                },
              ));
      print(response.data);
      return response;
    } on Exception catch (e) {
      print(e);
    }
  }

  getFavoriteCoupons(
    String lang,
    String token,
  ) async {
    try {
      Response response = await dio.get('$baseUrl/user/$lang/favorite/coupon',
          options: Options(
            followRedirects: false,
            validateStatus: (status) {
              return status <= 500;
            },
            headers: {
              'Connection': "keep-alive",
              'Content-Type': 'multipart/form',
              'Accept': 'application/json',
              'Authorization': "Bearer $token"
            },
          ));

      return response.data['data'];
    } on Exception catch (e) {
      print(e);
    }
  }

  verifiyEmail(String token) async {
    try {
      Response response =
          await dio.post('$baseUrl/email/verification-notification',
              options: Options(
                followRedirects: false,
                validateStatus: (status) {
                  return status <= 500;
                },
                headers: {
                  'Connection': "keep-alive",
                  'Content-Type': 'multipart/form',
                  'Accept': 'application/json',
                  'Authorization': "Bearer $token"
                },
              ));
      print(response);
      return response;
    } on Exception catch (e) {
      print(e);
    }
  }

  forgetPassword(String lang, String email) async {
    try {
      var data = {
        'email': email,
        'lang': lang,
      };
      Response response = await dio.post('$baseUrl/forgot-password',
          data: data,
          options: Options(
            followRedirects: false,
            validateStatus: (status) {
              return status <= 500;
            },
            headers: {
              'Connection': "keep-alive",
              'Content-Type': 'multipart/form',
              'Accept': 'application/json',
            },
          ));
      return response;
    } on Exception catch (e) {
      print(e);
    }
  }

  contactUs(String name, String email, String body, String title) async {
    try {
      var data = {
        'name': name,
        "email": email,
        "body": body,
        "title": "title",
      };
      Response response = await dio.post(
        '$baseUrl/page/contact',
        data: data,
        options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return status <= 500;
          },
          headers: {
            'Connection': "keep-alive",
            'Content-Type': 'multipart/form',
            'Accept': 'application/json',
          },
        ),
      );
      return response;
    } on Exception catch (e) {
      print(e);
    }
  }
}
