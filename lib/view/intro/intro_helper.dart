class IntroHelper {
  getImage(int i) {
    return 'https://sashaktnirmaan.com/assets/uploads/media-uploader/intro${i + 1}.png';
  }

  geTitle(int i) {
    List title = [
      "Repairing Services",
      "House Cleaning Service",
      "Home Shifting Service"
    ];
    return title[i];
  }

  geSubTitle(int i) {
    List subTitle = [
      "Get repaired anything from our thousands of experts",
      "Get house cleaning services from expert cleaners",
      "Take our home shifting service to get best service"
    ];
    return subTitle[i];
  }
}
