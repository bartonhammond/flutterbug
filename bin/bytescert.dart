import 'dart:io';

/// Util for byte list representation of certificate.
///
/// You should set certificate name in args.
/// Certificate should be in certs folder.
///
/// Call example:
/// dart main.dart cert.pem
///
/// Exit codes:
/// 0 - success
/// 1 - error
void main(List<String> arguments) {
  var certFile = File("lib/myfamilyvoice.pem");

  if (!certFile.existsSync()) {
    exitCode = 1;

    throw Exception('File certificate ${certFile.path} not found.');
  }

  String fileNameWithoutExt = "lib/myfamilyvoice";

  var cert = certFile.readAsBytesSync();
  var res = "List<int> myfamilyvoice = <int>[${cert.join(', ')}];";
  var resFile = File("lib/$fileNameWithoutExt.dart");

  if (!resFile.existsSync()) {
    resFile.createSync(recursive: true);
  }

  resFile.writeAsString(res);
}
