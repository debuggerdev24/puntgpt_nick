enum UserRole { customer, creator }

class AppConfig {
  AppConfig._();
  static final UserRole userRole = UserRole.customer;
  static const String apiBaseurl = "https://api.noted.ae/api/";
  static const String imagesBaseurl = "https://api.noted.ae";
  static const String stripePublishKey =
      "pk_test_51S7yLt0uSUmTV4n9y7vXYPzcZT5y7k6sCVypMUF2PS20L5tGMQ9celbjL8eTrUX2ssZ6OebDhS4Cx2OZh23Ho3El004QiNFClA";
}

// pk_live_51S7yLt0uSUmTV4n9SHqo5q2hLNCpeVtYvRnq3ekC9K5Jb4NfZwU5U7yDz76p2pscNdXmt0TvtgV6ZpaI6UJPpCD700akTTc4cE
// pk_test_51S7yLt0uSUmTV4n9y7vXYPzcZT5y7k6sCVypMUF2PS20L5tGMQ9celbjL8eTrUX2ssZ6OebDhS4Cx2OZh23Ho3El004QiNFClA

/*p
test customer details 
---------------------
email: 
testuser@mailinator.com
victor.murray@mailinator.com
joel.peck@mailinator.com

pass: Pass@123



test creator
---------------------
email:
notedcreator1@mailinator.com (*)
testuser@mailinator.com

pass:
Pass@123

*/
