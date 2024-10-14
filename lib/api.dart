
import 'package:gsheets/gsheets.dart';

class UserSheetApi{
  static const _credentials = r'''
  {
  "type": "service_account",
  "project_id": "nubcc-438509",
  "private_key_id": "63138c77faed27a86519f9031ed095798cd5439a",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCIBZ7uBA8aJcLW\n+P4+kjkgbWRItnsfnhiIaUkAtQ+rZh4jb0lowkmLGfqd3W3mX2x1gST7h/UnZiYT\n2wTSp1pDsFa35se/r8Bgq7pqUkwbQLMiUXHaXuJaURPEHC/EDfemUVDpO5IIGzTs\n6ASvFFN/M7fjvCt6DlA1eII8u1daIcz5awFjROfJZ1sQ4x9jiLjMzXdorJaurTb+\nuQnEvqxT5VFdtubOlmhKlQGyIs3+Y8NaJKQ/hTxH7XCyALrqwhH2Bx/Q4VprdaO1\nOHnV6FmOcsHIjNarVON+qkHTdfx/pqGTBQOx7wucv7EDel7JNmZHf+mZ1f9KDwL8\nyiJ3peKLAgMBAAECggEAHzO24N+CfVuDJeAJJl5Rh2xAkGN3u+l+tC/+pJBkL0um\nBzfcjZDf4O5NLJBiSPHDxfKhgqeN54NJoc1gflgQXy2gvt/MG18cELDj+sa1GZ1O\nWkV3igGxB8nIcHiMxnrzv62wk0fseDqRefTBOk491xSMjsuX55BH+vQRYBATeiOo\nLbz+XHyKolGOdz5y+KBWiu75wDJ6ZLP25uvz/2921wEa8Ez77keE2+S3uHTK2VVB\njoyYlJ+6tlIKRpyPWKKGtrlI3AP3nc+UjJLTbF/7uqOYFrZhNglV5IWVfmZTXNWU\nU4AxCYbkv9iwX5gQmh62Dg7WcSnMkH76vsqXxlZ+IQKBgQC70+o33Is5V3tn5TPW\n+5qoScLtgrGe4OaNzpLK80wtSY9JrvzK74HUTgdMW8zuUmOWbUHbdmNi8r0mgAP7\n4F3UTIySThdS+Y9X9uhBo/aLlZ0UdRoy5XD/Et19icFeRDeCIrBny7vJjgVgvha+\n/vqmZpXKcLN7ZDRWNsIKZFHf6wKBgQC5ZCYDre1I3x+B/BUk/DFo7a7EqUcisiQW\nMuboo1wiCfznMYilL5Namf2RSN/EM9p1fNfmm4qRwIY7UXNTbMBKr0bpejoKjEPc\nsnJPlsorLRk7+mfWHG/88duzWmwWstKk2SiSgROseVHQR2zVVVfv/QfYX2R4xey8\n+MERBK//4QKBgCsTYKXLCIrwCzc6k3b8YO2zbOb3kDC1t2pSM8wjnBbOxfPKE+Oe\nphHAi1/xtb/6WSiIihAAyK5KqSKJPWCohhxIKfzrt+GppjwwPfe/2K0OdOXaLVX6\n1L1K4E0IKLarwmcv+XD0gm6pCYa0UZcf9u/umu/AhQkJZA9Zo4qqkzRdAoGBAIQr\njRqEbi3MvMbL9Dso/QTkpvuX/5oRzL5yzcK/bFjsK/ybiOLTd0dZj7h7buSPX0jx\nl27WJ0VgL5Ksr/6jArh8G58qv6RzeZInOm3ZgAqmHV5wWIUCQyjfORW1+md4V8qk\n81L3aRJGb/iAY2v4azgyedxdreCYov3ajrJWWC+hAoGBALXCrHd5GCP1b8YUzoAk\nuaQBa5hGTXOkXRSC5ASeLGX32RMqIUfb8+J1rU1RsFKvXI8kJmA3WEYOLKgzRlHl\nYWOznrqn4jrCxDvvKsnXEhEhESt8kScBTnN6vbMiPegxt+eGyzePp76qM93Vel5Z\n7VzR1e7fXGpLO5XB0rmc24vE\n-----END PRIVATE KEY-----\n",
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
  static Worksheet? _userInfoSheet;

  static Future inti() async{
    final spreadSheet = await gSheets.spreadsheet(_spreadSheetId);
    _userInfoSheet = await _getWorkSheet(spreadSheet,sheetName:'UserInfo');
  }

  static _getWorkSheet(
      Spreadsheet spreadSheet, {
        required String sheetName
      }) async{
    try{
      return await spreadSheet.addWorksheet(sheetName);
    }
    catch (exception){
      return spreadSheet.worksheetByTitle(sheetName);
    }
  }
}