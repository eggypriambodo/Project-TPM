import '../service/user_service.dart';

//Dengan memanggil method loadBooks(),  mengembalikan nilai dari class
//BaseNetwork dengan method get() diisi dengan parameter “text” dikarenakan ingin
//mengambil list dari user.

class UserData{
  static UserData instance = UserData();
  Future<Map<String, dynamic>> loadUsers(String text) {
    return BaseNetwork.get(text);
  }
}