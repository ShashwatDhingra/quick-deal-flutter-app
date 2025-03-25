// import 'dart:developer';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/foundation.dart';
// import 'package:googleapis_auth/auth_io.dart';

// class GlobalServerKey {
//   Future<String> getServerKey() async {
//     try {
//       final scopes = [
//         'https://www.googleapis.com/auth/userinfo.email',
//         'https://www.googleapis.com/auth/firebase.database',
//         'https://www.googleapis.com/auth/firebase.messaging'
//       ];

//       final client = await clientViaServiceAccount(
//           ServiceAccountCredentials.fromJson({
//             "type": "service_account",
//             "project_id": "quick-deal-90601",
//             "private_key_id": "a5df7aad7cdfc40d3a389fd23a418ee2c04798e3",
//             "private_key":
//                 "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQDD4owOwOe2QJLY\n6v5DDGs9xvGglZdK+Kwiqx1+9+yuRmeUbnXx3m3aBKYZ57TQkgmUMaDKbZiHtk+H\n53jBrDPWXuEbwapDCDFyCcLYfidyPjqWGTtQuWT0uFAano6DSHaM9j4BxzO5LH0d\ne3/FcDiENPAbXzHUHEbiRjhc7WaS3ACKJlNFxSDZiMypXZ2dH3TJFdK8tWHBTeVV\n/6y1NF1Dx/cDTP6nxGtbLGUD7uHm6YSigAYbaNJzfXfkKnC65bdaL8AfBbDdt1/z\nCSzNPS1LajTu1l+x3gTyXqxiZRssdzF3RHtoN+9cLLK/ueeOew1rcNMEGGDVa4IZ\nNGZOd4sfAgMBAAECggEACrgiAUit0BEL4tJGjwq7RPUsZyTofjzKHAI7Kfs343g3\ngNg5R2lsSirzn/qdsBrdv/37QONAc+TBHhHHpOmJ01L72etTfY7m4x5aSu3ptgcR\nE60BIZ4Tl+S3gCK/GmYOaWZW5v1XUkHMqEldfkNxhE0/+m96KD5SjrKtsOrOMH5r\nCDfnmbV6fBqrR7M7zRF3g6VmpxomQ+P0AmrTZNjKoDFYhXP89zpFQJNQ25Cky8a+\nY7wYmYRSblwWiq59hN3WNZ8Ha4pW0fD3iN2twLeGMZAbtfpWo7I4a0nAQGyybSSi\nUjqxl9YRu4ng7zf+cbs3SJDsoO7ywf6jqTrXMmq+CQKBgQDgb+aUF4ThTJgarRwJ\nOwnN3DvFEt3rnuHsLxni3W3ym2N5t1K+SUMEPBtG93vZVdfH4nvKnlpBBepgvujv\nNum2Hs7HYma2qR5wQNgyJtUMS5ndl4bVIlD3z7snN3bFv2uTLkyhR5JLCoptmGi2\nKGVuP19cm4rBJaDDL60dQY5yowKBgQDfbrjrQEHmZnpjP5SVw/RAUTiW60oTLBch\ngQRy2fmEKoYtrCoMLGb1Cjr2xe+FmR7oSGSfNo+PKqDyESvi+WgGOES/u7XRVMIj\nLKrzY246ACYxvYa/NueII1EPIwLg6wG17BlXyyfHRsmpv3ABqev1FYtSWMjADPcA\n4O1CiUlJVQKBgBYU7GrFpZ1FG/ID9i4yUNSgRoEtSghUqYXDXJilkJu+Dht7nfh6\n3M0d3NEuqFDJ0WEpN2TID7k2C8lY/zIKBRSWE2IqnFB8czI4Lw1AJNYA2jKjJfDy\nX2UCWzeQjW8HVl40v/VeRVZ8wwHlbOf/MXuXYJqL8yrtuNN7bVzjhlBhAoGAHjPe\nZVaTUezKYH4ovLH3Y3ZXOvdlVQAhxFKnYksa0oXZC3V5XZnm9PrEC7Wn8hxHtEiM\n6YS7lTPC+9XcY9so96ZFjNF3+2sErzKLjUkEjmyUvSaMf26Rj7KOc4hdDEBYQ9o9\ndsOsheCIxBxvrJnmnoOiCKidwnA+N20wRU0/jd0CgYB/YE/GoZ2WGtqDwa0UAFVS\n5OXvoYatE+ljSxDkFMS5VFipsjE2tJjW/uCaQa4k3+PQVOVYEcuiCkYauK8ZRkYN\nIGrmVgcKnNBkBhHhEMjz+XBrFc5FlQ/pSNfdvNdIjBrL4fE0wB12AOhRk7Xpky6x\nDe975ja0/eUVtMSYQpyenw==\n-----END PRIVATE KEY-----\n",
//             "client_email":
//                 "firebase-adminsdk-fbsvc@quick-deal-90601.iam.gserviceaccount.com",
//             "client_id": "104212430200853940167",
//             "auth_uri": "https://accounts.google.com/o/oauth2/auth",
//             "token_uri": "https://oauth2.googleapis.com/token",
//             "auth_provider_x509_cert_url":
//                 "https://www.googleapis.com/oauth2/v1/certs",
//             "client_x509_cert_url":
//                 "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-fbsvc%40quick-deal-90601.iam.gserviceaccount.com",
//             "universe_domain": "googleapis.com"
//           }),
//           scopes);
//       log("client.credentials" + client.credentials.idToken.toString());
//       final expiry = client.credentials.accessToken.expiry;
//       log("expiry" + expiry.toString());
//       final accessServerKey = client.credentials.accessToken.data;
//       if (kDebugMode) {
//         print("server_key: " + accessServerKey);
//       }
//       return accessServerKey;
//     } catch (error) {
//       if (kDebugMode) {
//         print("Error: " + error.toString());
//       }
//       return "";
//     }
//   }
// }
