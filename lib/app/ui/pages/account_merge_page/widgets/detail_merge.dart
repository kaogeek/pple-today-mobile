// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailMerge extends StatelessWidget {
  const DetailMerge({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'เราพบบัญชีของคุณในระบบ MFPToday',
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 18,
          ),
        ),
        SizedBox(height: context.isPhone ? 32 : 40),
        Text(
          'อีเมลของคุณมีอยู่แล้วในระบบ คลิกที่ปุ่ม "ถัดไป" ด้านล่างและใช้รหัส OTP ที่ส่งไปยังกล่องจดหมายในอีเมลของคุณเพื่อผสานบัญชีผู้ใช้เข้าด้วยกัน',
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
