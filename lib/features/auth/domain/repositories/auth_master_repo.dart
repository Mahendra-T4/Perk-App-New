import 'package:perk_app/features/auth/data/model/login_entity.dart';

abstract class AuthMasterRepository {
  Future<LoginModel> signIn({required String email, required String password});
}
