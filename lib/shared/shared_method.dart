part of 'shared.dart';

Future<XFile?> getImage() async {
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
