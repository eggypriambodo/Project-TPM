import '../service/repo_service.dart';

//Dengan memanggil method loadBooks(),  mengembalikan nilai dari class
//BaseNetwork dengan method get() diisi dengan parameter “text” dikarenakan ingin
//mengambil list dari user.

class RepoData{
  static RepoData instance = RepoData();
  Future<Map<String, dynamic>> loadRepos(String text) {
    return BaseNetwork.get(text);
  }
}