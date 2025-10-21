// class User {
//   String? sId;
//   String? email;
//   String? fullName;
//   String? phone;
//   String? gender;
//   String? role;
//   String? status;
//   bool? adminVerify;
//   List<String>? interest;
//   bool? active;
//   List<Null>? address;
//   int? iV;
//   String? resetPasswordOTP;
//   String? resetPasswordOTPExpiry;
//   bool? isEmailVerified;
//   String? refreshToken;
//   String? updatedAt;
//   String? profileImage;
//   List<Null>? badge;
//   List<Null>? customInterests;

//   User({
//     this.sId,
//     this.email,
//     this.fullName,
//     this.phone,
//     this.gender,
//     this.role,
//     this.status,
//     this.adminVerify,
//     this.interest,
//     this.active,
//     this.address,
//     this.iV,
//     this.resetPasswordOTP,
//     this.resetPasswordOTPExpiry,
//     this.isEmailVerified,
//     this.refreshToken,
//     this.updatedAt,
//     this.profileImage,
//     this.badge,
//     this.customInterests,
//   });

//   User.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     email = json['email'];
//     fullName = json['fullName'];
//     phone = json['phone'];
//     gender = json['gender'];
//     role = json['role'];
//     status = json['status'];
//     adminVerify = json['adminVerify'];
//     interest = json['interest'].cast<String>();
//     active = json['active'];
//     address = json['address'];
//     iV = json['__v'];
//     resetPasswordOTP = json['resetPasswordOTP'];
//     resetPasswordOTPExpiry = json['resetPasswordOTPExpiry'];
//     isEmailVerified = json['isEmailVerified'];
//     refreshToken = json['refreshToken'];
//     updatedAt = json['updatedAt'];
//     profileImage = json['profileImage'];
//     badge = json['badge'];
//     customInterests = json['customInterests'];
//   }
// }
