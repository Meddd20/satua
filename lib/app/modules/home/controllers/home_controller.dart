import 'package:get/get.dart';
import 'package:satua/app/common/toast_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeController extends GetxController {
  final String whatsappNumberNiKetutJeniAdhi = '6281239614056';
  RxBool isShowUsername = true.obs;
  RxString username = "Parents".obs;

  @override
  void onInit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isShowUsername.value = prefs.getBool('isShowUsername') ?? true;
    if (isShowUsername.value) {
      print("truesnka");
      username.value = prefs.getString('username') ?? "Parents!";
    }
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void openWhatsAppChatWithNiKetutJeniAdhi() async {
    final whatsappURL = Uri.parse("https://wa.me/$whatsappNumberNiKetutJeniAdhi");

    bool canLaunch = await canLaunchUrl(whatsappURL);

    if (canLaunch) {
      await launchUrl(whatsappURL, mode: LaunchMode.externalApplication);
    } else {
      showToast('Gagal membuka WhatsApp.');
    }
  }
}
