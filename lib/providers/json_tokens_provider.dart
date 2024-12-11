import 'package:jwt_decode/jwt_decode.dart';
import 'package:shared_preferences/shared_preferences.dart';

class JsonTokensProvider {
  String? seller_id;
  String? email;
  String? password;

  // Method to decode the JWT token
  Map<String, dynamic> decodeJWT(String token) {
    // Decode the JWT token
    Map<String, dynamic> decodedToken = Jwt.parseJwt(token);
    print("Decoded Token: $decodedToken");
    return decodedToken;
  }

  Future<void> saveToken(String token, String email, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    print('-------------ffff');
    print("Email: $email");
    print("Password: $password");

    print('-----------------fffff');

    await prefs.setString('jwt_token', token);

    await prefs.setString('email', email);
    await prefs.setString('password', password);
  }

  Future<Map<String, dynamic>> getEmailAndPasswordFromJWT() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('jwt_token');

    if (token != null && token.isNotEmpty) {
      // Decode the JWT token
      Map<String, dynamic> decodedToken = decodeJWT(token);

      email = decodedToken['email'];
      password = decodedToken['password'];
      seller_id = decodedToken['seller_id'];

      print('JWT');
      print("Email: $email");
      print("Password: $password");
      print('JWT');

      // You can use seller_id, email, password as needed in the app.
      return decodedToken;
    } else {
      print("No JWT token found in preferences.");
      return {};
    }
  }

  // Method to check if the user is logged in (token exists)
  Future<bool> checkUserLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('jwt_token');

    if (token != null && token.isNotEmpty) {
      return true; // Token exists, user is logged in
    } else {
      return false; // No token, user is not logged in
    }
  }
}
