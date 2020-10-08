import 'dart:async';
import 'dart:io' as io;

import 'package:flutter/material.dart';

import 'package:bug/myfamilyvoice-cert.dart' as cert;

Future<int> fetchSite() async {
  final io.SecurityContext securityContext = io.SecurityContext();
  securityContext.setTrustedCertificatesBytes(cert.myfamilyvoice);

  final io.HttpClient httpClient = io.HttpClient(context: securityContext);

  httpClient.badCertificateCallback =
      (io.X509Certificate cert, String host, int port) {
    print("!!!!Bad certificate");
    return false;
  };

  io.HttpClientRequest request =
      await httpClient.getUrl(Uri.parse('https://myfamilyvoice.com'));

  io.HttpClientResponse response = await request.close();

  return response.statusCode;
}

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<int> futureSite;
  @override
  void initState() {
    super.initState();
    futureSite = fetchSite();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Fetch Data Example'),
        ),
        body: Center(
          child: FutureBuilder<int>(
            future: futureSite,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data.toString());
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              // By default, show a loading spinner.
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
