
import 'dart:developer';
import 'package:gsheets/gsheets.dart';


class GoogleSheetInit{
  static const _credentials = r'''
{
  "type": "service_account",
  "project_id": "nubcc-438509",
  "private_key_id": "a23fac573bb0f3cff962f63c18e7aa2a5f2c2ae0",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDmxOZP/gDwoJ9V\n9OcqQfF+x6MNQ4cU0/Kw+ZCkQ++GqInzcxAIrhxwGIQ9XRaKEBS3yw1j5TaX50B4\nNs8a9JVqDGr3Q6wMWUuZfdcJrcjn6x+ZFRiOyjT3F+R+bQciLX7tU5wn4ODsMGkB\ng1F7sB7JbKZYNqBw8V9qygrE3SOau+Ggx6i1HhS0xcS7CuFdF2mq/r1ZzQhj4c1y\nTB1Ff2blk2LLaP3jBPnK9o7u81U6DE2qvPu0hpymCSi+0HY4GqgC3wr/d3jaAOS9\nxRX564XI6surHQQWCXsRUjL+q4jbmCYcLP3X0Ze/hKxHoZa0K39r258hVijqMcZp\nFFFN6inhAgMBAAECggEAAQJrjsc8IQgxH/Ph+kU8pZdu5eiP9ivTmtddM9x2W83C\nJZTeu/pqJBL1qo5WOSdQNixSP5EC3YR0xMZsUQBVZI7B2SuMOALlRUymldXcT6hB\n0k5bI64w1HqWvcBoILBTC33v0PfXUuSZLP3EvhYpLOMHv2RAWlhpGIxiNL9SLahE\n0zxas01KWsBYahPhgYXv8NSbrfKigNWdEKVXuShqcJu+JstUi43o/PR2R3YctCVY\nGZXxS/mOsiFgMfGd1L8xTPskg39H44gGviWruFgBhtOl7XjazwloXbZBAm+X9evy\nnyItZ6iss5f+BP+bw5goOTfYA49VKrBDOJPV51d/nQKBgQD+JvwDlue6ewG3eaJr\no3WyGt5MApjifFb3lRsYV7eJq2LVM/pNvfhOT2bW3Xd3D269srV6RKS2hKSsbYgV\nL2vrBMKSqfBAJ7XL7JTaZyNBYtwZJRNASlJDAFB8kCwtSoGvaKV2lUK3MLb4jSxW\nwSouFdv20pSzxU3mlCqMO2fdlQKBgQDocmVLrg4XmNmPB81K6mHOGFPH0I9/5nsz\nx1T7rfet4KHbmVy3dJjc2FEpEUs+eWkik7CbscZRsfXhGVovRrlZC+AiazUKfiEj\nDyMFLxOFcvH9hdFiLKqk/+ahLmW+rLFTg+b60x50I6nZf0dw8jbmaqL+iO/Ra/IV\nXMGJ2WnQHQKBgQCvOy3TQ76uIpWCbUkBMgi6LjBK9Bd5QQWtWo7976zKLPLN0TKp\nW2vSgoiDaNsvqeJOxOK/VIjElxv7DuIeyT19IyEMgkL12OtNmObg1u/F62WZqKhn\nUVb6f0L/P2BWMeLMkDhVVIBVUi81nBCQGEr+z2+D9Jk2gbk+W7YiTetFKQKBgCd1\nS9a1/DRrQPszsti1wtaOcKJpuAJZKK7Ydoemt3WvvSoe9Ys64rwSiGx1QBWh3IP/\nGCrF2cmCcR++Av4lfk8sYebV1hIq6Qsfha1amXC823FS5wFIXctWmVrhGmpsvElW\nCb6oWfITH8EJByKYK1Of5H1a14LwVQ7lSQFSg9DNAoGBAKsGMMIWj6mHMrvoGPrj\nkfBo2AIDeH5BXlTub7a1O3zjrrB2b/UJbuvhmHyEEKydkmA7ADqjko4gEb6stym1\n0/JoDTYOnirhjlfhsAM9Ai35ahrNpJki7G1DX6IF0SvcDvJVUi+BCMNiDZaHsakK\n/Lbg5iTgAWEBaJHu1B4njf+C\n-----END PRIVATE KEY-----\n",
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

  Future inti() async{
    try{
       spreadSheet = await gSheets.spreadsheet(_spreadSheetId);
    }
    catch(exception){
      log("Init error : $exception");
    }

  }
}