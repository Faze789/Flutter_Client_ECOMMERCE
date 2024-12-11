import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:pak_wheels_application/providers/json_tokens_provider.dart';

class buyer_provider extends ChangeNotifier {
  List<String> product_unique_id = [];

  List<String> product_iamge_link_sell_to_buyer = [];
  List<String> product_price_sell_to_buyer = [];
  List<String> product_warranty_sell_to_buyer = [];
  List<String> product_quality_sell_to_buyer = [];
  List<String> seller_name_sell_to_buyer = [];
  List<String> product_name_sell_to_buyer = [];

  ///buyer manipulation started
  ///
  ///
  List<bool> favorites = List.filled(10000, false);

  void change_favorite(int index) {
    if (favorites[index] == true) {
      favorites[index] = false;
    } else {
      favorites[index] = true;
    }
    notifyListeners();
  }

  void display(String price, int index) {
    print('product_price_sell_to_buyer length: ${product_price_sell_to_buyer.length}');
    if (index < product_price_sell_to_buyer.length) {
      product_price_sell_to_buyer[index] = (int.parse(product_price_sell_to_buyer[index]) + 50).toString();
      print(product_price_sell_to_buyer[index]);
      notifyListeners();
    } else {
      print('Index out of range: $index');
    }
  }

  void change_price(String product_price) {
    print('-------------------');
    print(product_price);
    print('-------------------');
    notifyListeners();
  }

  var buyer_unique_id;
  Future<bool> sign_up(String email, String password) async {
    var encode_user_data = jsonEncode({
      "email": email,
      "password": password,
    });

    final sign_up_api = 'https://ecommerce123-alpha.vercel.app/home/buyer/add_new_buyer';

    final sign_up_post_request = await http.post(Uri.parse(sign_up_api), headers: {"Content-Type": "application/json"}, body: encode_user_data);

    print(sign_up_post_request.body);

    if (sign_up_post_request.statusCode == 200) {
      print('login credientials just added');

      return true;
    } else {
      print('login credientials already exists');

      return false;
    }
  }

  Future<bool> buyer_sign_in(String email, String password) async {
    var encode_user_data = jsonEncode({
      "email": email,
      "password": password,
    });

    final sign_up_api = 'https://ecommerce123-alpha.vercel.app/home/buyer/buyer_sign_in';

    try {
      final sign_up_post_request = await http.post(
        Uri.parse(sign_up_api),
        headers: {"Content-Type": "application/json"},
        body: encode_user_data,
      );

      print(sign_up_post_request.body);

      if (sign_up_post_request.statusCode == 200) {
        var responseBody = jsonDecode(sign_up_post_request.body);

        String token = responseBody['token'];
        String userEmail = responseBody['user']['email'];
        String userPassword = responseBody['user']['password'];

        JsonTokensProvider jsonTokenProvider = JsonTokensProvider();
        await jsonTokenProvider.saveToken(token, userEmail, userPassword);

        print('User exists,,,, token is saved.');
        return true;
      } else {
        print(' Person does not exist');
        return false;
      }
    } catch (error) {
      print('Error during login: $error');
      return false;
    }
  }

  Future<String> getPostsByUniqueId(String email, String password) async {
    final String apiUrl = 'https://ecommerce123-alpha.vercel.app/home/buyer/buyer_get_unique_id';

    var requestBody = {
      'email': email,
      'password': password,
    };

    String jsonBody = jsonEncode(requestBody);

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonBody,
      );

      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);

        if (responseBody.containsKey('_id')) {
          return responseBody['_id'];
        } else {
          throw Exception('ID not found in response');
        }
      } else {
        throw Exception('Failed to load data, status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
      throw Exception('Error while fetching data: $error');
    }
  }

  List<String> seller_id123 = [];

  Future<void> get_all_sellers_data() async {
    product_iamge_link_sell_to_buyer.clear();
    product_price_sell_to_buyer.clear();
    product_warranty_sell_to_buyer.clear();
    product_quality_sell_to_buyer.clear();
    seller_name_sell_to_buyer.clear();
    product_name_sell_to_buyer.clear();
    product_unique_id.clear();
    seller_id123.clear();

    final get_sellers_data = 'https://ecommerce123-alpha.vercel.app/home/buyer/get_all_sellers_data';

    final request_to_server = await http.get(Uri.parse(get_sellers_data));

    if (request_to_server.statusCode == 200) {
      print(request_to_server.body);
      final List convert_to_json = json.decode(request_to_server.body);
      for (var users in convert_to_json) {
        seller_id123.add(users['seller_product_id']);
        product_unique_id.add(users['_id']);
        seller_name_sell_to_buyer.add(users['seller_name']);
        product_name_sell_to_buyer.add(users['product_name']);

        product_quality_sell_to_buyer.add(users['product_quality']);

        product_warranty_sell_to_buyer.add(users['product_warranty']);
        product_price_sell_to_buyer.add(users['product_price']);
        product_iamge_link_sell_to_buyer.add(users['image_url']);

        notifyListeners();
      }
    } else {
      print('nothing 4321');
    }
  }

  Future<bool> add_to_cart_in_buyer(
    String product_unique_id,
    String user_unique_id,
    String product_name,
    String seller_name,
    String product_price,
    String warranty,
    String product_image,
  ) async {
    var encode_user_data = jsonEncode({
      "product_unique_id": product_unique_id,
      "buyer_unique_id": user_unique_id,
      "product_name": product_name,
      "seller_name": seller_name,
      "product_price": product_price,
      "warranty": warranty,
      "product_image": product_image,
    });

    final add_to_cart = 'https://ecommerce123-alpha.vercel.app/buyer/add_to_cart';

    try {
      final add_to_cart_data_response = await http.post(
        Uri.parse(add_to_cart),
        headers: {"Content-Type": "application/json"},
        body: encode_user_data,
      );

      print('Response Status Code: ${add_to_cart_data_response.statusCode}');
      print('Response Body: ${add_to_cart_data_response.body}');

      if (add_to_cart_data_response.statusCode == 200) {
        print('Success: Data added to cart.');
        notifyListeners();
        delete_unique_product_id(product_unique_id);
        return true;
      } else {
        print('Error: Failed to add to cart.');
        print('Response Headers: ${add_to_cart_data_response.headers}');
        notifyListeners();
        return false;
      }
    } catch (error) {
      print('Exception occurred during HTTP POST request: $error');
      return false;
    }
  }

  Future<void> delete_unique_product_id(String product_unique_id_of_item) async {
    var encode_product_id = jsonEncode({"product_unique_id": product_unique_id_of_item});
    try {
      final delete_product_data_response = 'https://ecommerce123-alpha.vercel.app/delete_data_from_store';

      final response =
          await http.delete(Uri.parse(delete_product_data_response), headers: {"Content-Type": "application/json"}, body: encode_product_id);

      if (response.statusCode == 200) {
        print('Product successfully removed');
      } else {
        print('Product coulnot be removed');
      }
    } catch (e) {
      print('ERORRRRR');
    }
  }

  String? id;
  String? buyerUniqueId;

  List<String> productNames = [];
  List<String> sellerNames = [];
  List<String> productPrices = [];
  List<String> warranties = [];
  List<String> productImages = [];

  Future<bool> find_data_in_add_to_cart_collection(String buyer_id) async {
    var encodeUserData = jsonEncode({
      "buyer_unique_id_": buyer_id,
    });

    final addToCartUrl = 'https://ecommerce123-alpha.vercel.app/buyer/get_data_from_add_to_cart_by_unique_id';

    try {
      final addToCartDataResponse = await http.post(
        Uri.parse(addToCartUrl),
        headers: {"Content-Type": "application/json"},
        body: encodeUserData,
      );

      if (addToCartDataResponse.statusCode == 200) {
        final responseData = jsonDecode(addToCartDataResponse.body);

        productNames.clear();
        sellerNames.clear();
        productPrices.clear();
        warranties.clear();
        productImages.clear();

        for (var document in responseData) {
          productNames.add(document['product_name']);
          sellerNames.add(document['seller_name']);
          productPrices.add(document['product_price']);
          warranties.add(document['warranty']);
          productImages.add(document['product_image']);
        }

        print('Data fetched successfully: $responseData');
        return true;
      } else {
        print('Failed to fetch data: ${addToCartDataResponse.body}');
        return false;
      }
    } catch (error) {
      print('Exception occurred during HTTP POST request: $error');
      return false;
    }
  }
}
