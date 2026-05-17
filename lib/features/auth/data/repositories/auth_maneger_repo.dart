// import 'dart:developer' as developer;

// import 'package:perk_app/core/database/local_database.dart';
// import 'package:perk_app/core/service/api_service/dio_service.dart';
// import 'package:perk_app/core/service/api_service/hive_keys.dart';
// import 'package:perk_app/core/service/device_id.dart';
// import 'package:perk_app/features/auth/data/model/login_entity.dart';
// import 'package:perk_app/features/auth/domain/repositories/auth_master_repo.dart';

// class AuthManagerRepository implements AuthMasterRepository {
//   @override
//   Future<LoginModel> signIn({
//     required String email,
//     required String password,
//   }) async {
//     LoginModel loginModel = LoginModel();

//     try {
//       final response = await DioService.dioPostApiCall(
//         data: {
//           "activity": "login",
//           "deviceID": DeviceService.getDeviceId(),
//           "uEmail": email,
//           "uPassword": password,
//         },
//       );

//       if (response.statusCode == 200) {
//         loginModel = LoginModel.fromJson(response.data);
//         developer.log(
//           'Login successful: ${response.data}',
//           name: 'SignIn Success',
//         );
//         if (loginModel.status == 1) {
//           await HiveService.setter(key: HiveKeys.userAuthToken, value: true);
//           await HiveService.setter(
//             key: HiveKeys.userFirstName,
//             value: loginModel.record?.userFirstName,
//           );
//           await HiveService.setter(
//             key: HiveKeys.userLastName,
//             value: loginModel.record?.userLastName,
//           );
//           await HiveService.setter(
//             key: HiveKeys.userEmailID,
//             value: loginModel.record?.userEmailID,
//           );
//           await HiveService.setter(
//             key: HiveKeys.userMobileNumber,
//             value: loginModel.record?.userMobileNumber,
//           );
//           await HiveService.setter(
//             key: HiveKeys.userAlternateNumber,
//             value: loginModel.record?.userAlternateNumber,
//           );
//           await HiveService.setter(
//             key: HiveKeys.userBalance,
//             value: loginModel.record?.userBalance,
//           );
//           await HiveService.setter(
//             key: HiveKeys.userImage,
//             value: loginModel.record?.userImage,
//           );
//           await HiveService.setter(
//             key: HiveKeys.userActiveTrade,
//             value: loginModel.record?.userActiveTrade,
//           );
//           await HiveService.setter(
//             key: HiveKeys.userCloseTrade,
//             value: loginModel.record?.userCloseTrade,
//           );
//           await HiveService.setter(
//             key: HiveKeys.userPendingTrade,
//             value: loginModel.record?.userPendingTrade,
//           );
//           await HiveService.setter(
//             key: HiveKeys.userProfitLoss,
//             value: loginModel.record?.userProfitLoss,
//           );
//           await HiveService.setter(
//             key: HiveKeys.userKey,
//             value: loginModel.record?.userKey,
//           );
//           await HiveService.setter(
//             key: HiveKeys.agentQR,
//             value: loginModel.record?.agentQR,
//           );
//           await HiveService.setter(
//             key: HiveKeys.agentBankName,
//             value: loginModel.record?.agentBankName,
//           );
//           await HiveService.setter(
//             key: HiveKeys.agentHolderName,
//             value: loginModel.record?.agentHolderName,
//           );
//           await HiveService.setter(
//             key: HiveKeys.agentAccountNumber,
//             value: loginModel.record?.agentAccountNumber,
//           );
//           await HiveService.setter(
//             key: HiveKeys.agentIFSCCode,
//             value: loginModel.record?.agentIFSCCode,
//           );
//         }
//       } else {
//         developer.log(
//           'Login failed with status code: ${response.statusCode}',
//           name: 'SignIn Failed',
//         );
//       }
//     } catch (e) {
//       developer.log(e.toString(), name: 'SignIn Error');
//     } finally {
//       developer.log('Login attempt completed', name: 'SignIn Completed');
//     }

//     return loginModel;
//   }
// }
