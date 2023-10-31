import 'package:lottie/lottie.dart';

notFound() {
  return Lottie.asset('assets/lottie/notFound.json', width: 200, height: 200);
}

search(double? width, double? height) {
  return Lottie.asset('assets/lottie/search.json',
      width: width, height: height);
}

loadingLottie(double? width, double? height) {
  return Lottie.asset('assets/lottie/loading.json',
      width: width, height: height);
}

book(double? width, double? height) {
  return Lottie.asset('assets/lottie/book.json', width: width, height: height);
}
