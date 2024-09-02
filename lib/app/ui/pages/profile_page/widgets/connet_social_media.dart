// // ignore_for_file: prefer_const_constructors, must_be_immutable

// TODO
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../../../utils/assets.dart';
// import '../../../utils/colors.dart';
// import '../../../utils/enum.dart';

// class ConnectSocialMedia extends StatelessWidget {
//   ConnectSocialMedia({Key? key, required this.authUser}) : super(key: key);

//   final List<String> authUser;
//   RxString email = ''.obs;

//   final List _listSocial = [
//     {
//       'icon': Assets.assetsImagesFacebook,
//       'social': EnumLoginMode.facebook,
//       'width': 56.0,
//       'height': 56.0,
//       'color': facebookColor,
//     },
//     {
//       'icon': Assets.assetsImagesGoogle,
//       'social': EnumLoginMode.google,
//       'width': 56.0,
//       'height': 32.0,
//       'color': Colors.white,
//     }
//   ];

//   final _loading = false.obs;

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         Scaffold(
//           appBar: MyAppBar(),
//           body: Column(
//             children: _listSocial
//                 .asMap()
//                 .map((i, e) {
//                   return MapEntry(
//                     i,
//                     ListTile(
//                       onTap: () async {
//                         String _social = e['social'].toString().split('.').last.toUpperCase();

//                         if ((e['social'] == ModeType.Facebook) && (!authUser.contains(_social))) {
//                           _loading.value = true;

//                           final userFB = await loginCtrl.fetchLoginWithFacebook();

//                           if (loginCtrl.hasError) {
//                             _loading.value = false;
//                             MyDialog.defaultDialog(content: loginCtrl.errorCode);
//                             return;
//                           }

//                           if ((userFB.idToken ?? '').isEmpty) {
//                             _loading.value = false;
//                             return;
//                           }

//                           if ((userFB.email ?? '').isEmpty) {
//                             email.value = '';
//                             await popUpInputEmail();

//                             if (email.value.isEmpty) {
//                               _loading.value = false;
//                               return;
//                             } else {
//                               userFB.email = email.value;
//                             }
//                           }

//                           int? status = await loginCtrl.fetchCheckEmailUser(
//                             email: userFB.email,
//                             tokenFB: userFB.idToken,
//                             mode: ModeType.Facebook,
//                           );

//                           switch (status) {
//                             case 0:
//                               {
//                                 _loading.value = false;
//                                 Get.to(() => RegisterSocialSC(
//                                       imageFilePath: userFB.imagePath!,
//                                       displayName: userFB.name!,
//                                       email: userFB.email!,
//                                       mode: userFB.mode!,
//                                     ));
//                                 return;
//                               }
//                             case 2:
//                               {
//                                 _loading.value = false;
//                                 Get.to(() => MergeUserScreen(
//                                       mode: ModeType.Facebook,
//                                     ));
//                                 return;
//                               }

//                             default:
//                               {
//                                 _loading.value = false;
//                                 MyDialog.showSnackBar(
//                                   title: loginCtrl.checkEmailUserModel.message ?? 'Sorry, the network is down.',
//                                   type: TypeSnackBar.error,
//                                 );
//                                 return;
//                               }
//                           }
//                         } else if ((e['social'] == ModeType.Google) && (!authUser.contains(_social))) {
//                           final userGG = await loginCtrl.fetchLoginWithGoogle();

//                           if (loginCtrl.hasError) {
//                             MyDialog.defaultDialog(content: loginCtrl.errorCode);
//                             return;
//                           }

//                           if ((userGG.idToken ?? '').isEmpty) {
//                             _loading.value = false;
//                             return;
//                           }

//                           if ((userGG.email ?? '').isEmpty) {
//                             email.value = '';
//                             await popUpInputEmail();

//                             if (email.value.isEmpty) {
//                               _loading.value = false;
//                               return;
//                             } else {
//                               userGG.email = email.value;
//                             }
//                           }

//                           int? status = await loginCtrl.fetchCheckEmailUser(
//                             email: userGG.email,
//                             idToken: userGG.idToken,
//                             authToken: userGG.authToken,
//                             mode: ModeType.Google,
//                           );

//                           switch (status) {
//                             case 0:
//                               {
//                                 _loading.value = false;
//                                 Get.to(() => RegisterSocialSC(
//                                       imageFilePath: userGG.imagePath!,
//                                       displayName: userGG.name!,
//                                       email: userGG.email!,
//                                       mode: userGG.mode!,
//                                     ));
//                                 return;
//                               }
//                             case 2:
//                               {
//                                 _loading.value = false;
//                                 Get.to(() => MergeUserScreen(
//                                       mode: ModeType.Google,
//                                     ));
//                                 return;
//                               }

//                             default:
//                               {
//                                 _loading.value = false;
//                                 MyDialog.showSnackBar(
//                                   title: loginCtrl.checkEmailUserModel.message ?? 'Sorry, the network is down.',
//                                   type: TypeSnackBar.error,
//                                 );
//                                 return;
//                               }
//                           }
//                         }
//                       },
//                       leading: Container(
//                         width: 32,
//                         height: 32,
//                         decoration: BoxDecoration(
//                           color: e['color'],
//                           borderRadius: BorderRadius.all(
//                             Radius.circular(8),
//                           ),
//                         ),
//                         child: Image.asset(
//                           e['icon'],
//                           // width: e['width'],
//                           // height: e['height'],
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                       title: Text(
//                         'เชื่อมต่อกับ ' + e['social'].toString().split('.').last,
//                         style: TextStyle(
//                           fontFamily: Assets.assetsFontsAnakotmaiMedium,
//                         ),
//                       ),
//                       trailing: Checkbox(
//                         value: authUser.contains(e['social'].toString().split('.').last.toUpperCase()),
//                         activeColor: kPrimaryColor,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(4),
//                         ),
//                         onChanged: (value) {},
//                       ),
//                     ),
//                   );
//                 })
//                 .values
//                 .toList(),
//           ),
//         ),
//         Obx(() => _loading.value
//             ? Container(
//                 width: Get.width,
//                 height: Get.height,
//                 color: Colors.grey.withOpacity(.4),
//                 child: Center(
//                   child: CircularProgressIndicator(
//                     color: kPrimaryColor,
//                   ),
//                 ),
//               )
//             : SizedBox())
//       ],
//     );
//   }

//   Future<void> popUpInputEmail() async {
//     return await Get.defaultDialog(
//         title: 'อีเมลของคุณ',
//         content: Padding(
//           padding: EdgeInsets.symmetric(vertical: 4),
//           child: Container(
//             width: Get.width,
//             decoration: BoxDecoration(
//               color: Colors.white,
//               border: Border.all(
//                 width: 1.2,
//                 color: Colors.black12,
//               ),
//               borderRadius: BorderRadius.all(
//                 Radius.circular(10),
//               ),
//             ),
//             child: TextField(
//               style: TextStyle(fontSize: 14),
//               decoration: InputDecoration(
//                 hintText: 'อีเมล',
//                 hintStyle: TextStyle(fontSize: 14),
//                 contentPadding: EdgeInsets.all(12),
//                 border: InputBorder.none,
//               ),
//               keyboardType: TextInputType.emailAddress,
//               onChanged: (e) {
//                 email.value = e;
//               },
//             ),
//           ),
//         ),
//         textConfirm: 'ยืนยัน',
//         textCancel: 'ยกเลิก',
//         confirmTextColor: kPrimaryColor,
//         cancelTextColor: Colors.black,
//         buttonColor: Colors.white,
//         onConfirm: () {
//           Get.back();
//           return;
//         },
//         onCancel: () {
//           email.value = '';
//           Get.back();
//           return;
//         });
//   }
// }
