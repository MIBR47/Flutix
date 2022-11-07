part of 'shared.dart';

Future<XFile?> getImage() async {
  // ignore: no_leading_underscores_for_local_identifiers
  final ImagePicker _picker = ImagePicker();
  final XFile? pickedFile;
  pickedFile = await _picker.pickImage(source: ImageSource.gallery);
  // if ((pickedFile = await _picker.pickImage(source: ImageSource.gallery)) !=
  //     null) {
  //   // img = File(pickedFile.path);

  // }
  return pickedFile;
  // return null;
}

Future<String> uploadImage(File image) async {
  String fileName = basename(image.path);
  FirebaseStorage storage = FirebaseStorage.instance;
  Reference ref = storage.ref().child(fileName);

  UploadTask uploadTask = ref.putFile(image);

  var imageUrl = await (await uploadTask).ref.getDownloadURL();
  // print(imageUrl);
  return imageUrl;
}

String convertToIdr(dynamic number, int decimalDigit) {
  NumberFormat currencyFormatter = NumberFormat.currency(
    locale: 'id',
    symbol: 'IDR ',
    decimalDigits: decimalDigit,
  );
  return currencyFormatter.format(number);
}

Widget generateDashedDivider(double width) {
  int n = width ~/ 5;
  return Row(
    children: List.generate(
        n,
        (index) => (index % 2 == 0)
            ? Container(
                height: 2,
                width: width / n,
                color: Color(0xFFE4E4E4),
              )
            : SizedBox(
                width: width / n,
              )),
  );
}
