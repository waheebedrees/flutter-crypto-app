// import 'holding.dart';

// class Wallet {
//   final String id;
//   final String userId;
//   double balance;
//   List<Holdings> holdings;

//   Wallet({
//     required this.id,
//     required this.userId,
//     required this.balance,
//     required this.holdings,
//   });

//   factory Wallet.fromJson(Map<String, dynamic> json) {
//     return Wallet(
//       id: json['id'],
//       userId: json['userId'],
//       balance: json['balance'].toDouble(),
//       holdings:
//           (json['holdings'] as List).map((h) => Holdings.fromJson(h)).toList(),
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'userId': userId,
//       'balance': balance,
//       'holdings': holdings.map((h) => h.toJson()).toList(),
//     };
//   }
// }
