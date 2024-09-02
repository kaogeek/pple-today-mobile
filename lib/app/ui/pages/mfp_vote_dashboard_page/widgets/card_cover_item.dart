// import 'package:flutter/material.dart';

// import '../../../utils/assets.dart';
// import '../../../utils/colors.dart';

// class CardCoverItem extends StatelessWidget {
//   const CardCoverItem({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16),
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(bottom: 4),
//               child: Card(
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(16),
//                 ),
//                 child: Container(
//                   height: 445,
//                   width: 356,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(16),
//                   ),
//                   child: Stack(
//                     children: [
//                       buildVoteImage(),
//                       Column(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           buildLogo(),
//                           buildVoteTitle(),
//                           buildVoteTimeOut(),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 4),
//               child: Card(
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(16),
//                 ),
//                 child: Container(
//                   height: 445,
//                   width: 356,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(16),
//                   ),
//                   child: Stack(
//                     children: [
//                       buildVoteImage(),
//                       Column(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           buildLogo(),
//                           buildVoteTitle(),
//                           buildVoteTimeOut(),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 4),
//               child: Card(
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(16),
//                 ),
//                 child: Container(
//                   height: 445,
//                   width: 356,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(16),
//                   ),
//                   child: Stack(
//                     children: [
//                       buildVoteImage(),
//                       Column(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           buildLogo(),
//                           buildVoteTitle(),
//                           buildVoteTimeOut(),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 4),
//               child: Card(
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(16),
//                 ),
//                 child: Container(
//                   height: 445,
//                   width: 356,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(16),
//                   ),
//                   child: Stack(
//                     children: [
//                       buildVoteImage(),
//                       Column(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           buildLogo(),
//                           buildVoteTitle(),
//                           buildVoteTimeOut(),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget buildTopic() {
//     return const ListTile(
//       contentPadding: EdgeInsets.symmetric(horizontal: 16),
//       title: Text(
//         'ปักหมุด',
//         style: TextStyle(
//           color: Colors.black,
//           fontSize: 16,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//       trailing: Text(
//         'ดูทั้งหมด',
//         style: TextStyle(
//           color: kPrimaryColor,
//           fontSize: 12,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//     );
//   }

//   Widget buildVoteImage() {
//     return ClipRRect(
//       borderRadius: const BorderRadius.all(Radius.circular(16)),
//       child: Image.asset(
//         Assets.images.bagJPG,
//         height: 445,
//         width: 356,
//         fit: BoxFit.cover,
//       ),
//     );
//   }

//   Widget buildLogo() {
//     return Padding(
//       padding: const EdgeInsets.only(left: 8),
//       child: Row(
//         children: [
//           Stack(
//             alignment: Alignment.center,
//             children: [
//               const CircleAvatar(
//                 radius: 11,
//                 backgroundColor: Colors.white,
//               ),
//               CircleAvatar(
//                 radius: 10,
//                 backgroundColor: kPrimaryColor,
//                 child: Image.asset(
//                   Assets.images.ppleTransparentPNG,
//                   color: Colors.white,
//                   width: 10,
//                   height: 10,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(width: 8),
//           Text(
//             'พรรคประชาชน',
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 10,
//               fontFamily: Assets.assetsFontsAnakotmaiMedium,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget buildVoteTitle() {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Text(
//         'ช่วยกันดูแลดอกผลไม้โพยภัย จากเหลือบโรที่เกาะกินแผ่นดินนี้ให้ผู้คนได้ชื่อชมกลางสายลมแห่งเสรีทุ่งหญ้าฟ้านี้คนเทียมเท่า',
//         style: TextStyle(
//           color: Colors.white,
//           fontSize: 12,
//           fontFamily: Assets.assetsFontsAnakotmaiMedium,
//         ),
//       ),
//     );
//   }

//   Widget buildVoteTimeOut() {
//     return Padding(
//       padding: const EdgeInsets.only(left: 8, bottom: 16),
//       child: Text(
//         'ต้องการอีก 130 รายชื่อ เพื่อเปิดโหวต',
//         style: TextStyle(
//           color: kPrimaryColor,
//           fontSize: 10,
//           fontFamily: Assets.assetsFontsAnakotmaiMedium,
//         ),
//       ),
//     );
//   }
// }
