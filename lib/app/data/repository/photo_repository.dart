import 'package:wapp_chat/app/data/provider/firebase_provider.dart';

class PhotoRepository {
  final firebase = FirebaseProvider();

  swapProfilePhoto() async 
    => await firebase.swapPhoto();

  removeProfilePhoto(String userId) async 
    => await firebase.removeProfilePhoto(userId);

  getNetworkImage(String imgUrl) async 
    => await firebase.networkImageToBase64(imgUrl);
}
