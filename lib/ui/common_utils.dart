class CommonUtils {
  static String getImgBySize(String sourceUrl, int width, int height) {
    return sourceUrl.replaceAll('1280X720X2', '${height}X${width}X2');
  }

  static String getImgMid(
    String sourceUrl,
  ) {
    return sourceUrl.replaceAll('1280X720X2', '320X180X2');
  }

  static String getImgSmall(
    String sourceUrl,
  ) {
    return sourceUrl.replaceAll('1280X720X2', '80X45X2');
  }
}
