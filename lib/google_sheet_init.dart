
import 'dart:developer';
import 'package:gsheets/gsheets.dart';


class GoogleSheetInit{
  static const _credentials = r'''
{
  "type": "service_account",
  "project_id": "nubcc-438509",
  "private_key_id": "d1965dca973a797f2b738034d569c524c9c1474f",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCn140WEXFZtExR\nStS73USnH2X9KeURiiesD0AkXNsdvjLyh69M+Kd8znJ1CO9TrCnmxDOvPSMBMNaa\nsfzSK5lbiVJlbsNiDziuUcQFvgQV/SR2ZB4zvZyrdF1JjKdFJ0JMmn8t7Ajhgum6\nYyPRXu0W2w+lRmb0NnuVF5OMgC+qtOav4B9h6KEpEdu+VC+uYHPBXoXD0BQJvfsA\n0G5vgvG11/ZB2e4mGcrACsEKIJ5pikpbshZvKjhPRSRkYmu0MiRpGc1Lmc0bRslw\nwqW+bxvrr2MjKw/GUwlxQhQcc9xRpf1gfpuTv8rmCmLVowUt8A8Zn2KJ14xdFvps\nQNpttnqVAgMBAAECggEADPSTwgL7/4iYkM3N4z0Ocjf3j2Bke24b5ylmMhMDdtBE\n7njlYcjvugUqyziIAKq8BpaucUsEILC8X+8iggvg0of5rDVYhNaCnDIDh3ibUsyE\nu/65C2q0unyeQXHHQjc9jtwoukq12h0DcuJO1CJs+o6o2Su4rAZok6GLlL9wQ8+C\nu8SUnYb9ITQSc91cqRSCS3l4PteJ8OrCp2wJng3TjMU36sgobmWkba7uatuyizwP\n/YeWE+meNGH6ZV6wUySV/CHsZCJwDDLFfHGi04r/JgjZ5PLxdhavd8nWdn8tSdT1\nBMfLgXQ6yFlpZskUEhiU3EvjKwMDKc2Nq3Ek7BoIAQKBgQDjX+0SiaUuDcxl04+8\nfll0v7dcK8rlo8rrHUDmDxM6b7Y4BBFbpuDyysKrKfWvudzQFuO8RHVTN3pg8xYw\nOsUgdW4Ime4plcgehmfTAO4BUOKIxpz05aA1KaO5KrkMprSo6ne34XloHaPmK8Q+\nqD7eh4fsJvzk08/h0TqIB3EH1QKBgQC8+PEBrBZgeUVGjYbAUqZ4mOBT88wOzADq\niEQLCY6JzKNT5pofMBqbVQ+ak2i8Z2o+ilOil8L1HkKpKQtwJaSxU310OioCmGFM\nWvKLOX+eQ3zUzhK0zanGuh/+5Dgfgc3lcbwc2hk7r34DvQrk/sbVozFD1exs2/c7\ngdldeEXHwQKBgEdxLJxWg4Ak9cRI5TDkwlbcplBfsjDVdjzJxEqFEhWaZDbVkF6r\n4KJo8yG03W2JiMgZaRUOrY6oL9umhaJB1Q6N1zT8qMiIN4jf0l+KOz5Om98+CLMq\nM1yA6OCVe+9tsfYhNdyhC/Sa25TGy7KkSpzBGQQqe+uqYfciNrHnJKzBAoGBAKbG\nkXTnWmxUOsZ0extbFh5S1ZBiFpJsitZx4pNXINwOpYqTdyvVOXYjUP0b4ZB9OG/v\nhrZ1d5L63NwMJFMadcomJA8ikhbuQtivX2VuHmofp5jsMegtpguEEl7TLZDo7zzy\n7pEMDr71N6K3AVluXS8Isp7qupisXPrAs4RhdDxBAoGBAJwfOy90EyyzXlIbtgab\nnTM+2pwoYtKlLeNxlDHY26MbTzLV2/aeCjP+2ZHJ3u6+xTSNRa+ZFWjyBnSFKWaR\nC36yv6pJ/3Lzy77yF+y/tAkN1qtvvIsq2KEAThqng0QKwBQVVI8YXAbtSouLNUgb\nxh6l/LWV83drD/7q4pB0mpmg\n-----END PRIVATE KEY-----\n",
  "client_email": "nubcc-640@nubcc-438509.iam.gserviceaccount.com",
  "client_id": "111282512136301317467",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/nubcc-640%40nubcc-438509.iam.gserviceaccount.com",
  "universe_domain": "googleapis.com"
}
  ''';
  static const _spreadSheetId ='1-M8rypfYDZPaOzMN9V129T9DcCtQGT7kWYnu6BiBzcM';

  static final gSheets = GSheets(_credentials);
  late var spreadSheet;

  Future<dynamic> inti() async{
    try{
      return spreadSheet = await gSheets.spreadsheet(_spreadSheetId);
    }
    catch(exception){
      log("Init error : $exception");
    }

  }
}