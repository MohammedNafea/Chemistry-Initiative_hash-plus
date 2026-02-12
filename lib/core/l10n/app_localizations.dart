import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;
  AppLocalizations([this.locale = const Locale('en')]);

  bool get isArabic => locale.languageCode == 'ar';
  TextDirection get textDirection =>
      isArabic ? TextDirection.rtl : TextDirection.ltr;

  String get contactInfo => isArabic ? 'معلومات الاتصال' : 'Contact Info';
  String get settings => isArabic ? 'الإعدادات' : 'Settings';
  String get editProfile => isArabic ? 'تعديل الملف الشخصي' : 'Edit Profile';
  String get email => isArabic ? 'البريد الإلكتروني' : 'Email';
  String get phone => isArabic ? 'الهاتف' : 'Phone';
  String get location => isArabic ? 'الموقع' : 'Location';
  String get language => isArabic ? 'اللغة' : 'Language';
  String get englishLabel => isArabic ? 'الإنجليزية' : 'English';
  String get arabicLabel => isArabic ? 'العربية' : 'Arabic';
  String get theme => isArabic ? 'المظهر' : 'Theme';
  String get logout => isArabic ? 'تسجيل الخروج' : 'Logout';
  String get save => isArabic ? 'حفظ' : 'Save';
  String get profileUpdated =>
      isArabic ? 'تم تحديث الملف الشخصي' : 'Profile updated';
  String get name => isArabic ? 'الاسم' : 'Name';
  String get bio => isArabic ? 'نبذة' : 'Bio';
  String get notifications => isArabic ? 'الإشعارات' : 'Notifications';
  String get privacySecurity =>
      isArabic ? 'الخصوصية والأمان' : 'Privacy & Security';
  String get helpSupport => isArabic ? 'المساعدة والدعم' : 'Help & Support';
}
