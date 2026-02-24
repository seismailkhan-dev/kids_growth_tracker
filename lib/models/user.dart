import 'package:family_health_tracker/core/services/format_service.dart';

class UserModel {
   String? uid;
   String? firstName;
   String? lastName;
   String? email;
   String? phone;
   bool? isPremiumUser;
   DateTime? createdAt;
   DateTime? updatedAt;

  UserModel({
     this.uid,
     this.firstName,
     this.lastName,
     this.email,
     this.phone,
     this.isPremiumUser,
     this.createdAt,
     this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      phone: json['phone'],
      isPremiumUser: json['isPremiumUser']??false,
      createdAt:json['createdAt'] == null? null : FormatService.parseDate(json['createdAt']),
      updatedAt: json['createdAt'] == null? null : FormatService.parseDate(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phone': phone,
      'isPremiumUser': isPremiumUser,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}