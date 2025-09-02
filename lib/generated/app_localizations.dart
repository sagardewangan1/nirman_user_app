import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_bn.dart';
import 'app_localizations_en.dart';
import 'app_localizations_hi.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('bn'),
    Locale('en'),
    Locale('hi')
  ];

  /// No description provided for @male.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get male;

  /// No description provided for @female.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get female;

  /// No description provided for @pending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get pending;

  /// No description provided for @complete.
  ///
  /// In en, this message translates to:
  /// **'Complete'**
  String get complete;

  /// No description provided for @invalidUrl.
  ///
  /// In en, this message translates to:
  /// **'Invalid URL'**
  String get invalidUrl;

  /// No description provided for @requestTimeout.
  ///
  /// In en, this message translates to:
  /// **'Request Timeout'**
  String get requestTimeout;

  /// No description provided for @message.
  ///
  /// In en, this message translates to:
  /// **'Message:'**
  String get message;

  /// No description provided for @unauthenticated.
  ///
  /// In en, this message translates to:
  /// **'Unauthenticated.'**
  String get unauthenticated;

  /// No description provided for @storedValues.
  ///
  /// In en, this message translates to:
  /// **'Stored Values:'**
  String get storedValues;

  /// No description provided for @userDataResetInSharedPreferences.
  ///
  /// In en, this message translates to:
  /// **'User  data reset in shared preferences.'**
  String get userDataResetInSharedPreferences;

  /// No description provided for @allDataClearedFromSharedPreferences.
  ///
  /// In en, this message translates to:
  /// **'All data cleared from shared preferences.'**
  String get allDataClearedFromSharedPreferences;

  /// No description provided for @loginViewText.
  ///
  /// In en, this message translates to:
  /// **'Enter your mobile number below to receive a One-Time Password (OTP) for verification.'**
  String get loginViewText;

  /// No description provided for @numberValidation.
  ///
  /// In en, this message translates to:
  /// **'Please Enter Valid Mobile Number'**
  String get numberValidation;

  /// No description provided for @left.
  ///
  /// In en, this message translates to:
  /// **'Left'**
  String get left;

  /// No description provided for @data.
  ///
  /// In en, this message translates to:
  /// **'Data'**
  String get data;

  /// No description provided for @type.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get type;

  /// No description provided for @senderId.
  ///
  /// In en, this message translates to:
  /// **'Sender ID'**
  String get senderId;

  /// No description provided for @title.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get title;

  /// No description provided for @body.
  ///
  /// In en, this message translates to:
  /// **'Body'**
  String get body;

  /// No description provided for @us.
  ///
  /// In en, this message translates to:
  /// **'USA'**
  String get us;

  /// No description provided for @id.
  ///
  /// In en, this message translates to:
  /// **'ID'**
  String get id;

  /// No description provided for @serviceArea.
  ///
  /// In en, this message translates to:
  /// **'Service Area'**
  String get serviceArea;

  /// No description provided for @raipur.
  ///
  /// In en, this message translates to:
  /// **'Raipur'**
  String get raipur;

  /// No description provided for @shankarNagar.
  ///
  /// In en, this message translates to:
  /// **'Shankar Nagar'**
  String get shankarNagar;

  /// No description provided for @gudhiyari.
  ///
  /// In en, this message translates to:
  /// **'Gudhiyari'**
  String get gudhiyari;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @electronics.
  ///
  /// In en, this message translates to:
  /// **'Electronics'**
  String get electronics;

  /// No description provided for @subcategories.
  ///
  /// In en, this message translates to:
  /// **'Subcategories'**
  String get subcategories;

  /// No description provided for @autoMobile.
  ///
  /// In en, this message translates to:
  /// **'Automobile'**
  String get autoMobile;

  /// No description provided for @acRepair.
  ///
  /// In en, this message translates to:
  /// **'AC Repair'**
  String get acRepair;

  /// No description provided for @repair.
  ///
  /// In en, this message translates to:
  /// **'Repair'**
  String get repair;

  /// No description provided for @foodService.
  ///
  /// In en, this message translates to:
  /// **'Food Service'**
  String get foodService;

  /// No description provided for @bookService.
  ///
  /// In en, this message translates to:
  /// **'Book Service'**
  String get bookService;

  /// No description provided for @carService.
  ///
  /// In en, this message translates to:
  /// **'Car Service'**
  String get carService;

  /// No description provided for @designAndDevelopment.
  ///
  /// In en, this message translates to:
  /// **'Design and Development'**
  String get designAndDevelopment;

  /// No description provided for @cleaning.
  ///
  /// In en, this message translates to:
  /// **'Cleaning'**
  String get cleaning;

  /// No description provided for @carCleaning.
  ///
  /// In en, this message translates to:
  /// **'Car Cleaning'**
  String get carCleaning;

  /// No description provided for @houseCleaning.
  ///
  /// In en, this message translates to:
  /// **'House Cleaning'**
  String get houseCleaning;

  /// No description provided for @homeMove.
  ///
  /// In en, this message translates to:
  /// **'Home Move'**
  String get homeMove;

  /// No description provided for @houseRepair.
  ///
  /// In en, this message translates to:
  /// **'House Repair'**
  String get houseRepair;

  /// No description provided for @painting.
  ///
  /// In en, this message translates to:
  /// **'Painting'**
  String get painting;

  /// No description provided for @threeDPainting.
  ///
  /// In en, this message translates to:
  /// **'3D Painting'**
  String get threeDPainting;

  /// No description provided for @digitalPainting.
  ///
  /// In en, this message translates to:
  /// **'Digital Painting'**
  String get digitalPainting;

  /// No description provided for @coolPainting.
  ///
  /// In en, this message translates to:
  /// **'Cool Painting'**
  String get coolPainting;

  /// No description provided for @salonAndSpa.
  ///
  /// In en, this message translates to:
  /// **'Salon and Spa'**
  String get salonAndSpa;

  /// No description provided for @bodyMessage.
  ///
  /// In en, this message translates to:
  /// **'Body Message'**
  String get bodyMessage;

  /// No description provided for @hairCutting.
  ///
  /// In en, this message translates to:
  /// **'Hair Cutting'**
  String get hairCutting;

  /// No description provided for @beautyCare.
  ///
  /// In en, this message translates to:
  /// **'Beauty Care'**
  String get beautyCare;

  /// No description provided for @helping.
  ///
  /// In en, this message translates to:
  /// **'Helping'**
  String get helping;

  /// No description provided for @digitalMarketing.
  ///
  /// In en, this message translates to:
  /// **'Digital Marketing'**
  String get digitalMarketing;

  /// No description provided for @profileBuild.
  ///
  /// In en, this message translates to:
  /// **'Profile Build'**
  String get profileBuild;

  /// No description provided for @computersAndIT.
  ///
  /// In en, this message translates to:
  /// **'Computers and IT'**
  String get computersAndIT;

  /// No description provided for @itSupport.
  ///
  /// In en, this message translates to:
  /// **'IT Support'**
  String get itSupport;

  /// No description provided for @softwareHelp.
  ///
  /// In en, this message translates to:
  /// **'Software Help'**
  String get softwareHelp;

  /// No description provided for @business.
  ///
  /// In en, this message translates to:
  /// **'Business'**
  String get business;

  /// No description provided for @businessAdvisory.
  ///
  /// In en, this message translates to:
  /// **'Business Advisory'**
  String get businessAdvisory;

  /// No description provided for @earthmovers.
  ///
  /// In en, this message translates to:
  /// **'Earthmovers'**
  String get earthmovers;

  /// No description provided for @userId.
  ///
  /// In en, this message translates to:
  /// **'User  ID'**
  String get userId;

  /// No description provided for @sellerId.
  ///
  /// In en, this message translates to:
  /// **'Seller ID'**
  String get sellerId;

  /// No description provided for @serviceId.
  ///
  /// In en, this message translates to:
  /// **'Service ID'**
  String get serviceId;

  /// No description provided for @serviceName.
  ///
  /// In en, this message translates to:
  /// **'Service Name'**
  String get serviceName;

  /// No description provided for @hairCuttingServiceAtReasonablePrice.
  ///
  /// In en, this message translates to:
  /// **'Hair cutting service at reasonable price'**
  String get hairCuttingServiceAtReasonablePrice;

  /// No description provided for @userContact.
  ///
  /// In en, this message translates to:
  /// **'User  Contact'**
  String get userContact;

  /// No description provided for @status.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get status;

  /// No description provided for @newLeads.
  ///
  /// In en, this message translates to:
  /// **'New Leads'**
  String get newLeads;

  /// No description provided for @createdAt.
  ///
  /// In en, this message translates to:
  /// **'Created At'**
  String get createdAt;

  /// No description provided for @updatedAt.
  ///
  /// In en, this message translates to:
  /// **'Updated At'**
  String get updatedAt;

  /// No description provided for @buyer.
  ///
  /// In en, this message translates to:
  /// **'Buyer'**
  String get buyer;

  /// No description provided for @seller.
  ///
  /// In en, this message translates to:
  /// **'Seller'**
  String get seller;

  /// No description provided for @vendorText.
  ///
  /// In en, this message translates to:
  /// **'Contractor/Vendor'**
  String get vendorText;

  /// No description provided for @johnDoe.
  ///
  /// In en, this message translates to:
  /// **'John Doe'**
  String get johnDoe;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @username.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get username;

  /// No description provided for @user4920.
  ///
  /// In en, this message translates to:
  /// **'User  4920'**
  String get user4920;

  /// No description provided for @phone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phone;

  /// No description provided for @businessName.
  ///
  /// In en, this message translates to:
  /// **'Business Name'**
  String get businessName;

  /// No description provided for @charlieServices.
  ///
  /// In en, this message translates to:
  /// **'Charlie Services'**
  String get charlieServices;

  /// No description provided for @businessGstNumber.
  ///
  /// In en, this message translates to:
  /// **'Business GST Number'**
  String get businessGstNumber;

  /// No description provided for @gst12345678.
  ///
  /// In en, this message translates to:
  /// **'GST12345678'**
  String get gst12345678;

  /// No description provided for @businessPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Business Phone Number'**
  String get businessPhoneNumber;

  /// No description provided for @businessEmail.
  ///
  /// In en, this message translates to:
  /// **'Business Email'**
  String get businessEmail;

  /// No description provided for @businessFullAddress.
  ///
  /// In en, this message translates to:
  /// **'Business Full Address'**
  String get businessFullAddress;

  /// No description provided for @businessDescription.
  ///
  /// In en, this message translates to:
  /// **'Business Description'**
  String get businessDescription;

  /// No description provided for @weOfferTopQualityServices.
  ///
  /// In en, this message translates to:
  /// **'We offer top-quality services'**
  String get weOfferTopQualityServices;

  /// No description provided for @workingCategories.
  ///
  /// In en, this message translates to:
  /// **'Working Categories'**
  String get workingCategories;

  /// No description provided for @otpCode.
  ///
  /// In en, this message translates to:
  /// **'OTP Code'**
  String get otpCode;

  /// No description provided for @otpVerified.
  ///
  /// In en, this message translates to:
  /// **'OTP Verified'**
  String get otpVerified;

  /// No description provided for @image.
  ///
  /// In en, this message translates to:
  /// **'Image'**
  String get image;

  /// No description provided for @profileBackground.
  ///
  /// In en, this message translates to:
  /// **'Profile Background'**
  String get profileBackground;

  /// No description provided for @serviceCity.
  ///
  /// In en, this message translates to:
  /// **'Service City'**
  String get serviceCity;

  /// No description provided for @userType.
  ///
  /// In en, this message translates to:
  /// **'User  Type'**
  String get userType;

  /// No description provided for @sellerType.
  ///
  /// In en, this message translates to:
  /// **'Seller Type'**
  String get sellerType;

  /// No description provided for @isNew.
  ///
  /// In en, this message translates to:
  /// **'Is New'**
  String get isNew;

  /// No description provided for @userStatus.
  ///
  /// In en, this message translates to:
  /// **'User  Status'**
  String get userStatus;

  /// No description provided for @termsCondition.
  ///
  /// In en, this message translates to:
  /// **'Terms and Conditions'**
  String get termsCondition;

  /// No description provided for @address.
  ///
  /// In en, this message translates to:
  /// **'Address:'**
  String get address;

  /// No description provided for @state.
  ///
  /// In en, this message translates to:
  /// **'State'**
  String get state;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// No description provided for @taxNumber.
  ///
  /// In en, this message translates to:
  /// **'Tax Number'**
  String get taxNumber;

  /// No description provided for @sdamaklsda.
  ///
  /// In en, this message translates to:
  /// **'sdamaklsda'**
  String get sdamaklsda;

  /// No description provided for @businessRegistration.
  ///
  /// In en, this message translates to:
  /// **'Business Registration'**
  String get businessRegistration;

  /// No description provided for @postCode.
  ///
  /// In en, this message translates to:
  /// **'Post Code'**
  String get postCode;

  /// No description provided for @countryId.
  ///
  /// In en, this message translates to:
  /// **'Country ID'**
  String get countryId;

  /// No description provided for @emailVerified.
  ///
  /// In en, this message translates to:
  /// **'Email Verified'**
  String get emailVerified;

  /// No description provided for @emailVerifyToken.
  ///
  /// In en, this message translates to:
  /// **'Email Verify Token'**
  String get emailVerifyToken;

  /// No description provided for @facebookId.
  ///
  /// In en, this message translates to:
  /// **'Facebook ID'**
  String get facebookId;

  /// No description provided for @appleId.
  ///
  /// In en, this message translates to:
  /// **'Apple ID'**
  String get appleId;

  /// No description provided for @googleId.
  ///
  /// In en, this message translates to:
  /// **'Google ID'**
  String get googleId;

  /// No description provided for @countryCode.
  ///
  /// In en, this message translates to:
  /// **'Country Code'**
  String get countryCode;

  /// No description provided for @inLocation.
  ///
  /// In en, this message translates to:
  /// **'India'**
  String get inLocation;

  /// No description provided for @lastSeen.
  ///
  /// In en, this message translates to:
  /// **'Last Seen'**
  String get lastSeen;

  /// No description provided for @otpExpireAt.
  ///
  /// In en, this message translates to:
  /// **'OTP Expire At'**
  String get otpExpireAt;

  /// No description provided for @zoneId.
  ///
  /// In en, this message translates to:
  /// **'Zone ID'**
  String get zoneId;

  /// No description provided for @latitude.
  ///
  /// In en, this message translates to:
  /// **'Latitude'**
  String get latitude;

  /// No description provided for @longitude.
  ///
  /// In en, this message translates to:
  /// **'Longitude'**
  String get longitude;

  /// No description provided for @sellerAddress.
  ///
  /// In en, this message translates to:
  /// **'Seller Address'**
  String get sellerAddress;

  /// No description provided for @carCleaningServiceFromBestCleaner.
  ///
  /// In en, this message translates to:
  /// **'Car cleaning service from best cleaner'**
  String get carCleaningServiceFromBestCleaner;

  /// No description provided for @homeMoveServiceFromOneCityToAnotherCity.
  ///
  /// In en, this message translates to:
  /// **'Home move service from one city to another city'**
  String get homeMoveServiceFromOneCityToAnotherCity;

  /// No description provided for @openLeads.
  ///
  /// In en, this message translates to:
  /// **'Open Leads'**
  String get openLeads;

  /// No description provided for @premiumWebDesignService.
  ///
  /// In en, this message translates to:
  /// **'Premium Web Design Service'**
  String get premiumWebDesignService;

  /// No description provided for @din.
  ///
  /// In en, this message translates to:
  /// **'Day'**
  String get din;

  /// No description provided for @categoryId.
  ///
  /// In en, this message translates to:
  /// **'Category ID'**
  String get categoryId;

  /// No description provided for @subcategoryId.
  ///
  /// In en, this message translates to:
  /// **'Subcategory ID'**
  String get subcategoryId;

  /// No description provided for @childCategoryId.
  ///
  /// In en, this message translates to:
  /// **'Child Category ID'**
  String get childCategoryId;

  /// No description provided for @dsadas.
  ///
  /// In en, this message translates to:
  /// **'dsadas'**
  String get dsadas;

  /// No description provided for @slug.
  ///
  /// In en, this message translates to:
  /// **'Slug'**
  String get slug;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @imageId.
  ///
  /// In en, this message translates to:
  /// **'Image ID'**
  String get imageId;

  /// No description provided for @imgUrl.
  ///
  /// In en, this message translates to:
  /// **'Image URL'**
  String get imgUrl;

  /// No description provided for @imgAlt.
  ///
  /// In en, this message translates to:
  /// **'Image Alt Text'**
  String get imgAlt;

  /// No description provided for @serviceCityId.
  ///
  /// In en, this message translates to:
  /// **'Service City ID'**
  String get serviceCityId;

  /// No description provided for @serviceAreaId.
  ///
  /// In en, this message translates to:
  /// **'Service Area ID'**
  String get serviceAreaId;

  /// No description provided for @isServiceAllCities.
  ///
  /// In en, this message translates to:
  /// **'Is Service All Cities'**
  String get isServiceAllCities;

  /// No description provided for @experience.
  ///
  /// In en, this message translates to:
  /// **'Experience:'**
  String get experience;

  /// No description provided for @price.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get price;

  /// No description provided for @reviewsCount.
  ///
  /// In en, this message translates to:
  /// **'Reviews Count'**
  String get reviewsCount;

  /// No description provided for @pendingOrderCount.
  ///
  /// In en, this message translates to:
  /// **'Pending Order Count'**
  String get pendingOrderCount;

  /// No description provided for @completeOrderCount.
  ///
  /// In en, this message translates to:
  /// **'Complete Order Count'**
  String get completeOrderCount;

  /// No description provided for @cancelOrderCount.
  ///
  /// In en, this message translates to:
  /// **'Cancel Order Count'**
  String get cancelOrderCount;

  /// No description provided for @dsadasdad.
  ///
  /// In en, this message translates to:
  /// **'dsadasdad'**
  String get dsadasdad;

  /// No description provided for @afterZero.
  ///
  /// In en, this message translates to:
  /// **'After Zero'**
  String get afterZero;

  /// No description provided for @dsad.
  ///
  /// In en, this message translates to:
  /// **'dsad'**
  String get dsad;

  /// No description provided for @sdadasdad.
  ///
  /// In en, this message translates to:
  /// **'sdadasdad'**
  String get sdadasdad;

  /// No description provided for @beforeSubscription.
  ///
  /// In en, this message translates to:
  /// **'Before Subscription'**
  String get beforeSubscription;

  /// No description provided for @test2.
  ///
  /// In en, this message translates to:
  /// **'Test 2'**
  String get test2;

  /// No description provided for @test2_1.
  ///
  /// In en, this message translates to:
  /// **'Test 2-1'**
  String get test2_1;

  /// No description provided for @ttele.
  ///
  /// In en, this message translates to:
  /// **'ttele'**
  String get ttele;

  /// No description provided for @transformativeInteriorDesignServices.
  ///
  /// In en, this message translates to:
  /// **'Transformative Interior Design Services'**
  String get transformativeInteriorDesignServices;

  /// No description provided for @weDesignWebPages.
  ///
  /// In en, this message translates to:
  /// **'We design web pages'**
  String get weDesignWebPages;

  /// No description provided for @weOfferTopNotchWebDesignServicesThatWillMakeYourWebsiteStandOut.
  ///
  /// In en, this message translates to:
  /// **'We offer top-notch web design services that will make your website stand out.'**
  String get weOfferTopNotchWebDesignServicesThatWillMakeYourWebsiteStandOut;

  /// No description provided for @housePlanDesign.
  ///
  /// In en, this message translates to:
  /// **'House Plan Design'**
  String get housePlanDesign;

  /// No description provided for @constructionAndDevelopmentSolutionsCivilWork.
  ///
  /// In en, this message translates to:
  /// **'Construction and Development Solutions - Civil Work'**
  String get constructionAndDevelopmentSolutionsCivilWork;

  /// No description provided for @newUser.
  ///
  /// In en, this message translates to:
  /// **'New User'**
  String get newUser;

  /// No description provided for @serviceAreas.
  ///
  /// In en, this message translates to:
  /// **'Service Areas'**
  String get serviceAreas;

  /// No description provided for @category.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get category;

  /// No description provided for @icon.
  ///
  /// In en, this message translates to:
  /// **'Icon'**
  String get icon;

  /// No description provided for @mobileIcon.
  ///
  /// In en, this message translates to:
  /// **'Mobile Icon'**
  String get mobileIcon;

  /// No description provided for @chatSellerLists.
  ///
  /// In en, this message translates to:
  /// **'Chat Seller Lists'**
  String get chatSellerLists;

  /// No description provided for @dateTimeStr.
  ///
  /// In en, this message translates to:
  /// **'Date Time String'**
  String get dateTimeStr;

  /// No description provided for @dateHumanReadable.
  ///
  /// In en, this message translates to:
  /// **'Human Readable Date'**
  String get dateHumanReadable;

  /// No description provided for @sellerImage.
  ///
  /// In en, this message translates to:
  /// **'Seller Image'**
  String get sellerImage;

  /// No description provided for @imageUrl.
  ///
  /// In en, this message translates to:
  /// **'Image URL'**
  String get imageUrl;

  /// No description provided for @senderProfileImage.
  ///
  /// In en, this message translates to:
  /// **'Sender Profile Image'**
  String get senderProfileImage;

  /// No description provided for @sellerList.
  ///
  /// In en, this message translates to:
  /// **'Seller List'**
  String get sellerList;

  /// No description provided for @messages.
  ///
  /// In en, this message translates to:
  /// **'Messages'**
  String get messages;

  /// No description provided for @currentPage.
  ///
  /// In en, this message translates to:
  /// **'Current Page'**
  String get currentPage;

  /// No description provided for @lastPage.
  ///
  /// In en, this message translates to:
  /// **'Last Page'**
  String get lastPage;

  /// No description provided for @total.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get total;

  /// No description provided for @firstPageUrl.
  ///
  /// In en, this message translates to:
  /// **'First Page URL'**
  String get firstPageUrl;

  /// No description provided for @from.
  ///
  /// In en, this message translates to:
  /// **'From'**
  String get from;

  /// No description provided for @lastPageUrl.
  ///
  /// In en, this message translates to:
  /// **'Last Page URL'**
  String get lastPageUrl;

  /// No description provided for @links.
  ///
  /// In en, this message translates to:
  /// **'Links'**
  String get links;

  /// No description provided for @nextPageUrl.
  ///
  /// In en, this message translates to:
  /// **'Next Page URL'**
  String get nextPageUrl;

  /// No description provided for @perPage.
  ///
  /// In en, this message translates to:
  /// **'Per Page'**
  String get perPage;

  /// No description provided for @prevPageUrl.
  ///
  /// In en, this message translates to:
  /// **'Previous Page URL'**
  String get prevPageUrl;

  /// No description provided for @to.
  ///
  /// In en, this message translates to:
  /// **'To'**
  String get to;

  /// No description provided for @fromUser.
  ///
  /// In en, this message translates to:
  /// **'From User'**
  String get fromUser;

  /// No description provided for @toUser.
  ///
  /// In en, this message translates to:
  /// **'To User'**
  String get toUser;

  /// No description provided for @buyerId.
  ///
  /// In en, this message translates to:
  /// **'Buyer ID'**
  String get buyerId;

  /// No description provided for @url.
  ///
  /// In en, this message translates to:
  /// **'URL'**
  String get url;

  /// No description provided for @label.
  ///
  /// In en, this message translates to:
  /// **'Label'**
  String get label;

  /// No description provided for @active.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get active;

  /// No description provided for @childCategory.
  ///
  /// In en, this message translates to:
  /// **'Child Category'**
  String get childCategory;

  /// No description provided for @subCategoryId.
  ///
  /// In en, this message translates to:
  /// **'Subcategory ID'**
  String get subCategoryId;

  /// No description provided for @countries.
  ///
  /// In en, this message translates to:
  /// **'Countries'**
  String get countries;

  /// No description provided for @country.
  ///
  /// In en, this message translates to:
  /// **'Country'**
  String get country;

  /// No description provided for @serviceCities.
  ///
  /// In en, this message translates to:
  /// **'Service Cities'**
  String get serviceCities;

  /// No description provided for @htmlAttributions.
  ///
  /// In en, this message translates to:
  /// **'HTML Attributions'**
  String get htmlAttributions;

  /// No description provided for @result.
  ///
  /// In en, this message translates to:
  /// **'Result'**
  String get result;

  /// No description provided for @addressComponents.
  ///
  /// In en, this message translates to:
  /// **'Address Components'**
  String get addressComponents;

  /// No description provided for @adrAddress.
  ///
  /// In en, this message translates to:
  /// **'ADR Address'**
  String get adrAddress;

  /// No description provided for @businessStatus.
  ///
  /// In en, this message translates to:
  /// **'Business Status'**
  String get businessStatus;

  /// No description provided for @currentOpeningHours.
  ///
  /// In en, this message translates to:
  /// **'Current Opening Hours'**
  String get currentOpeningHours;

  /// No description provided for @delivery.
  ///
  /// In en, this message translates to:
  /// **'Delivery'**
  String get delivery;

  /// No description provided for @formattedAddress.
  ///
  /// In en, this message translates to:
  /// **'Formatted Address'**
  String get formattedAddress;

  /// No description provided for @geometry.
  ///
  /// In en, this message translates to:
  /// **'Geometry'**
  String get geometry;

  /// No description provided for @iconBackgroundColor.
  ///
  /// In en, this message translates to:
  /// **'Icon Background Color'**
  String get iconBackgroundColor;

  /// No description provided for @iconMaskBaseUri.
  ///
  /// In en, this message translates to:
  /// **'Icon Mask Base URI'**
  String get iconMaskBaseUri;

  /// No description provided for @openingHours.
  ///
  /// In en, this message translates to:
  /// **'Opening Hours'**
  String get openingHours;

  /// No description provided for @photos.
  ///
  /// In en, this message translates to:
  /// **'Photos'**
  String get photos;

  /// No description provided for @placeId.
  ///
  /// In en, this message translates to:
  /// **'Place ID'**
  String get placeId;

  /// No description provided for @plusCode.
  ///
  /// In en, this message translates to:
  /// **'Plus Code'**
  String get plusCode;

  /// No description provided for @rating.
  ///
  /// In en, this message translates to:
  /// **'Rating'**
  String get rating;

  /// No description provided for @reference.
  ///
  /// In en, this message translates to:
  /// **'Reference'**
  String get reference;

  /// No description provided for @reviews.
  ///
  /// In en, this message translates to:
  /// **'Reviews'**
  String get reviews;

  /// No description provided for @types.
  ///
  /// In en, this message translates to:
  /// **'Types'**
  String get types;

  /// No description provided for @userRatingsTotal.
  ///
  /// In en, this message translates to:
  /// **'User  Ratings Total'**
  String get userRatingsTotal;

  /// No description provided for @utcOffset.
  ///
  /// In en, this message translates to:
  /// **'UTC Offset'**
  String get utcOffset;

  /// No description provided for @vicinity.
  ///
  /// In en, this message translates to:
  /// **'Vicinity'**
  String get vicinity;

  /// No description provided for @wheelchairAccessibleEntrance.
  ///
  /// In en, this message translates to:
  /// **'Wheelchair Accessible Entrance'**
  String get wheelchairAccessibleEntrance;

  /// No description provided for @longName.
  ///
  /// In en, this message translates to:
  /// **'Long Name'**
  String get longName;

  /// No description provided for @shortName.
  ///
  /// In en, this message translates to:
  /// **'Short Name'**
  String get shortName;

  /// No description provided for @openNow.
  ///
  /// In en, this message translates to:
  /// **'Open Now'**
  String get openNow;

  /// No description provided for @periods.
  ///
  /// In en, this message translates to:
  /// **'Periods'**
  String get periods;

  /// No description provided for @weekdayText.
  ///
  /// In en, this message translates to:
  /// **'Weekday Text'**
  String get weekdayText;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @open.
  ///
  /// In en, this message translates to:
  /// **'Open'**
  String get open;

  /// No description provided for @date.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get date;

  /// No description provided for @day.
  ///
  /// In en, this message translates to:
  /// **'Day:'**
  String get day;

  /// No description provided for @time.
  ///
  /// In en, this message translates to:
  /// **'Time:'**
  String get time;

  /// No description provided for @truncated.
  ///
  /// In en, this message translates to:
  /// **'Truncated'**
  String get truncated;

  /// No description provided for @location.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get location;

  /// No description provided for @viewport.
  ///
  /// In en, this message translates to:
  /// **'Viewport'**
  String get viewport;

  /// No description provided for @lat.
  ///
  /// In en, this message translates to:
  /// **'Latitude'**
  String get lat;

  /// No description provided for @lng.
  ///
  /// In en, this message translates to:
  /// **'Longitude'**
  String get lng;

  /// No description provided for @northeast.
  ///
  /// In en, this message translates to:
  /// **'Northeast'**
  String get northeast;

  /// No description provided for @southwest.
  ///
  /// In en, this message translates to:
  /// **'Southwest'**
  String get southwest;

  /// No description provided for @height.
  ///
  /// In en, this message translates to:
  /// **'Height'**
  String get height;

  /// No description provided for @photoReference.
  ///
  /// In en, this message translates to:
  /// **'Photo Reference'**
  String get photoReference;

  /// No description provided for @width.
  ///
  /// In en, this message translates to:
  /// **'Width'**
  String get width;

  /// No description provided for @compoundCode.
  ///
  /// In en, this message translates to:
  /// **'Compound Code'**
  String get compoundCode;

  /// No description provided for @globalCode.
  ///
  /// In en, this message translates to:
  /// **'Global Code'**
  String get globalCode;

  /// No description provided for @authorName.
  ///
  /// In en, this message translates to:
  /// **'Author Name'**
  String get authorName;

  /// No description provided for @authorUrl.
  ///
  /// In en, this message translates to:
  /// **'Author URL'**
  String get authorUrl;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @originalLanguage.
  ///
  /// In en, this message translates to:
  /// **'Original Language'**
  String get originalLanguage;

  /// No description provided for @profilePhotoUrl.
  ///
  /// In en, this message translates to:
  /// **'Profile Photo URL'**
  String get profilePhotoUrl;

  /// No description provided for @relativeTimeDescription.
  ///
  /// In en, this message translates to:
  /// **'Relative Time Description'**
  String get relativeTimeDescription;

  /// No description provided for @text.
  ///
  /// In en, this message translates to:
  /// **'Text'**
  String get text;

  /// No description provided for @translated.
  ///
  /// In en, this message translates to:
  /// **'Translated'**
  String get translated;

  /// No description provided for @predictions.
  ///
  /// In en, this message translates to:
  /// **'Predictions'**
  String get predictions;

  /// No description provided for @matchedSubstrings.
  ///
  /// In en, this message translates to:
  /// **'Matched Substrings'**
  String get matchedSubstrings;

  /// No description provided for @structuredFormatting.
  ///
  /// In en, this message translates to:
  /// **'Structured Formatting'**
  String get structuredFormatting;

  /// No description provided for @terms.
  ///
  /// In en, this message translates to:
  /// **'Terms'**
  String get terms;

  /// No description provided for @postalCode.
  ///
  /// In en, this message translates to:
  /// **'Postal Code'**
  String get postalCode;

  /// No description provided for @city.
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get city;

  /// No description provided for @length.
  ///
  /// In en, this message translates to:
  /// **'Length'**
  String get length;

  /// No description provided for @offset.
  ///
  /// In en, this message translates to:
  /// **'Offset'**
  String get offset;

  /// No description provided for @mainText.
  ///
  /// In en, this message translates to:
  /// **'Main Text'**
  String get mainText;

  /// No description provided for @mainTextMatchedSubstrings.
  ///
  /// In en, this message translates to:
  /// **'Main Text Matched Substrings'**
  String get mainTextMatchedSubstrings;

  /// No description provided for @secondaryText.
  ///
  /// In en, this message translates to:
  /// **'Secondary Text'**
  String get secondaryText;

  /// No description provided for @value.
  ///
  /// In en, this message translates to:
  /// **'Value'**
  String get value;

  /// No description provided for @allJobRequest.
  ///
  /// In en, this message translates to:
  /// **'All Job Requests'**
  String get allJobRequest;

  /// No description provided for @jobImage.
  ///
  /// In en, this message translates to:
  /// **'Job Image'**
  String get jobImage;

  /// No description provided for @jobPostId.
  ///
  /// In en, this message translates to:
  /// **'Job Post ID'**
  String get jobPostId;

  /// No description provided for @isHired.
  ///
  /// In en, this message translates to:
  /// **'Is Hired'**
  String get isHired;

  /// No description provided for @expectedSalary.
  ///
  /// In en, this message translates to:
  /// **'Expected Salary'**
  String get expectedSalary;

  /// No description provided for @coverLetter.
  ///
  /// In en, this message translates to:
  /// **'Cover Letter'**
  String get coverLetter;

  /// No description provided for @job.
  ///
  /// In en, this message translates to:
  /// **'Job'**
  String get job;

  /// No description provided for @cityId.
  ///
  /// In en, this message translates to:
  /// **'City ID'**
  String get cityId;

  /// No description provided for @isJobOn.
  ///
  /// In en, this message translates to:
  /// **'Is Job On'**
  String get isJobOn;

  /// No description provided for @isJobOnline.
  ///
  /// In en, this message translates to:
  /// **'Is Job Online'**
  String get isJobOnline;

  /// No description provided for @view.
  ///
  /// In en, this message translates to:
  /// **'View'**
  String get view;

  /// No description provided for @deadLine.
  ///
  /// In en, this message translates to:
  /// **'Deadline'**
  String get deadLine;

  /// No description provided for @requestDetails.
  ///
  /// In en, this message translates to:
  /// **'Request Details'**
  String get requestDetails;

  /// No description provided for @allMessages.
  ///
  /// In en, this message translates to:
  /// **'All Messages'**
  String get allMessages;

  /// No description provided for @q.
  ///
  /// In en, this message translates to:
  /// **'Question'**
  String get q;

  /// No description provided for @notify.
  ///
  /// In en, this message translates to:
  /// **'Notify'**
  String get notify;

  /// No description provided for @attachment.
  ///
  /// In en, this message translates to:
  /// **'Attachment'**
  String get attachment;

  /// No description provided for @jobRequestId.
  ///
  /// In en, this message translates to:
  /// **'Job Request ID'**
  String get jobRequestId;

  /// No description provided for @jobDetails.
  ///
  /// In en, this message translates to:
  /// **'Job Details'**
  String get jobDetails;

  /// No description provided for @sameBuyerJobs.
  ///
  /// In en, this message translates to:
  /// **'Same Buyer Jobs'**
  String get sameBuyerJobs;

  /// No description provided for @similarJobs.
  ///
  /// In en, this message translates to:
  /// **'Similar Jobs'**
  String get similarJobs;

  /// No description provided for @isJobHired.
  ///
  /// In en, this message translates to:
  /// **'Is Job Hired'**
  String get isJobHired;

  /// No description provided for @jobRequest.
  ///
  /// In en, this message translates to:
  /// **'Job Request'**
  String get jobRequest;

  /// No description provided for @jobLists.
  ///
  /// In en, this message translates to:
  /// **'Job Lists'**
  String get jobLists;

  /// No description provided for @recent10Jobs.
  ///
  /// In en, this message translates to:
  /// **'Recent 10 Jobs'**
  String get recent10Jobs;

  /// No description provided for @jobsImage.
  ///
  /// In en, this message translates to:
  /// **'Jobs Image'**
  String get jobsImage;

  /// No description provided for @myOrders.
  ///
  /// In en, this message translates to:
  /// **'My Orders'**
  String get myOrders;

  /// No description provided for @area.
  ///
  /// In en, this message translates to:
  /// **'Area'**
  String get area;

  /// No description provided for @schedule.
  ///
  /// In en, this message translates to:
  /// **'Schedule'**
  String get schedule;

  /// No description provided for @packageFee.
  ///
  /// In en, this message translates to:
  /// **'Package Fee'**
  String get packageFee;

  /// No description provided for @extraService.
  ///
  /// In en, this message translates to:
  /// **'Extra Service'**
  String get extraService;

  /// No description provided for @subTotal.
  ///
  /// In en, this message translates to:
  /// **'Sub Total'**
  String get subTotal;

  /// No description provided for @tax.
  ///
  /// In en, this message translates to:
  /// **'Tax'**
  String get tax;

  /// No description provided for @couponCode.
  ///
  /// In en, this message translates to:
  /// **'Coupon Code'**
  String get couponCode;

  /// No description provided for @couponType.
  ///
  /// In en, this message translates to:
  /// **'Coupon Type'**
  String get couponType;

  /// No description provided for @couponAmount.
  ///
  /// In en, this message translates to:
  /// **'Coupon Amount'**
  String get couponAmount;

  /// No description provided for @commissionType.
  ///
  /// In en, this message translates to:
  /// **'Commission Type'**
  String get commissionType;

  /// No description provided for @commissionCharge.
  ///
  /// In en, this message translates to:
  /// **'Commission Charge'**
  String get commissionCharge;

  /// No description provided for @commissionAmount.
  ///
  /// In en, this message translates to:
  /// **'Commission Amount'**
  String get commissionAmount;

  /// No description provided for @paymentGateway.
  ///
  /// In en, this message translates to:
  /// **'Payment Gateway'**
  String get paymentGateway;

  /// No description provided for @paymentStatus.
  ///
  /// In en, this message translates to:
  /// **'Payment Status'**
  String get paymentStatus;

  /// No description provided for @isOrderOnline.
  ///
  /// In en, this message translates to:
  /// **'Is Order Online'**
  String get isOrderOnline;

  /// No description provided for @orderCompleteRequest.
  ///
  /// In en, this message translates to:
  /// **'Order Complete Request'**
  String get orderCompleteRequest;

  /// No description provided for @cancelOrderMoneyReturn.
  ///
  /// In en, this message translates to:
  /// **'Cancel Order Money Return'**
  String get cancelOrderMoneyReturn;

  /// No description provided for @transactionId.
  ///
  /// In en, this message translates to:
  /// **'Transaction ID'**
  String get transactionId;

  /// No description provided for @orderNote.
  ///
  /// In en, this message translates to:
  /// **'Order Note'**
  String get orderNote;

  /// No description provided for @subcategory.
  ///
  /// In en, this message translates to:
  /// **'Subcategory'**
  String get subcategory;

  /// No description provided for @orderInfo.
  ///
  /// In en, this message translates to:
  /// **'Order Info'**
  String get orderInfo;

  /// No description provided for @sellerDetails.
  ///
  /// In en, this message translates to:
  /// **'Seller Details'**
  String get sellerDetails;

  /// No description provided for @extraServiceList.
  ///
  /// In en, this message translates to:
  /// **'Extra Service List'**
  String get extraServiceList;

  /// No description provided for @orderId.
  ///
  /// In en, this message translates to:
  /// **'Order ID'**
  String get orderId;

  /// No description provided for @quantity.
  ///
  /// In en, this message translates to:
  /// **'Quantity'**
  String get quantity;

  /// No description provided for @userDetails.
  ///
  /// In en, this message translates to:
  /// **'User  Details'**
  String get userDetails;

  /// No description provided for @pendingOrder.
  ///
  /// In en, this message translates to:
  /// **'Pending Order'**
  String get pendingOrder;

  /// No description provided for @activeOrder.
  ///
  /// In en, this message translates to:
  /// **'Active Order'**
  String get activeOrder;

  /// No description provided for @completeOrder.
  ///
  /// In en, this message translates to:
  /// **'Complete Order'**
  String get completeOrder;

  /// No description provided for @totalOrder.
  ///
  /// In en, this message translates to:
  /// **'Total Order'**
  String get totalOrder;

  /// No description provided for @latestServices.
  ///
  /// In en, this message translates to:
  /// **'Latest Services'**
  String get latestServices;

  /// No description provided for @serviceImage.
  ///
  /// In en, this message translates to:
  /// **'Service Image'**
  String get serviceImage;

  /// No description provided for @reviewerImage.
  ///
  /// In en, this message translates to:
  /// **'Reviewer Image'**
  String get reviewerImage;

  /// No description provided for @sellerForMobile.
  ///
  /// In en, this message translates to:
  /// **'Seller for Mobile'**
  String get sellerForMobile;

  /// No description provided for @buyerForMobile.
  ///
  /// In en, this message translates to:
  /// **'Buyer for Mobile'**
  String get buyerForMobile;

  /// No description provided for @reportFrom.
  ///
  /// In en, this message translates to:
  /// **'Report From'**
  String get reportFrom;

  /// No description provided for @reportTo.
  ///
  /// In en, this message translates to:
  /// **'Report To'**
  String get reportTo;

  /// No description provided for @report.
  ///
  /// In en, this message translates to:
  /// **'Report'**
  String get report;

  /// No description provided for @ticketId.
  ///
  /// In en, this message translates to:
  /// **'Ticket ID'**
  String get ticketId;

  /// No description provided for @reportId.
  ///
  /// In en, this message translates to:
  /// **'Report ID'**
  String get reportId;

  /// No description provided for @adminId.
  ///
  /// In en, this message translates to:
  /// **'Admin ID'**
  String get adminId;

  /// No description provided for @services.
  ///
  /// In en, this message translates to:
  /// **'Services'**
  String get services;

  /// No description provided for @imageGallery.
  ///
  /// In en, this message translates to:
  /// **'Image Gallery'**
  String get imageGallery;

  /// No description provided for @video.
  ///
  /// In en, this message translates to:
  /// **'Video'**
  String get video;

  /// No description provided for @isServiceOn.
  ///
  /// In en, this message translates to:
  /// **'Is Service On'**
  String get isServiceOn;

  /// No description provided for @onlineServicePrice.
  ///
  /// In en, this message translates to:
  /// **'Online Service Price'**
  String get onlineServicePrice;

  /// No description provided for @deliveryDays.
  ///
  /// In en, this message translates to:
  /// **'Delivery Days'**
  String get deliveryDays;

  /// No description provided for @revision.
  ///
  /// In en, this message translates to:
  /// **'Revision'**
  String get revision;

  /// No description provided for @isServiceOnline.
  ///
  /// In en, this message translates to:
  /// **'Is Service Online'**
  String get isServiceOnline;

  /// No description provided for @soldCount.
  ///
  /// In en, this message translates to:
  /// **'Sold Count'**
  String get soldCount;

  /// No description provided for @featured.
  ///
  /// In en, this message translates to:
  /// **'Featured'**
  String get featured;

  /// No description provided for @allServices.
  ///
  /// In en, this message translates to:
  /// **'All Services'**
  String get allServices;

  /// No description provided for @sellerName.
  ///
  /// In en, this message translates to:
  /// **'Seller Name'**
  String get sellerName;

  /// No description provided for @serviceDetails.
  ///
  /// In en, this message translates to:
  /// **'Service Details'**
  String get serviceDetails;

  /// No description provided for @serviceSellerName.
  ///
  /// In en, this message translates to:
  /// **'Service Seller Name'**
  String get serviceSellerName;

  /// No description provided for @serviceSellerImage.
  ///
  /// In en, this message translates to:
  /// **'Service Seller Image'**
  String get serviceSellerImage;

  /// No description provided for @sellerCompleteOrder.
  ///
  /// In en, this message translates to:
  /// **'Seller Complete Order'**
  String get sellerCompleteOrder;

  /// No description provided for @sellerRating.
  ///
  /// In en, this message translates to:
  /// **'Seller Rating'**
  String get sellerRating;

  /// No description provided for @orderCompletionRate.
  ///
  /// In en, this message translates to:
  /// **'Order Completion Rate'**
  String get orderCompletionRate;

  /// No description provided for @sellerFrom.
  ///
  /// In en, this message translates to:
  /// **'Seller From'**
  String get sellerFrom;

  /// No description provided for @sellerSince.
  ///
  /// In en, this message translates to:
  /// **'Seller Since'**
  String get sellerSince;

  /// No description provided for @serviceIncludes.
  ///
  /// In en, this message translates to:
  /// **'Service Includes'**
  String get serviceIncludes;

  /// No description provided for @serviceBenefits.
  ///
  /// In en, this message translates to:
  /// **'Service Benefits'**
  String get serviceBenefits;

  /// No description provided for @serviceReviews.
  ///
  /// In en, this message translates to:
  /// **'Service Reviews'**
  String get serviceReviews;

  /// No description provided for @videoUrl.
  ///
  /// In en, this message translates to:
  /// **'Video URL'**
  String get videoUrl;

  /// No description provided for @benefits.
  ///
  /// In en, this message translates to:
  /// **'Benefits'**
  String get benefits;

  /// No description provided for @serviceFaq.
  ///
  /// In en, this message translates to:
  /// **'Service FAQ'**
  String get serviceFaq;

  /// No description provided for @buyerName.
  ///
  /// In en, this message translates to:
  /// **'Buyer Name'**
  String get buyerName;

  /// No description provided for @includeServiceTitle.
  ///
  /// In en, this message translates to:
  /// **'Include Service Title'**
  String get includeServiceTitle;

  /// No description provided for @service.
  ///
  /// In en, this message translates to:
  /// **'Service'**
  String get service;

  /// No description provided for @serviceAdditional.
  ///
  /// In en, this message translates to:
  /// **'Additional Service'**
  String get serviceAdditional;

  /// No description provided for @serviceInclude.
  ///
  /// In en, this message translates to:
  /// **'Service Include'**
  String get serviceInclude;

  /// No description provided for @serviceBenefit.
  ///
  /// In en, this message translates to:
  /// **'Service Benefit'**
  String get serviceBenefit;

  /// No description provided for @additionalServiceTitle.
  ///
  /// In en, this message translates to:
  /// **'Additional Service Title'**
  String get additionalServiceTitle;

  /// No description provided for @additionalServicePrice.
  ///
  /// In en, this message translates to:
  /// **'Additional Service Price'**
  String get additionalServicePrice;

  /// No description provided for @additionalServiceQuantity.
  ///
  /// In en, this message translates to:
  /// **'Additional Service Quantity'**
  String get additionalServiceQuantity;

  /// No description provided for @additionalServiceImage.
  ///
  /// In en, this message translates to:
  /// **'Additional Service Image'**
  String get additionalServiceImage;

  /// No description provided for @includeServicePrice.
  ///
  /// In en, this message translates to:
  /// **'Include Service Price'**
  String get includeServicePrice;

  /// No description provided for @includeServiceQuantity.
  ///
  /// In en, this message translates to:
  /// **'Include Service Quantity'**
  String get includeServiceQuantity;

  /// No description provided for @mainServices.
  ///
  /// In en, this message translates to:
  /// **'Main Services'**
  String get mainServices;

  /// No description provided for @maxPrice.
  ///
  /// In en, this message translates to:
  /// **'Max Price'**
  String get maxPrice;

  /// No description provided for @googleMapStatus.
  ///
  /// In en, this message translates to:
  /// **'Google Map Status'**
  String get googleMapStatus;

  /// No description provided for @guardName.
  ///
  /// In en, this message translates to:
  /// **'Guard Name'**
  String get guardName;

  /// No description provided for @schedules.
  ///
  /// In en, this message translates to:
  /// **'Schedules'**
  String get schedules;

  /// No description provided for @totalDay.
  ///
  /// In en, this message translates to:
  /// **'Total Day'**
  String get totalDay;

  /// No description provided for @sliderDetails.
  ///
  /// In en, this message translates to:
  /// **'Slider Details'**
  String get sliderDetails;

  /// No description provided for @backgroundImage.
  ///
  /// In en, this message translates to:
  /// **'Background Image'**
  String get backgroundImage;

  /// No description provided for @subTitle.
  ///
  /// In en, this message translates to:
  /// **'Sub Title'**
  String get subTitle;

  /// No description provided for @sliderType.
  ///
  /// In en, this message translates to:
  /// **'Slider Type'**
  String get sliderType;

  /// No description provided for @subCategories.
  ///
  /// In en, this message translates to:
  /// **'Subcategories'**
  String get subCategories;

  /// No description provided for @tickets.
  ///
  /// In en, this message translates to:
  /// **'Tickets'**
  String get tickets;

  /// No description provided for @subject.
  ///
  /// In en, this message translates to:
  /// **'Subject'**
  String get subject;

  /// No description provided for @priority.
  ///
  /// In en, this message translates to:
  /// **'Priority'**
  String get priority;

  /// No description provided for @supportTicketId.
  ///
  /// In en, this message translates to:
  /// **'Support Ticket ID'**
  String get supportTicketId;

  /// No description provided for @topServices.
  ///
  /// In en, this message translates to:
  /// **'Top Services'**
  String get topServices;

  /// No description provided for @history.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get history;

  /// No description provided for @amount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get amount;

  /// No description provided for @accept.
  ///
  /// In en, this message translates to:
  /// **'Accept'**
  String get accept;

  /// No description provided for @contentType.
  ///
  /// In en, this message translates to:
  /// **'Content Type'**
  String get contentType;

  /// No description provided for @authorization.
  ///
  /// In en, this message translates to:
  /// **'Authorization'**
  String get authorization;

  /// No description provided for @selectCategory.
  ///
  /// In en, this message translates to:
  /// **'Select Category'**
  String get selectCategory;

  /// No description provided for @selectSubCategory.
  ///
  /// In en, this message translates to:
  /// **'Select Subcategory'**
  String get selectSubCategory;

  /// No description provided for @noInternetConnection.
  ///
  /// In en, this message translates to:
  /// **'❌ No Internet Connection.'**
  String get noInternetConnection;

  /// No description provided for @thisFeatureIsTurnedOffForDemoApp.
  ///
  /// In en, this message translates to:
  /// **'This feature is turned off for demo app'**
  String get thisFeatureIsTurnedOffForDemoApp;

  /// No description provided for @passwordChangedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Password changed successfully'**
  String get passwordChangedSuccessfully;

  /// No description provided for @userToken.
  ///
  /// In en, this message translates to:
  /// **'User  Token'**
  String get userToken;

  /// No description provided for @appleIdRevokedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Apple ID revoked successfully'**
  String get appleIdRevokedSuccessfully;

  /// No description provided for @appleIdRevokeFailed.
  ///
  /// In en, this message translates to:
  /// **'Apple ID revoke failed'**
  String get appleIdRevokeFailed;

  /// No description provided for @pleaseTurnOnYourInternetConnection.
  ///
  /// In en, this message translates to:
  /// **'Please turn on your internet connection'**
  String get pleaseTurnOnYourInternetConnection;

  /// No description provided for @otpDidNotMatch.
  ///
  /// In en, this message translates to:
  /// **'OTP didn\'t match'**
  String get otpDidNotMatch;

  /// No description provided for @loginSuccessful.
  ///
  /// In en, this message translates to:
  /// **'Login successful'**
  String get loginSuccessful;

  /// No description provided for @users.
  ///
  /// In en, this message translates to:
  /// **'Users'**
  String get users;

  /// No description provided for @otpSendFailed.
  ///
  /// In en, this message translates to:
  /// **'OTP send failed'**
  String get otpSendFailed;

  /// No description provided for @invalidEmailOrPassword.
  ///
  /// In en, this message translates to:
  /// **'Invalid email or password'**
  String get invalidEmailOrPassword;

  /// No description provided for @otpSuccessfullySentInYourMobileNumber.
  ///
  /// In en, this message translates to:
  /// **'OTP successfully sent to your mobile number'**
  String get otpSuccessfullySentInYourMobileNumber;

  /// No description provided for @invalidMobileNumber.
  ///
  /// In en, this message translates to:
  /// **'Invalid mobile number'**
  String get invalidMobileNumber;

  /// No description provided for @checkYourNetworkConnections.
  ///
  /// In en, this message translates to:
  /// **'Check your network connections'**
  String get checkYourNetworkConnections;

  /// No description provided for @userIdIsNotAvailable.
  ///
  /// In en, this message translates to:
  /// **'User  ID is not available'**
  String get userIdIsNotAvailable;

  /// No description provided for @somethingWentWrongPleaseTryAgain.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Please try again.'**
  String get somethingWentWrongPleaseTryAgain;

  /// No description provided for @pass.
  ///
  /// In en, this message translates to:
  /// **'Pass'**
  String get pass;

  /// No description provided for @passwordDidNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Password did not match'**
  String get passwordDidNotMatch;

  /// No description provided for @passwordUpdatedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Password updated successfully'**
  String get passwordUpdatedSuccessfully;

  /// No description provided for @registrationSuccessful.
  ///
  /// In en, this message translates to:
  /// **'Registration successful'**
  String get registrationSuccessful;

  /// No description provided for @servicePersonalization.
  ///
  /// In en, this message translates to:
  /// **'Service Personalization'**
  String get servicePersonalization;

  /// No description provided for @availableSchedules.
  ///
  /// In en, this message translates to:
  /// **'Available Schedules'**
  String get availableSchedules;

  /// No description provided for @chooseLocation.
  ///
  /// In en, this message translates to:
  /// **'Choose Location'**
  String get chooseLocation;

  /// No description provided for @informations.
  ///
  /// In en, this message translates to:
  /// **'Information\'s'**
  String get informations;

  /// No description provided for @bookingConfirmations.
  ///
  /// In en, this message translates to:
  /// **'Booking Confirmations'**
  String get bookingConfirmations;

  /// No description provided for @includeServices.
  ///
  /// In en, this message translates to:
  /// **'Include Services'**
  String get includeServices;

  /// No description provided for @additionalServices.
  ///
  /// In en, this message translates to:
  /// **'Additional Services'**
  String get additionalServices;

  /// No description provided for @youHaveReceivedAnOrderFrom.
  ///
  /// In en, this message translates to:
  /// **'You have received an order from'**
  String get youHaveReceivedAnOrderFrom;

  /// No description provided for @categories.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get categories;

  /// No description provided for @categoryDataIsNullOrInvalid.
  ///
  /// In en, this message translates to:
  /// **'Category data is null or invalid.'**
  String get categoryDataIsNullOrInvalid;

  /// No description provided for @responseIsNull.
  ///
  /// In en, this message translates to:
  /// **'Response is null'**
  String get responseIsNull;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @online.
  ///
  /// In en, this message translates to:
  /// **'Online'**
  String get online;

  /// No description provided for @offline.
  ///
  /// In en, this message translates to:
  /// **'Offline'**
  String get offline;

  /// No description provided for @searchServices.
  ///
  /// In en, this message translates to:
  /// **'Search Services'**
  String get searchServices;

  /// No description provided for @results.
  ///
  /// In en, this message translates to:
  /// **'Results'**
  String get results;

  /// No description provided for @subLocality.
  ///
  /// In en, this message translates to:
  /// **'Sub Locality'**
  String get subLocality;

  /// No description provided for @fetchingPlaceDetailsId.
  ///
  /// In en, this message translates to:
  /// **'Fetching place details for \$id'**
  String get fetchingPlaceDetailsId;

  /// No description provided for @main.
  ///
  /// In en, this message translates to:
  /// **'Main'**
  String get main;

  /// No description provided for @top.
  ///
  /// In en, this message translates to:
  /// **'Top'**
  String get top;

  /// No description provided for @newJobChatMessage.
  ///
  /// In en, this message translates to:
  /// **'New job chat message'**
  String get newJobChatMessage;

  /// No description provided for @success.
  ///
  /// In en, this message translates to:
  /// **'Success!'**
  String get success;

  /// No description provided for @failedToFetchLeads.
  ///
  /// In en, this message translates to:
  /// **'Failed to fetch leads'**
  String get failedToFetchLeads;

  /// No description provided for @newChatMessage.
  ///
  /// In en, this message translates to:
  /// **'New chat message'**
  String get newChatMessage;

  /// No description provided for @delivered.
  ///
  /// In en, this message translates to:
  /// **'Delivered'**
  String get delivered;

  /// No description provided for @cancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get cancelled;

  /// No description provided for @acceptedYourOrderExtraRequest.
  ///
  /// In en, this message translates to:
  /// **'Accepted your order extra request'**
  String get acceptedYourOrderExtraRequest;

  /// No description provided for @declinedYourOrderExtraRequest.
  ///
  /// In en, this message translates to:
  /// **'Declined your order extra request'**
  String get declinedYourOrderExtraRequest;

  /// No description provided for @completed.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completed;

  /// No description provided for @acceptedYourOrderCompletionRequest.
  ///
  /// In en, this message translates to:
  /// **'Accepted your order completion request'**
  String get acceptedYourOrderCompletionRequest;

  /// No description provided for @usernameRejectedYourOrderCompletionRequest.
  ///
  /// In en, this message translates to:
  /// **'\$username rejected your order completion request'**
  String get usernameRejectedYourOrderCompletionRequest;

  /// No description provided for @nameAmount.
  ///
  /// In en, this message translates to:
  /// **'\$name \$amount'**
  String get nameAmount;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @test.
  ///
  /// In en, this message translates to:
  /// **'Test'**
  String get test;

  /// No description provided for @orderAmount.
  ///
  /// In en, this message translates to:
  /// **'Order Amount'**
  String get orderAmount;

  /// No description provided for @customerName.
  ///
  /// In en, this message translates to:
  /// **'Customer Name'**
  String get customerName;

  /// No description provided for @orderCurrency.
  ///
  /// In en, this message translates to:
  /// **'Order Currency'**
  String get orderCurrency;

  /// No description provided for @appId.
  ///
  /// In en, this message translates to:
  /// **'App ID'**
  String get appId;

  /// No description provided for @customerPhone.
  ///
  /// In en, this message translates to:
  /// **'Customer Phone'**
  String get customerPhone;

  /// No description provided for @customerEmail.
  ///
  /// In en, this message translates to:
  /// **'Customer Email'**
  String get customerEmail;

  /// No description provided for @stage.
  ///
  /// In en, this message translates to:
  /// **'Stage'**
  String get stage;

  /// No description provided for @tokenData.
  ///
  /// In en, this message translates to:
  /// **'Token Data'**
  String get tokenData;

  /// No description provided for @notifyUrl.
  ///
  /// In en, this message translates to:
  /// **'Notify URL'**
  String get notifyUrl;

  /// No description provided for @flutterwavePayment.
  ///
  /// In en, this message translates to:
  /// **'Flutterwave Payment'**
  String get flutterwavePayment;

  /// No description provided for @payCurrencyAmount.
  ///
  /// In en, this message translates to:
  /// **'Pay \$currency \$amount'**
  String get payCurrencyAmount;

  /// No description provided for @flwDeveloper.
  ///
  /// In en, this message translates to:
  /// **'FLW Developer'**
  String get flwDeveloper;

  /// No description provided for @flat.
  ///
  /// In en, this message translates to:
  /// **'Flat'**
  String get flat;

  /// No description provided for @cardPayattitude.
  ///
  /// In en, this message translates to:
  /// **'Card, Payattitude'**
  String get cardPayattitude;

  /// No description provided for @testPayment.
  ///
  /// In en, this message translates to:
  /// **'Test Payment'**
  String get testPayment;

  /// No description provided for @noResponse.
  ///
  /// In en, this message translates to:
  /// **'No response!'**
  String get noResponse;

  /// No description provided for @youDontHaveEnoughWalletBalance.
  ///
  /// In en, this message translates to:
  /// **'You don\'t have enough wallet balance'**
  String get youDontHaveEnoughWalletBalance;

  /// No description provided for @accessToken.
  ///
  /// In en, this message translates to:
  /// **'Access Token'**
  String get accessToken;

  /// No description provided for @rel.
  ///
  /// In en, this message translates to:
  /// **'Rel'**
  String get rel;

  /// No description provided for @approvalUrl.
  ///
  /// In en, this message translates to:
  /// **'Approval URL'**
  String get approvalUrl;

  /// No description provided for @href.
  ///
  /// In en, this message translates to:
  /// **'Href'**
  String get href;

  /// No description provided for @execute.
  ///
  /// In en, this message translates to:
  /// **'Execute'**
  String get execute;

  /// No description provided for @executeUrl.
  ///
  /// In en, this message translates to:
  /// **'Execute URL'**
  String get executeUrl;

  /// No description provided for @payerId.
  ///
  /// In en, this message translates to:
  /// **'Payer ID'**
  String get payerId;

  /// No description provided for @paymentCancelled.
  ///
  /// In en, this message translates to:
  /// **'Payment cancelled!'**
  String get paymentCancelled;

  /// No description provided for @wallet.
  ///
  /// In en, this message translates to:
  /// **'Wallet'**
  String get wallet;

  /// No description provided for @paymentGatewayList.
  ///
  /// In en, this message translates to:
  /// **'Payment Gateway List'**
  String get paymentGatewayList;

  /// No description provided for @interests.
  ///
  /// In en, this message translates to:
  /// **'Interests'**
  String get interests;

  /// No description provided for @debugSellerSellerId.
  ///
  /// In en, this message translates to:
  /// **'Debug-Seller \$sellerId'**
  String get debugSellerSellerId;

  /// No description provided for @fcm.
  ///
  /// In en, this message translates to:
  /// **'FCM'**
  String get fcm;

  /// No description provided for @notification.
  ///
  /// In en, this message translates to:
  /// **'Notification'**
  String get notification;

  /// No description provided for @baseApiHomeHomeSearch.
  ///
  /// In en, this message translates to:
  /// **'\$baseApi/home/home-search'**
  String get baseApiHomeHomeSearch;

  /// No description provided for @subcategoryList.
  ///
  /// In en, this message translates to:
  /// **'Subcategory List'**
  String get subcategoryList;

  /// No description provided for @newMessageFromSupportUsername.
  ///
  /// In en, this message translates to:
  /// **'New message from support: \$username'**
  String get newMessageFromSupportUsername;

  /// No description provided for @gilroy.
  ///
  /// In en, this message translates to:
  /// **'Gilroy'**
  String get gilroy;

  /// No description provided for @usd.
  ///
  /// In en, this message translates to:
  /// **'USD'**
  String get usd;

  /// No description provided for @direct.
  ///
  /// In en, this message translates to:
  /// **'Direct'**
  String get direct;

  /// No description provided for @vendor.
  ///
  /// In en, this message translates to:
  /// **'Vendor'**
  String get vendor;

  /// No description provided for @totalServices.
  ///
  /// In en, this message translates to:
  /// **'Total Services'**
  String get totalServices;

  /// No description provided for @leadsGenerated.
  ///
  /// In en, this message translates to:
  /// **'Leads Generated'**
  String get leadsGenerated;

  /// No description provided for @myService.
  ///
  /// In en, this message translates to:
  /// **'My Service'**
  String get myService;

  /// No description provided for @subscriptions.
  ///
  /// In en, this message translates to:
  /// **'Subscriptions'**
  String get subscriptions;

  /// No description provided for @dashboard.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get dashboard;

  /// No description provided for @chooseCategory.
  ///
  /// In en, this message translates to:
  /// **'Choose Category'**
  String get chooseCategory;

  /// No description provided for @shashaktnirmanIsLoggedIn.
  ///
  /// In en, this message translates to:
  /// **'shashaktnirman is logged in'**
  String get shashaktnirmanIsLoggedIn;

  /// No description provided for @addService.
  ///
  /// In en, this message translates to:
  /// **'Add Service'**
  String get addService;

  /// No description provided for @createOpeningSchedule.
  ///
  /// In en, this message translates to:
  /// **'Create Opening Schedule'**
  String get createOpeningSchedule;

  /// No description provided for @helpAndSupport.
  ///
  /// In en, this message translates to:
  /// **'Help and Support'**
  String get helpAndSupport;

  /// No description provided for @featureImage.
  ///
  /// In en, this message translates to:
  /// **'Feature Image'**
  String get featureImage;

  /// No description provided for @plumbingServices.
  ///
  /// In en, this message translates to:
  /// **'Plumbing Services'**
  String get plumbingServices;

  /// No description provided for @homeRepair.
  ///
  /// In en, this message translates to:
  /// **'Home Repair'**
  String get homeRepair;

  /// No description provided for @plumbing.
  ///
  /// In en, this message translates to:
  /// **'Plumbing'**
  String get plumbing;

  /// No description provided for @createdDate.
  ///
  /// In en, this message translates to:
  /// **'Created Date'**
  String get createdDate;

  /// No description provided for @isActive.
  ///
  /// In en, this message translates to:
  /// **'Is Active'**
  String get isActive;

  /// No description provided for @electricalMaintenance.
  ///
  /// In en, this message translates to:
  /// **'Electrical Maintenance'**
  String get electricalMaintenance;

  /// No description provided for @electrical.
  ///
  /// In en, this message translates to:
  /// **'Electrical'**
  String get electrical;

  /// No description provided for @carpentryWork.
  ///
  /// In en, this message translates to:
  /// **'Carpentry Work'**
  String get carpentryWork;

  /// No description provided for @furniture.
  ///
  /// In en, this message translates to:
  /// **'Furniture'**
  String get furniture;

  /// No description provided for @woodwork.
  ///
  /// In en, this message translates to:
  /// **'Woodwork'**
  String get woodwork;

  /// No description provided for @cleaningServices.
  ///
  /// In en, this message translates to:
  /// **'Cleaning Services'**
  String get cleaningServices;

  /// No description provided for @homeServices.
  ///
  /// In en, this message translates to:
  /// **'Home Services'**
  String get homeServices;

  /// No description provided for @pestControl.
  ///
  /// In en, this message translates to:
  /// **'Pest Control'**
  String get pestControl;

  /// No description provided for @myServices.
  ///
  /// In en, this message translates to:
  /// **'My Services'**
  String get myServices;

  /// No description provided for @updateService.
  ///
  /// In en, this message translates to:
  /// **'Update Service'**
  String get updateService;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @editCity.
  ///
  /// In en, this message translates to:
  /// **'Edit City'**
  String get editCity;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @deactive.
  ///
  /// In en, this message translates to:
  /// **'Deactive'**
  String get deactive;

  /// No description provided for @dayName.
  ///
  /// In en, this message translates to:
  /// **'Day Name'**
  String get dayName;

  /// No description provided for @sun.
  ///
  /// In en, this message translates to:
  /// **'Sunday'**
  String get sun;

  /// No description provided for @mon.
  ///
  /// In en, this message translates to:
  /// **'Monday'**
  String get mon;

  /// No description provided for @tue.
  ///
  /// In en, this message translates to:
  /// **'Tuesday'**
  String get tue;

  /// No description provided for @wed.
  ///
  /// In en, this message translates to:
  /// **'Wednesday'**
  String get wed;

  /// No description provided for @thu.
  ///
  /// In en, this message translates to:
  /// **'Thursday'**
  String get thu;

  /// No description provided for @fri.
  ///
  /// In en, this message translates to:
  /// **'Friday'**
  String get fri;

  /// No description provided for @sat.
  ///
  /// In en, this message translates to:
  /// **'Saturday'**
  String get sat;

  /// No description provided for @selectADay.
  ///
  /// In en, this message translates to:
  /// **'Select a Day'**
  String get selectADay;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @selectedDay.
  ///
  /// In en, this message translates to:
  /// **'Selected Day: \$selectedDay'**
  String get selectedDay;

  /// No description provided for @createSchedule.
  ///
  /// In en, this message translates to:
  /// **'Create Schedule'**
  String get createSchedule;

  /// No description provided for @setPriority.
  ///
  /// In en, this message translates to:
  /// **'Set Priority'**
  String get setPriority;

  /// No description provided for @enterTitle.
  ///
  /// In en, this message translates to:
  /// **'Enter Title'**
  String get enterTitle;

  /// No description provided for @pleaseExplainYourProblem.
  ///
  /// In en, this message translates to:
  /// **'Please explain your problem'**
  String get pleaseExplainYourProblem;

  /// No description provided for @submit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// No description provided for @free.
  ///
  /// In en, this message translates to:
  /// **'Free'**
  String get free;

  /// No description provided for @desc.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get desc;

  /// No description provided for @yourCurrentPlan.
  ///
  /// In en, this message translates to:
  /// **'Your Current Plan'**
  String get yourCurrentPlan;

  /// No description provided for @typeBgColor.
  ///
  /// In en, this message translates to:
  /// **'Type Background Color'**
  String get typeBgColor;

  /// No description provided for @typeTextColor.
  ///
  /// In en, this message translates to:
  /// **'Type Text Color'**
  String get typeTextColor;

  /// No description provided for @premium.
  ///
  /// In en, this message translates to:
  /// **'Premium'**
  String get premium;

  /// No description provided for @upgradeNow.
  ///
  /// In en, this message translates to:
  /// **'Upgrade Now'**
  String get upgradeNow;

  /// No description provided for @gold.
  ///
  /// In en, this message translates to:
  /// **'Gold'**
  String get gold;

  /// No description provided for @bestValue.
  ///
  /// In en, this message translates to:
  /// **'Best Value'**
  String get bestValue;

  /// No description provided for @platinum.
  ///
  /// In en, this message translates to:
  /// **'Platinum'**
  String get platinum;

  /// No description provided for @elitePlan.
  ///
  /// In en, this message translates to:
  /// **'Elite Plan'**
  String get elitePlan;

  /// No description provided for @promotion.
  ///
  /// In en, this message translates to:
  /// **'Promotion'**
  String get promotion;

  /// No description provided for @subscriptionModule.
  ///
  /// In en, this message translates to:
  /// **'Subscription Module'**
  String get subscriptionModule;

  /// No description provided for @supportHistory.
  ///
  /// In en, this message translates to:
  /// **'Support History'**
  String get supportHistory;

  /// No description provided for @jsonStringIsNull.
  ///
  /// In en, this message translates to:
  /// **'JSON string is null.'**
  String get jsonStringIsNull;

  /// No description provided for @childCategories.
  ///
  /// In en, this message translates to:
  /// **'Child Categories'**
  String get childCategories;

  /// No description provided for @selectSubChildCategory.
  ///
  /// In en, this message translates to:
  /// **'Select Sub Child Category'**
  String get selectSubChildCategory;

  /// No description provided for @pleaseEnterYourServiceName.
  ///
  /// In en, this message translates to:
  /// **'Please enter your service name'**
  String get pleaseEnterYourServiceName;

  /// No description provided for @enterYourServiceName.
  ///
  /// In en, this message translates to:
  /// **'Enter your service name'**
  String get enterYourServiceName;

  /// No description provided for @serviceType.
  ///
  /// In en, this message translates to:
  /// **'Service Type'**
  String get serviceType;

  /// No description provided for @pleaseEnterYourServiceType.
  ///
  /// In en, this message translates to:
  /// **'Please enter your service type'**
  String get pleaseEnterYourServiceType;

  /// No description provided for @enterYourServiceType.
  ///
  /// In en, this message translates to:
  /// **'Enter your service type'**
  String get enterYourServiceType;

  /// No description provided for @serviceExperience.
  ///
  /// In en, this message translates to:
  /// **'Service Experience'**
  String get serviceExperience;

  /// No description provided for @pleaseEnterYourServiceExperience.
  ///
  /// In en, this message translates to:
  /// **'Please enter your service experience'**
  String get pleaseEnterYourServiceExperience;

  /// No description provided for @enterYourServiceExperience.
  ///
  /// In en, this message translates to:
  /// **'Enter your service experience'**
  String get enterYourServiceExperience;

  /// No description provided for @officeServiceTime.
  ///
  /// In en, this message translates to:
  /// **'Office/Service Time'**
  String get officeServiceTime;

  /// No description provided for @openTime.
  ///
  /// In en, this message translates to:
  /// **'Open Time:'**
  String get openTime;

  /// No description provided for @closeTime.
  ///
  /// In en, this message translates to:
  /// **'Close Time'**
  String get closeTime;

  /// No description provided for @isAvailableAllCities.
  ///
  /// In en, this message translates to:
  /// **'Is Available in All Cities:'**
  String get isAvailableAllCities;

  /// No description provided for @pleaseEnterYourServiceCities.
  ///
  /// In en, this message translates to:
  /// **'Please enter your service cities'**
  String get pleaseEnterYourServiceCities;

  /// No description provided for @enterYourServiceCities.
  ///
  /// In en, this message translates to:
  /// **'Enter your service cities'**
  String get enterYourServiceCities;

  /// No description provided for @chooseState.
  ///
  /// In en, this message translates to:
  /// **'Choose State'**
  String get chooseState;

  /// No description provided for @chooseCity.
  ///
  /// In en, this message translates to:
  /// **'Choose City'**
  String get chooseCity;

  /// No description provided for @servicePrice.
  ///
  /// In en, this message translates to:
  /// **'Service Price'**
  String get servicePrice;

  /// No description provided for @enterServicePrice.
  ///
  /// In en, this message translates to:
  /// **'Enter Service Price'**
  String get enterServicePrice;

  /// No description provided for @serviceOverview.
  ///
  /// In en, this message translates to:
  /// **'Service Overview'**
  String get serviceOverview;

  /// No description provided for @enterServiceOverview.
  ///
  /// In en, this message translates to:
  /// **'Enter Service Overview'**
  String get enterServiceOverview;

  /// No description provided for @serviceOverviewMust150Char.
  ///
  /// In en, this message translates to:
  /// **'Service Over View Must 150 Character'**
  String get serviceOverviewMust150Char;

  /// No description provided for @servicePriceChart.
  ///
  /// In en, this message translates to:
  /// **'Service Price Chart'**
  String get servicePriceChart;

  /// No description provided for @serviceTimeChart.
  ///
  /// In en, this message translates to:
  /// **'Service Time Chart'**
  String get serviceTimeChart;

  /// No description provided for @serviceImages.
  ///
  /// In en, this message translates to:
  /// **'Service Images'**
  String get serviceImages;

  /// No description provided for @noImageSelected.
  ///
  /// In en, this message translates to:
  /// **'No image selected'**
  String get noImageSelected;

  /// No description provided for @addImage.
  ///
  /// In en, this message translates to:
  /// **'Add Image'**
  String get addImage;

  /// No description provided for @continueText.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueText;

  /// No description provided for @serviceAdded.
  ///
  /// In en, this message translates to:
  /// **'Service added'**
  String get serviceAdded;

  /// No description provided for @categoryAndSubcategoryRequired.
  ///
  /// In en, this message translates to:
  /// **'Category and Subcategory required'**
  String get categoryAndSubcategoryRequired;

  /// No description provided for @imageRequired.
  ///
  /// In en, this message translates to:
  /// **'Image required'**
  String get imageRequired;

  /// No description provided for @failedToAddService.
  ///
  /// In en, this message translates to:
  /// **'Failed to add service'**
  String get failedToAddService;

  /// No description provided for @chooseReason.
  ///
  /// In en, this message translates to:
  /// **'Choose Reason'**
  String get chooseReason;

  /// No description provided for @shortDescription.
  ///
  /// In en, this message translates to:
  /// **'Short Description'**
  String get shortDescription;

  /// No description provided for @enterPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter Password'**
  String get enterPassword;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @number.
  ///
  /// In en, this message translates to:
  /// **'Number'**
  String get number;

  /// No description provided for @pleaseEnterOtp.
  ///
  /// In en, this message translates to:
  /// **'Please enter OTP'**
  String get pleaseEnterOtp;

  /// No description provided for @otpVerificationSuccess.
  ///
  /// In en, this message translates to:
  /// **'OTP verification successful'**
  String get otpVerificationSuccess;

  /// No description provided for @otpVerificationFailed.
  ///
  /// In en, this message translates to:
  /// **'OTP verification failed'**
  String get otpVerificationFailed;

  /// No description provided for @pressedBack.
  ///
  /// In en, this message translates to:
  /// **'Pressed Back'**
  String get pressedBack;

  /// No description provided for @enterYourMobileNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter your mobile number'**
  String get enterYourMobileNumber;

  /// No description provided for @mobileNumber.
  ///
  /// In en, this message translates to:
  /// **'Mobile Number'**
  String get mobileNumber;

  /// No description provided for @searchCountry.
  ///
  /// In en, this message translates to:
  /// **'Search Country'**
  String get searchCountry;

  /// No description provided for @emailOrUsername.
  ///
  /// In en, this message translates to:
  /// **'Email or Username'**
  String get emailOrUsername;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @rememberMe.
  ///
  /// In en, this message translates to:
  /// **'Remember Me'**
  String get rememberMe;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgotPassword;

  /// No description provided for @dontHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get dontHaveAccount;

  /// No description provided for @or.
  ///
  /// In en, this message translates to:
  /// **'Or'**
  String get or;

  /// No description provided for @loginWithGoogle.
  ///
  /// In en, this message translates to:
  /// **'Login with Google'**
  String get loginWithGoogle;

  /// No description provided for @signInWithApple.
  ///
  /// In en, this message translates to:
  /// **'Sign in with Apple'**
  String get signInWithApple;

  /// No description provided for @loginWithFacebook.
  ///
  /// In en, this message translates to:
  /// **'Login with Facebook'**
  String get loginWithFacebook;

  /// No description provided for @signupUser.
  ///
  /// In en, this message translates to:
  /// **'Sign up User'**
  String get signupUser;

  /// No description provided for @signupVendor.
  ///
  /// In en, this message translates to:
  /// **'Sign up Vendor'**
  String get signupVendor;

  /// No description provided for @resetPassword.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get resetPassword;

  /// No description provided for @enterEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter Email'**
  String get enterEmail;

  /// No description provided for @pleaseEnterYourEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email'**
  String get pleaseEnterYourEmail;

  /// No description provided for @sendInstructions.
  ///
  /// In en, this message translates to:
  /// **'Send Instructions'**
  String get sendInstructions;

  /// No description provided for @enterThe4DigitCode.
  ///
  /// In en, this message translates to:
  /// **'Enter the 4 digit code'**
  String get enterThe4DigitCode;

  /// No description provided for @sendAgain.
  ///
  /// In en, this message translates to:
  /// **'Send Again'**
  String get sendAgain;

  /// No description provided for @selectArea.
  ///
  /// In en, this message translates to:
  /// **'Select Area'**
  String get selectArea;

  /// No description provided for @constStringSelectArea.
  ///
  /// In en, this message translates to:
  /// **'Select Area'**
  String get constStringSelectArea;

  /// No description provided for @constStringNoAreaFound.
  ///
  /// In en, this message translates to:
  /// **'No area found'**
  String get constStringNoAreaFound;

  /// No description provided for @chooseCountry.
  ///
  /// In en, this message translates to:
  /// **'Choose Country'**
  String get chooseCountry;

  /// No description provided for @fillYourGeneralDetails.
  ///
  /// In en, this message translates to:
  /// **'Fill your general details'**
  String get fillYourGeneralDetails;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullName;

  /// No description provided for @enterYourFullName.
  ///
  /// In en, this message translates to:
  /// **'Enter your full name'**
  String get enterYourFullName;

  /// No description provided for @enterYourUsername.
  ///
  /// In en, this message translates to:
  /// **'Enter your username'**
  String get enterYourUsername;

  /// No description provided for @enterYourEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get enterYourEmail;

  /// No description provided for @selectCountryAndStateFirst.
  ///
  /// In en, this message translates to:
  /// **'Select country and state first'**
  String get selectCountryAndStateFirst;

  /// No description provided for @chooseArea.
  ///
  /// In en, this message translates to:
  /// **'Choose Area'**
  String get chooseArea;

  /// No description provided for @fillYourBusinessDetails.
  ///
  /// In en, this message translates to:
  /// **'Fill your business details'**
  String get fillYourBusinessDetails;

  /// No description provided for @pleaseEnterYourBusinessName.
  ///
  /// In en, this message translates to:
  /// **'Please enter your business name'**
  String get pleaseEnterYourBusinessName;

  /// No description provided for @enterYourBusinessName.
  ///
  /// In en, this message translates to:
  /// **'Enter your business name'**
  String get enterYourBusinessName;

  /// No description provided for @pleaseEnterYourGstNumber.
  ///
  /// In en, this message translates to:
  /// **'Please enter your GST number'**
  String get pleaseEnterYourGstNumber;

  /// No description provided for @enterYourGstNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter your GST number'**
  String get enterYourGstNumber;

  /// No description provided for @pleaseEnterYourPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Please enter your phone number'**
  String get pleaseEnterYourPhoneNumber;

  /// No description provided for @enterYourPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter your phone number'**
  String get enterYourPhoneNumber;

  /// No description provided for @pleaseEnterYourBusinessEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter your business email'**
  String get pleaseEnterYourBusinessEmail;

  /// No description provided for @enterYourBusinessEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter your business email'**
  String get enterYourBusinessEmail;

  /// No description provided for @businessAddress.
  ///
  /// In en, this message translates to:
  /// **'Business Address'**
  String get businessAddress;

  /// No description provided for @pleaseEnterYourBusinessAddress.
  ///
  /// In en, this message translates to:
  /// **'Please enter your business address'**
  String get pleaseEnterYourBusinessAddress;

  /// No description provided for @enterYourBusinessAddress.
  ///
  /// In en, this message translates to:
  /// **'Enter your business address'**
  String get enterYourBusinessAddress;

  /// No description provided for @pleaseEnterYourBusinessState.
  ///
  /// In en, this message translates to:
  /// **'Please enter your business state'**
  String get pleaseEnterYourBusinessState;

  /// No description provided for @enterYourBusinessState.
  ///
  /// In en, this message translates to:
  /// **'Enter your business state'**
  String get enterYourBusinessState;

  /// No description provided for @pleaseEnterYourBusinessCity.
  ///
  /// In en, this message translates to:
  /// **'Please enter your business city'**
  String get pleaseEnterYourBusinessCity;

  /// No description provided for @enterYourBusinessCity.
  ///
  /// In en, this message translates to:
  /// **'Enter your business city'**
  String get enterYourBusinessCity;

  /// No description provided for @pleaseEnterYourBusinessDescription.
  ///
  /// In en, this message translates to:
  /// **'Please enter your business description'**
  String get pleaseEnterYourBusinessDescription;

  /// No description provided for @enterYourBusinessDescription.
  ///
  /// In en, this message translates to:
  /// **'Enter your business description'**
  String get enterYourBusinessDescription;

  /// No description provided for @pleaseFillRequiredFields.
  ///
  /// In en, this message translates to:
  /// **'Please Fill Required Fields'**
  String get pleaseFillRequiredFields;

  /// No description provided for @iAgreeTo.
  ///
  /// In en, this message translates to:
  /// **'I agree to'**
  String get iAgreeTo;

  /// No description provided for @termsAndCondition.
  ///
  /// In en, this message translates to:
  /// **'Terms and Conditions'**
  String get termsAndCondition;

  /// No description provided for @termsAndConditions.
  ///
  /// In en, this message translates to:
  /// **'Terms and Conditions'**
  String get termsAndConditions;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @youMustAgreeWithTheTermsAndConditionsToRegister.
  ///
  /// In en, this message translates to:
  /// **'You must agree with the terms and conditions to register'**
  String get youMustAgreeWithTheTermsAndConditionsToRegister;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUp;

  /// No description provided for @youMustSelectAStateAndArea.
  ///
  /// In en, this message translates to:
  /// **'You must select a state and area'**
  String get youMustSelectAStateAndArea;

  /// No description provided for @repeatPassword.
  ///
  /// In en, this message translates to:
  /// **'Repeat Password'**
  String get repeatPassword;

  /// No description provided for @pleaseRetypeYourPassword.
  ///
  /// In en, this message translates to:
  /// **'Please retype your password'**
  String get pleaseRetypeYourPassword;

  /// No description provided for @passwordMustBeAtLeast6Characters.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters'**
  String get passwordMustBeAtLeast6Characters;

  /// No description provided for @nothingFound.
  ///
  /// In en, this message translates to:
  /// **'Nothing found'**
  String get nothingFound;

  /// No description provided for @pageContent.
  ///
  /// In en, this message translates to:
  /// **'Page Content'**
  String get pageContent;

  /// No description provided for @shashaktnirmanPhone.
  ///
  /// In en, this message translates to:
  /// **'shashaktnirman Phone'**
  String get shashaktnirmanPhone;

  /// No description provided for @addYourDetails.
  ///
  /// In en, this message translates to:
  /// **'Add your details'**
  String get addYourDetails;

  /// No description provided for @listenerIsWorking.
  ///
  /// In en, this message translates to:
  /// **'Listener is working'**
  String get listenerIsWorking;

  /// No description provided for @kyaDaluYahaPar.
  ///
  /// In en, this message translates to:
  /// **'क्या दलु यहाँ पर'**
  String get kyaDaluYahaPar;

  /// No description provided for @bookingInformations.
  ///
  /// In en, this message translates to:
  /// **'Booking Information\'s'**
  String get bookingInformations;

  /// No description provided for @depositAmount.
  ///
  /// In en, this message translates to:
  /// **'Deposit Amount'**
  String get depositAmount;

  /// No description provided for @enterDepositAmount.
  ///
  /// In en, this message translates to:
  /// **'Enter Deposit Amount'**
  String get enterDepositAmount;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signIn;

  /// No description provided for @civilWork.
  ///
  /// In en, this message translates to:
  /// **'Civil Work'**
  String get civilWork;

  /// No description provided for @carpentry.
  ///
  /// In en, this message translates to:
  /// **'Carpentry'**
  String get carpentry;

  /// No description provided for @defaultValue.
  ///
  /// In en, this message translates to:
  /// **'Default'**
  String get defaultValue;

  /// No description provided for @categoryNotSelected.
  ///
  /// In en, this message translates to:
  /// **'Category not selected'**
  String get categoryNotSelected;

  /// No description provided for @youHaveSelectedCategorySuccessfully.
  ///
  /// In en, this message translates to:
  /// **'You have selected category successfully.'**
  String get youHaveSelectedCategorySuccessfully;

  /// No description provided for @vendorDashboard.
  ///
  /// In en, this message translates to:
  /// **'Vendor Dashboard'**
  String get vendorDashboard;

  /// No description provided for @plumbingWaterSupply.
  ///
  /// In en, this message translates to:
  /// **'Plumbing / Water Supply'**
  String get plumbingWaterSupply;

  /// No description provided for @invalidIndex.
  ///
  /// In en, this message translates to:
  /// **'Invalid index: \$index'**
  String get invalidIndex;

  /// No description provided for @somethingWentWrong.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get somethingWentWrong;

  /// No description provided for @lasLaChargingStation.
  ///
  /// In en, this message translates to:
  /// **'Las La-Charging Station'**
  String get lasLaChargingStation;

  /// No description provided for @oneNationOneClick.
  ///
  /// In en, this message translates to:
  /// **'One Nation One Click'**
  String get oneNationOneClick;

  /// No description provided for @exploreLocations.
  ///
  /// In en, this message translates to:
  /// **'Explore Locations'**
  String get exploreLocations;

  /// No description provided for @tapOkToChatOrTapCancelToDismiss.
  ///
  /// In en, this message translates to:
  /// **'Tap OK to chat, or tap Cancel to dismiss.'**
  String get tapOkToChatOrTapCancelToDismiss;

  /// No description provided for @mapViewChangedValueIs.
  ///
  /// In en, this message translates to:
  /// **'Map view changed, value is - \$value'**
  String get mapViewChangedValueIs;

  /// No description provided for @goToDashboard.
  ///
  /// In en, this message translates to:
  /// **'Go to Dashboard'**
  String get goToDashboard;

  /// No description provided for @showLessCategory.
  ///
  /// In en, this message translates to:
  /// **'Show Less Category'**
  String get showLessCategory;

  /// No description provided for @showMoreCategory.
  ///
  /// In en, this message translates to:
  /// **'Show More Category'**
  String get showMoreCategory;

  /// No description provided for @viewMore.
  ///
  /// In en, this message translates to:
  /// **'View More'**
  String get viewMore;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @pressAgainToExit.
  ///
  /// In en, this message translates to:
  /// **'Press again to exit'**
  String get pressAgainToExit;

  /// No description provided for @mapGotCreated.
  ///
  /// In en, this message translates to:
  /// **'Map got created'**
  String get mapGotCreated;

  /// No description provided for @markerAddedLatLng.
  ///
  /// In en, this message translates to:
  /// **'Marker added \$latLng'**
  String get markerAddedLatLng;

  /// No description provided for @fgs.
  ///
  /// In en, this message translates to:
  /// **'FGS'**
  String get fgs;

  /// No description provided for @repairingServices.
  ///
  /// In en, this message translates to:
  /// **'Repairing Services'**
  String get repairingServices;

  /// No description provided for @houseCleaningService.
  ///
  /// In en, this message translates to:
  /// **'House Cleaning Service'**
  String get houseCleaningService;

  /// No description provided for @homeShiftingService.
  ///
  /// In en, this message translates to:
  /// **'Home Shifting Service'**
  String get homeShiftingService;

  /// No description provided for @getRepairedAnythingFromOurThousandsOfExperts.
  ///
  /// In en, this message translates to:
  /// **'Get repaired anything from our thousands of experts'**
  String get getRepairedAnythingFromOurThousandsOfExperts;

  /// No description provided for @getHouseCleaningServicesFromExpertCleaners.
  ///
  /// In en, this message translates to:
  /// **'Get house cleaning services from expert cleaners'**
  String get getHouseCleaningServicesFromExpertCleaners;

  /// No description provided for @takeOurHomeShiftingServiceToGetBestService.
  ///
  /// In en, this message translates to:
  /// **'Take our home shifting service to get best service'**
  String get takeOurHomeShiftingServiceToGetBestService;

  /// No description provided for @chooseStates.
  ///
  /// In en, this message translates to:
  /// **'Choose States'**
  String get chooseStates;

  /// No description provided for @budget.
  ///
  /// In en, this message translates to:
  /// **'Budget'**
  String get budget;

  /// No description provided for @endDate.
  ///
  /// In en, this message translates to:
  /// **'End Date'**
  String get endDate;

  /// No description provided for @selectDate.
  ///
  /// In en, this message translates to:
  /// **'Select Date'**
  String get selectDate;

  /// No description provided for @writeMessage.
  ///
  /// In en, this message translates to:
  /// **'Write Message'**
  String get writeMessage;

  /// No description provided for @hideDescription.
  ///
  /// In en, this message translates to:
  /// **'Hide Description'**
  String get hideDescription;

  /// No description provided for @showDescription.
  ///
  /// In en, this message translates to:
  /// **'Show Description'**
  String get showDescription;

  /// No description provided for @chat.
  ///
  /// In en, this message translates to:
  /// **'Chat'**
  String get chat;

  /// No description provided for @conversations.
  ///
  /// In en, this message translates to:
  /// **'Conversations'**
  String get conversations;

  /// No description provided for @youDontHaveAnyActiveConversation.
  ///
  /// In en, this message translates to:
  /// **'You don\'t have any active conversation'**
  String get youDontHaveAnyActiveConversation;

  /// No description provided for @auth.
  ///
  /// In en, this message translates to:
  /// **'Authentication'**
  String get auth;

  /// No description provided for @userData.
  ///
  /// In en, this message translates to:
  /// **'User  Data'**
  String get userData;

  /// No description provided for @noMessageFound.
  ///
  /// In en, this message translates to:
  /// **'No message found'**
  String get noMessageFound;

  /// No description provided for @symbol.
  ///
  /// In en, this message translates to:
  /// **'Symbol'**
  String get symbol;

  /// No description provided for @decimalDigits.
  ///
  /// In en, this message translates to:
  /// **'Decimal Digits'**
  String get decimalDigits;

  /// No description provided for @symbolBeforeTheNumber.
  ///
  /// In en, this message translates to:
  /// **'Symbol Before the Number'**
  String get symbolBeforeTheNumber;

  /// No description provided for @currency.
  ///
  /// In en, this message translates to:
  /// **'Currency'**
  String get currency;

  /// No description provided for @intent.
  ///
  /// In en, this message translates to:
  /// **'Intent'**
  String get intent;

  /// No description provided for @sale.
  ///
  /// In en, this message translates to:
  /// **'Sale'**
  String get sale;

  /// No description provided for @payer.
  ///
  /// In en, this message translates to:
  /// **'Payer'**
  String get payer;

  /// No description provided for @paymentMethod.
  ///
  /// In en, this message translates to:
  /// **'Payment Method'**
  String get paymentMethod;

  /// No description provided for @paypal.
  ///
  /// In en, this message translates to:
  /// **'PayPal'**
  String get paypal;

  /// No description provided for @transactions.
  ///
  /// In en, this message translates to:
  /// **'Transactions'**
  String get transactions;

  /// No description provided for @details.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get details;

  /// No description provided for @subtotal.
  ///
  /// In en, this message translates to:
  /// **'Subtotal'**
  String get subtotal;

  /// No description provided for @shipping.
  ///
  /// In en, this message translates to:
  /// **'Shipping'**
  String get shipping;

  /// No description provided for @shippingDiscount.
  ///
  /// In en, this message translates to:
  /// **'Shipping Discount'**
  String get shippingDiscount;

  /// No description provided for @thePaymentTransactionDescription.
  ///
  /// In en, this message translates to:
  /// **'The payment transaction description.'**
  String get thePaymentTransactionDescription;

  /// No description provided for @paymentOptions.
  ///
  /// In en, this message translates to:
  /// **'Payment Options'**
  String get paymentOptions;

  /// No description provided for @allowedPaymentMethod.
  ///
  /// In en, this message translates to:
  /// **'Allowed Payment Method'**
  String get allowedPaymentMethod;

  /// No description provided for @instantFundingSource.
  ///
  /// In en, this message translates to:
  /// **'Instant Funding Source'**
  String get instantFundingSource;

  /// No description provided for @itemList.
  ///
  /// In en, this message translates to:
  /// **'Item List'**
  String get itemList;

  /// No description provided for @items.
  ///
  /// In en, this message translates to:
  /// **'Items'**
  String get items;

  /// No description provided for @shippingAddress.
  ///
  /// In en, this message translates to:
  /// **'Shipping Address'**
  String get shippingAddress;

  /// No description provided for @recipientName.
  ///
  /// In en, this message translates to:
  /// **'Recipient Name'**
  String get recipientName;

  /// No description provided for @line1.
  ///
  /// In en, this message translates to:
  /// **'Line 1'**
  String get line1;

  /// No description provided for @line2.
  ///
  /// In en, this message translates to:
  /// **'Line 2'**
  String get line2;

  /// No description provided for @noteToPayer.
  ///
  /// In en, this message translates to:
  /// **'Note to Payer'**
  String get noteToPayer;

  /// No description provided for @contactUsForAnyQuestionsOnYourOrder.
  ///
  /// In en, this message translates to:
  /// **'Contact us for any questions on your order.'**
  String get contactUsForAnyQuestionsOnYourOrder;

  /// No description provided for @redirectUrls.
  ///
  /// In en, this message translates to:
  /// **'Redirect URLs'**
  String get redirectUrls;

  /// No description provided for @returnUrl.
  ///
  /// In en, this message translates to:
  /// **'Return URL'**
  String get returnUrl;

  /// No description provided for @cancelUrl.
  ///
  /// In en, this message translates to:
  /// **'Cancel URL'**
  String get cancelUrl;

  /// No description provided for @collectionId.
  ///
  /// In en, this message translates to:
  /// **'Collection ID'**
  String get collectionId;

  /// No description provided for @qixerPayment.
  ///
  /// In en, this message translates to:
  /// **'Qixer Payment'**
  String get qixerPayment;

  /// No description provided for @reference1Label.
  ///
  /// In en, this message translates to:
  /// **'Reference 1 Label'**
  String get reference1Label;

  /// No description provided for @bankCode.
  ///
  /// In en, this message translates to:
  /// **'Bank Code'**
  String get bankCode;

  /// No description provided for @reference1.
  ///
  /// In en, this message translates to:
  /// **'Reference 1'**
  String get reference1;

  /// No description provided for @failed.
  ///
  /// In en, this message translates to:
  /// **'Failed'**
  String get failed;

  /// No description provided for @apiKey.
  ///
  /// In en, this message translates to:
  /// **'API Key'**
  String get apiKey;

  /// No description provided for @siteId.
  ///
  /// In en, this message translates to:
  /// **'Site ID'**
  String get siteId;

  /// No description provided for @alternativeCurrency.
  ///
  /// In en, this message translates to:
  /// **'Alternative Currency'**
  String get alternativeCurrency;

  /// No description provided for @customerId.
  ///
  /// In en, this message translates to:
  /// **'Customer ID'**
  String get customerId;

  /// No description provided for @firstName.
  ///
  /// In en, this message translates to:
  /// **'First Name'**
  String get firstName;

  /// No description provided for @customerSurname.
  ///
  /// In en, this message translates to:
  /// **'Customer Surname'**
  String get customerSurname;

  /// No description provided for @surname.
  ///
  /// In en, this message translates to:
  /// **'Surname'**
  String get surname;

  /// No description provided for @customerPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Customer Phone Number'**
  String get customerPhoneNumber;

  /// No description provided for @customerAddress.
  ///
  /// In en, this message translates to:
  /// **'Customer Address'**
  String get customerAddress;

  /// No description provided for @customerCity.
  ///
  /// In en, this message translates to:
  /// **'Customer City'**
  String get customerCity;

  /// No description provided for @dhaka.
  ///
  /// In en, this message translates to:
  /// **'Dhaka'**
  String get dhaka;

  /// No description provided for @customerCountry.
  ///
  /// In en, this message translates to:
  /// **'Customer Country'**
  String get customerCountry;

  /// No description provided for @bd.
  ///
  /// In en, this message translates to:
  /// **'BD'**
  String get bd;

  /// No description provided for @customerState.
  ///
  /// In en, this message translates to:
  /// **'Customer State'**
  String get customerState;

  /// No description provided for @customerZipCode.
  ///
  /// In en, this message translates to:
  /// **'Customer Zip Code'**
  String get customerZipCode;

  /// No description provided for @channels.
  ///
  /// In en, this message translates to:
  /// **'Channels'**
  String get channels;

  /// No description provided for @pay.
  ///
  /// In en, this message translates to:
  /// **'Pay'**
  String get pay;

  /// No description provided for @payment.
  ///
  /// In en, this message translates to:
  /// **'Payment'**
  String get payment;

  /// No description provided for @purpose.
  ///
  /// In en, this message translates to:
  /// **'Purpose'**
  String get purpose;

  /// No description provided for @qixerPay.
  ///
  /// In en, this message translates to:
  /// **'Qixer Pay'**
  String get qixerPay;

  /// No description provided for @allowRepeatedPayments.
  ///
  /// In en, this message translates to:
  /// **'Allow repeated payments'**
  String get allowRepeatedPayments;

  /// No description provided for @sendEmail.
  ///
  /// In en, this message translates to:
  /// **'Send Email'**
  String get sendEmail;

  /// No description provided for @sendSms.
  ///
  /// In en, this message translates to:
  /// **'Send SMS'**
  String get sendSms;

  /// No description provided for @redirectUrl.
  ///
  /// In en, this message translates to:
  /// **'Redirect URL'**
  String get redirectUrl;

  /// No description provided for @webhook.
  ///
  /// In en, this message translates to:
  /// **'Webhook'**
  String get webhook;

  /// No description provided for @shashaktNirman.
  ///
  /// In en, this message translates to:
  /// **'Shashakt Nirman'**
  String get shashaktNirman;

  /// No description provided for @shashaktNirmanPayment.
  ///
  /// In en, this message translates to:
  /// **'Shashakt Nirman Payment'**
  String get shashaktNirmanPayment;

  /// No description provided for @currencyId.
  ///
  /// In en, this message translates to:
  /// **'Currency ID'**
  String get currencyId;

  /// No description provided for @unitPrice.
  ///
  /// In en, this message translates to:
  /// **'Unit Price'**
  String get unitPrice;

  /// No description provided for @failure.
  ///
  /// In en, this message translates to:
  /// **'Failure'**
  String get failure;

  /// No description provided for @transactionDetails.
  ///
  /// In en, this message translates to:
  /// **'Transaction Details'**
  String get transactionDetails;

  /// No description provided for @grossAmount.
  ///
  /// In en, this message translates to:
  /// **'Gross Amount'**
  String get grossAmount;

  /// No description provided for @creditCard.
  ///
  /// In en, this message translates to:
  /// **'Credit Card'**
  String get creditCard;

  /// No description provided for @secure.
  ///
  /// In en, this message translates to:
  /// **'Secure'**
  String get secure;

  /// No description provided for @customerDetails.
  ///
  /// In en, this message translates to:
  /// **'Customer Details'**
  String get customerDetails;

  /// No description provided for @bearerPublicKey.
  ///
  /// In en, this message translates to:
  /// **'Bearer \$publicKey'**
  String get bearerPublicKey;

  /// No description provided for @webhookUrl.
  ///
  /// In en, this message translates to:
  /// **'Webhook URL'**
  String get webhookUrl;

  /// No description provided for @metadata.
  ///
  /// In en, this message translates to:
  /// **'Metadata'**
  String get metadata;

  /// No description provided for @method.
  ///
  /// In en, this message translates to:
  /// **'Method'**
  String get method;

  /// No description provided for @referenceId.
  ///
  /// In en, this message translates to:
  /// **'Reference ID'**
  String get referenceId;

  /// No description provided for @cancelAction.
  ///
  /// In en, this message translates to:
  /// **'Cancel Action'**
  String get cancelAction;

  /// No description provided for @profileId.
  ///
  /// In en, this message translates to:
  /// **'Profile ID'**
  String get profileId;

  /// No description provided for @tranType.
  ///
  /// In en, this message translates to:
  /// **'Transaction Type'**
  String get tranType;

  /// No description provided for @tranClass.
  ///
  /// In en, this message translates to:
  /// **'Transaction Class'**
  String get tranClass;

  /// No description provided for @ecom.
  ///
  /// In en, this message translates to:
  /// **'E-commerce'**
  String get ecom;

  /// No description provided for @cartId.
  ///
  /// In en, this message translates to:
  /// **'Cart ID'**
  String get cartId;

  /// No description provided for @cartDescription.
  ///
  /// In en, this message translates to:
  /// **'Cart Description'**
  String get cartDescription;

  /// No description provided for @cartCurrency.
  ///
  /// In en, this message translates to:
  /// **'Cart Currency'**
  String get cartCurrency;

  /// No description provided for @cartAmount.
  ///
  /// In en, this message translates to:
  /// **'Cart Amount'**
  String get cartAmount;

  /// No description provided for @amountToPay.
  ///
  /// In en, this message translates to:
  /// **'Amount to pay'**
  String get amountToPay;

  /// No description provided for @razorpay.
  ///
  /// In en, this message translates to:
  /// **'Razorpay'**
  String get razorpay;

  /// No description provided for @phoneNo.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneNo;

  /// No description provided for @payNow.
  ///
  /// In en, this message translates to:
  /// **'Pay Now'**
  String get payNow;

  /// No description provided for @idempotencyKey.
  ///
  /// In en, this message translates to:
  /// **'Idempotency Key'**
  String get idempotencyKey;

  /// No description provided for @quickPay.
  ///
  /// In en, this message translates to:
  /// **'Quick Pay'**
  String get quickPay;

  /// No description provided for @locationId.
  ///
  /// In en, this message translates to:
  /// **'Location ID'**
  String get locationId;

  /// No description provided for @priceMoney.
  ///
  /// In en, this message translates to:
  /// **'Price Money'**
  String get priceMoney;

  /// No description provided for @paymentNote.
  ///
  /// In en, this message translates to:
  /// **'Payment Note'**
  String get paymentNote;

  /// No description provided for @prePopulatedData.
  ///
  /// In en, this message translates to:
  /// **'Pre-populated Data'**
  String get prePopulatedData;

  /// No description provided for @buyerEmail.
  ///
  /// In en, this message translates to:
  /// **'Buyer Email'**
  String get buyerEmail;

  /// No description provided for @selectSubcategory.
  ///
  /// In en, this message translates to:
  /// **'Select Subcategory'**
  String get selectSubcategory;

  /// No description provided for @selectChildCategory.
  ///
  /// In en, this message translates to:
  /// **'Select Child Category'**
  String get selectChildCategory;

  /// No description provided for @clearFilter.
  ///
  /// In en, this message translates to:
  /// **'Clear Filter'**
  String get clearFilter;

  /// No description provided for @applyFilter.
  ///
  /// In en, this message translates to:
  /// **'Apply Filter'**
  String get applyFilter;

  /// No description provided for @sortBy.
  ///
  /// In en, this message translates to:
  /// **'Sort By'**
  String get sortBy;

  /// No description provided for @min.
  ///
  /// In en, this message translates to:
  /// **'Min'**
  String get min;

  /// No description provided for @max.
  ///
  /// In en, this message translates to:
  /// **'Max'**
  String get max;

  /// No description provided for @ratings.
  ///
  /// In en, this message translates to:
  /// **'Ratings'**
  String get ratings;

  /// No description provided for @pleaseProvideMaximumFilterPriceAmount.
  ///
  /// In en, this message translates to:
  /// **'Please provide maximum filter price amount'**
  String get pleaseProvideMaximumFilterPriceAmount;

  /// No description provided for @distance.
  ///
  /// In en, this message translates to:
  /// **'Distance'**
  String get distance;

  /// No description provided for @distanceKm.
  ///
  /// In en, this message translates to:
  /// **'distance km'**
  String get distanceKm;

  /// No description provided for @selectYourCityHere.
  ///
  /// In en, this message translates to:
  /// **'Select your city here'**
  String get selectYourCityHere;

  /// No description provided for @selectCity.
  ///
  /// In en, this message translates to:
  /// **'Select City'**
  String get selectCity;

  /// No description provided for @filter.
  ///
  /// In en, this message translates to:
  /// **'Filter'**
  String get filter;

  /// No description provided for @reset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get reset;

  /// No description provided for @refresh.
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get refresh;

  /// No description provided for @noResultsFound.
  ///
  /// In en, this message translates to:
  /// **'No results found'**
  String get noResultsFound;

  /// No description provided for @tenYr.
  ///
  /// In en, this message translates to:
  /// **'10 Year'**
  String get tenYr;

  /// No description provided for @carWashingAndCleaningServiceAtHomeOrOffice.
  ///
  /// In en, this message translates to:
  /// **'Car washing and cleaning service at home or office'**
  String get carWashingAndCleaningServiceAtHomeOrOffice;

  /// No description provided for @testSeller.
  ///
  /// In en, this message translates to:
  /// **'Test Seller'**
  String get testSeller;

  /// No description provided for @threePointEight.
  ///
  /// In en, this message translates to:
  /// **'3.8'**
  String get threePointEight;

  /// No description provided for @latestService.
  ///
  /// In en, this message translates to:
  /// **'Latest Service'**
  String get latestService;

  /// No description provided for @lowestPrice.
  ///
  /// In en, this message translates to:
  /// **'Lowest Price'**
  String get lowestPrice;

  /// No description provided for @highestPrice.
  ///
  /// In en, this message translates to:
  /// **'Highest Price'**
  String get highestPrice;

  /// No description provided for @bestSelling.
  ///
  /// In en, this message translates to:
  /// **'Best Selling'**
  String get bestSelling;

  /// No description provided for @bestSellingService.
  ///
  /// In en, this message translates to:
  /// **'Best Selling Service'**
  String get bestSellingService;

  /// No description provided for @popular.
  ///
  /// In en, this message translates to:
  /// **'Popular'**
  String get popular;

  /// No description provided for @popularService.
  ///
  /// In en, this message translates to:
  /// **'Popular Service'**
  String get popularService;

  /// No description provided for @featuredService.
  ///
  /// In en, this message translates to:
  /// **'Featured Service'**
  String get featuredService;

  /// No description provided for @selectYourRole.
  ///
  /// In en, this message translates to:
  /// **'Select Your Role'**
  String get selectYourRole;

  /// No description provided for @tellUsWhoYouAreToGetStarted.
  ///
  /// In en, this message translates to:
  /// **'Tell us who you are to get started'**
  String get tellUsWhoYouAreToGetStarted;

  /// No description provided for @customer.
  ///
  /// In en, this message translates to:
  /// **'Customer'**
  String get customer;

  /// No description provided for @customerText.
  ///
  /// In en, this message translates to:
  /// **'Customer/\nBuyer'**
  String get customerText;

  /// No description provided for @lookingForServices.
  ///
  /// In en, this message translates to:
  /// **'Looking for Services'**
  String get lookingForServices;

  /// No description provided for @offeringServices.
  ///
  /// In en, this message translates to:
  /// **'Offering Services'**
  String get offeringServices;

  /// No description provided for @roleSelection.
  ///
  /// In en, this message translates to:
  /// **'Role Selection'**
  String get roleSelection;

  /// No description provided for @noResultFound.
  ///
  /// In en, this message translates to:
  /// **'No result found'**
  String get noResultFound;

  /// No description provided for @en.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get en;

  /// No description provided for @container.
  ///
  /// In en, this message translates to:
  /// **'Container'**
  String get container;

  /// No description provided for @section.
  ///
  /// In en, this message translates to:
  /// **'Section'**
  String get section;

  /// No description provided for @companyOverview.
  ///
  /// In en, this message translates to:
  /// **'Company Overview'**
  String get companyOverview;

  /// No description provided for @teamInfo.
  ///
  /// In en, this message translates to:
  /// **'Team Info'**
  String get teamInfo;

  /// No description provided for @teamMember.
  ///
  /// In en, this message translates to:
  /// **'Team Member'**
  String get teamMember;

  /// No description provided for @achievements.
  ///
  /// In en, this message translates to:
  /// **'Achievements'**
  String get achievements;

  /// No description provided for @achievement.
  ///
  /// In en, this message translates to:
  /// **'Achievement'**
  String get achievement;

  /// No description provided for @contactInfo.
  ///
  /// In en, this message translates to:
  /// **'Contact Info'**
  String get contactInfo;

  /// No description provided for @blank.
  ///
  /// In en, this message translates to:
  /// **'Blank'**
  String get blank;

  /// No description provided for @keyFeature.
  ///
  /// In en, this message translates to:
  /// **'Key Feature'**
  String get keyFeature;

  /// No description provided for @availability.
  ///
  /// In en, this message translates to:
  /// **'Availability'**
  String get availability;

  /// No description provided for @officeAddress.
  ///
  /// In en, this message translates to:
  /// **'Office Address'**
  String get officeAddress;

  /// No description provided for @workType.
  ///
  /// In en, this message translates to:
  /// **'Work Type:'**
  String get workType;

  /// No description provided for @unisexSalon.
  ///
  /// In en, this message translates to:
  /// **'Unisex Salon'**
  String get unisexSalon;

  /// No description provided for @fivePlusYearExperienceInBusiness.
  ///
  /// In en, this message translates to:
  /// **'5+ Year Experience in Business'**
  String get fivePlusYearExperienceInBusiness;

  /// No description provided for @tapToKnowMore.
  ///
  /// In en, this message translates to:
  /// **'Tap to know more'**
  String get tapToKnowMore;

  /// No description provided for @available.
  ///
  /// In en, this message translates to:
  /// **'Available'**
  String get available;

  /// No description provided for @unAvailable.
  ///
  /// In en, this message translates to:
  /// **'UnAvailable'**
  String get unAvailable;

  /// No description provided for @openingDaysAndHours.
  ///
  /// In en, this message translates to:
  /// **'Opening Days and Hours'**
  String get openingDaysAndHours;

  /// No description provided for @subCategory.
  ///
  /// In en, this message translates to:
  /// **'Subcategory'**
  String get subCategory;

  /// No description provided for @star.
  ///
  /// In en, this message translates to:
  /// **'Star'**
  String get star;

  /// No description provided for @noServiceAvailable.
  ///
  /// In en, this message translates to:
  /// **'No Service Available'**
  String get noServiceAvailable;

  /// No description provided for @pageAutoLoading.
  ///
  /// In en, this message translates to:
  /// **'Page Auto Loading'**
  String get pageAutoLoading;

  /// No description provided for @enquiryNow.
  ///
  /// In en, this message translates to:
  /// **'Enquiry Now'**
  String get enquiryNow;

  /// No description provided for @newLead.
  ///
  /// In en, this message translates to:
  /// **'New Lead'**
  String get newLead;

  /// No description provided for @read.
  ///
  /// In en, this message translates to:
  /// **'Read'**
  String get read;

  /// No description provided for @remarks.
  ///
  /// In en, this message translates to:
  /// **'Remarks'**
  String get remarks;

  /// No description provided for @twelveHr.
  ///
  /// In en, this message translates to:
  /// **'12 Hour'**
  String get twelveHr;

  /// No description provided for @showDetails.
  ///
  /// In en, this message translates to:
  /// **'Show Details'**
  String get showDetails;

  /// No description provided for @allLeads.
  ///
  /// In en, this message translates to:
  /// **'All Leads'**
  String get allLeads;

  /// No description provided for @highPriority.
  ///
  /// In en, this message translates to:
  /// **'High Priority'**
  String get highPriority;

  /// No description provided for @recentLeads.
  ///
  /// In en, this message translates to:
  /// **'Recent Leads'**
  String get recentLeads;

  /// No description provided for @missedOpportunities.
  ///
  /// In en, this message translates to:
  /// **'Missed Opportunities'**
  String get missedOpportunities;

  /// No description provided for @activeLeads.
  ///
  /// In en, this message translates to:
  /// **'Active Leads'**
  String get activeLeads;

  /// No description provided for @openedLeads.
  ///
  /// In en, this message translates to:
  /// **'Opened Leads'**
  String get openedLeads;

  /// No description provided for @homeSide.
  ///
  /// In en, this message translates to:
  /// **'Home Side'**
  String get homeSide;

  /// No description provided for @bookmarked.
  ///
  /// In en, this message translates to:
  /// **'Bookmarked'**
  String get bookmarked;

  /// No description provided for @moreFilter.
  ///
  /// In en, this message translates to:
  /// **'More Filter'**
  String get moreFilter;

  /// No description provided for @rajeshKumarThawait.
  ///
  /// In en, this message translates to:
  /// **'Rajesh Kumar Thawait'**
  String get rajeshKumarThawait;

  /// No description provided for @websiteDevelopmentForSchool.
  ///
  /// In en, this message translates to:
  /// **'Website Development for School'**
  String get websiteDevelopmentForSchool;

  /// No description provided for @calling.
  ///
  /// In en, this message translates to:
  /// **'Calling'**
  String get calling;

  /// No description provided for @addRemarks.
  ///
  /// In en, this message translates to:
  /// **'Add Remarks'**
  String get addRemarks;

  /// No description provided for @yourRemarks.
  ///
  /// In en, this message translates to:
  /// **'Your Remarks'**
  String get yourRemarks;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @clear.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get clear;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @searchHere.
  ///
  /// In en, this message translates to:
  /// **'Search Here'**
  String get searchHere;

  /// No description provided for @myLeads.
  ///
  /// In en, this message translates to:
  /// **'My Leads'**
  String get myLeads;

  /// No description provided for @callNow.
  ///
  /// In en, this message translates to:
  /// **'Call Now'**
  String get callNow;

  /// No description provided for @whatsapp.
  ///
  /// In en, this message translates to:
  /// **'Whatsapp'**
  String get whatsapp;

  /// No description provided for @priorityLeads.
  ///
  /// In en, this message translates to:
  /// **'Priority Leads'**
  String get priorityLeads;

  /// No description provided for @noLeadsGeneratedForYouNow.
  ///
  /// In en, this message translates to:
  /// **'No leads generated for you now'**
  String get noLeadsGeneratedForYouNow;

  /// No description provided for @kerawallaMansionAboveCityWalkShoesTilakMargMumbai.
  ///
  /// In en, this message translates to:
  /// **'Kerawalla Mansion, Above City Walk Shoes, Tilak Marg, Mumbai'**
  String get kerawallaMansionAboveCityWalkShoesTilakMargMumbai;

  /// No description provided for @cashOnDelivery.
  ///
  /// In en, this message translates to:
  /// **'Cash on Delivery'**
  String get cashOnDelivery;

  /// No description provided for @manualPayment.
  ///
  /// In en, this message translates to:
  /// **'Manual Payment'**
  String get manualPayment;

  /// No description provided for @declineReason.
  ///
  /// In en, this message translates to:
  /// **'Decline Reason'**
  String get declineReason;

  /// No description provided for @decline.
  ///
  /// In en, this message translates to:
  /// **'Decline'**
  String get decline;

  /// No description provided for @declined.
  ///
  /// In en, this message translates to:
  /// **'Declined'**
  String get declined;

  /// No description provided for @noDateFound.
  ///
  /// In en, this message translates to:
  /// **'No date found'**
  String get noDateFound;

  /// No description provided for @selectStatus.
  ///
  /// In en, this message translates to:
  /// **'Select Status'**
  String get selectStatus;

  /// No description provided for @noActiveOrder.
  ///
  /// In en, this message translates to:
  /// **'No active order'**
  String get noActiveOrder;

  /// No description provided for @noServiceSaved.
  ///
  /// In en, this message translates to:
  /// **'No service saved'**
  String get noServiceSaved;

  /// No description provided for @map.
  ///
  /// In en, this message translates to:
  /// **'Map'**
  String get map;

  /// No description provided for @personalInformations.
  ///
  /// In en, this message translates to:
  /// **'Personal Information\'s'**
  String get personalInformations;

  /// No description provided for @menuTab.
  ///
  /// In en, this message translates to:
  /// **'Menu Tab'**
  String get menuTab;

  /// No description provided for @myJobs.
  ///
  /// In en, this message translates to:
  /// **'My Jobs'**
  String get myJobs;

  /// No description provided for @jobRequests.
  ///
  /// In en, this message translates to:
  /// **'Job Requests'**
  String get jobRequests;

  /// No description provided for @supportTicket.
  ///
  /// In en, this message translates to:
  /// **'Support Ticket'**
  String get supportTicket;

  /// No description provided for @myReportList.
  ///
  /// In en, this message translates to:
  /// **'My Report List'**
  String get myReportList;

  /// No description provided for @editProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get editProfile;

  /// No description provided for @successfullyUpdated.
  ///
  /// In en, this message translates to:
  /// **'Successfully Updated'**
  String get successfullyUpdated;

  /// No description provided for @editBusinessProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit Business Profile'**
  String get editBusinessProfile;

  /// No description provided for @changePassword.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get changePassword;

  /// No description provided for @deleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get deleteAccount;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @passwordChangeUnavailableWeAreSorry.
  ///
  /// In en, this message translates to:
  /// **'Password change unavailable. We\'re sorry'**
  String get passwordChangeUnavailableWeAreSorry;

  /// No description provided for @enterCurrentPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter Current Password'**
  String get enterCurrentPassword;

  /// No description provided for @enterYourCurrentPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter your current password'**
  String get enterYourCurrentPassword;

  /// No description provided for @enterNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter New Password'**
  String get enterNewPassword;

  /// No description provided for @es.
  ///
  /// In en, this message translates to:
  /// **'ES'**
  String get es;

  /// No description provided for @ticketTitle.
  ///
  /// In en, this message translates to:
  /// **'Ticket Title'**
  String get ticketTitle;

  /// No description provided for @youDontHaveAnyActiveOrder.
  ///
  /// In en, this message translates to:
  /// **'You don\'t have any active order'**
  String get youDontHaveAnyActiveOrder;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get welcome;

  /// No description provided for @browseCategories.
  ///
  /// In en, this message translates to:
  /// **'Browse Categories'**
  String get browseCategories;

  /// No description provided for @allCategories.
  ///
  /// In en, this message translates to:
  /// **'All Categories'**
  String get allCategories;

  /// No description provided for @recentlyListed.
  ///
  /// In en, this message translates to:
  /// **'Recently Listed'**
  String get recentlyListed;

  /// No description provided for @featuredServices.
  ///
  /// In en, this message translates to:
  /// **'Featured Services'**
  String get featuredServices;

  /// No description provided for @seeAll.
  ///
  /// In en, this message translates to:
  /// **'See All'**
  String get seeAll;

  /// No description provided for @orders.
  ///
  /// In en, this message translates to:
  /// **'Orders'**
  String get orders;

  /// No description provided for @saved.
  ///
  /// In en, this message translates to:
  /// **'Saved'**
  String get saved;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @billed.
  ///
  /// In en, this message translates to:
  /// **'Billed'**
  String get billed;

  /// No description provided for @dateAndSchedule.
  ///
  /// In en, this message translates to:
  /// **'Date and Schedule'**
  String get dateAndSchedule;

  /// No description provided for @amountDetails.
  ///
  /// In en, this message translates to:
  /// **'Amount Details'**
  String get amountDetails;

  /// No description provided for @orderStatus.
  ///
  /// In en, this message translates to:
  /// **'Order Status'**
  String get orderStatus;

  /// No description provided for @savedServices.
  ///
  /// In en, this message translates to:
  /// **'Saved Services'**
  String get savedServices;

  /// No description provided for @startsFrom.
  ///
  /// In en, this message translates to:
  /// **'Starts From'**
  String get startsFrom;

  /// No description provided for @pendingOrders.
  ///
  /// In en, this message translates to:
  /// **'Pending Orders'**
  String get pendingOrders;

  /// No description provided for @activeOrders.
  ///
  /// In en, this message translates to:
  /// **'Active Orders'**
  String get activeOrders;

  /// No description provided for @completedOrders.
  ///
  /// In en, this message translates to:
  /// **'Completed Orders'**
  String get completedOrders;

  /// No description provided for @totalOrders.
  ///
  /// In en, this message translates to:
  /// **'Total Orders'**
  String get totalOrders;

  /// No description provided for @create.
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get create;

  /// No description provided for @noTicket.
  ///
  /// In en, this message translates to:
  /// **'No Ticket'**
  String get noTicket;

  /// No description provided for @yourAddress.
  ///
  /// In en, this message translates to:
  /// **'Your Address'**
  String get yourAddress;

  /// No description provided for @ourPackage.
  ///
  /// In en, this message translates to:
  /// **'Our Package'**
  String get ourPackage;

  /// No description provided for @ordersCompleted.
  ///
  /// In en, this message translates to:
  /// **'Orders Completed'**
  String get ordersCompleted;

  /// No description provided for @sellerRatings.
  ///
  /// In en, this message translates to:
  /// **'Seller Ratings'**
  String get sellerRatings;

  /// No description provided for @overview.
  ///
  /// In en, this message translates to:
  /// **'Overview'**
  String get overview;

  /// No description provided for @aboutSeller.
  ///
  /// In en, this message translates to:
  /// **'About Seller'**
  String get aboutSeller;

  /// No description provided for @aboutContractor.
  ///
  /// In en, this message translates to:
  /// **'About Contractor/About Vendor'**
  String get aboutContractor;

  /// No description provided for @review.
  ///
  /// In en, this message translates to:
  /// **'Review'**
  String get review;

  /// No description provided for @membershipPlan.
  ///
  /// In en, this message translates to:
  /// **'Membership Plan'**
  String get membershipPlan;

  /// No description provided for @priceChart.
  ///
  /// In en, this message translates to:
  /// **'Price Chart'**
  String get priceChart;

  /// No description provided for @benefitsOfPremiumPackage.
  ///
  /// In en, this message translates to:
  /// **'Benefits of Premium Package'**
  String get benefitsOfPremiumPackage;

  /// No description provided for @benefitsOfThePremiumPackage.
  ///
  /// In en, this message translates to:
  /// **'Benefits of the Premium Package'**
  String get benefitsOfThePremiumPackage;

  /// No description provided for @faq.
  ///
  /// In en, this message translates to:
  /// **'FAQ'**
  String get faq;

  /// No description provided for @bookAppointment.
  ///
  /// In en, this message translates to:
  /// **'Book Appointment'**
  String get bookAppointment;

  /// No description provided for @personalize.
  ///
  /// In en, this message translates to:
  /// **'Personalize'**
  String get personalize;

  /// No description provided for @whatsIncluded.
  ///
  /// In en, this message translates to:
  /// **'What\'s Included'**
  String get whatsIncluded;

  /// No description provided for @addExtras.
  ///
  /// In en, this message translates to:
  /// **'Add Extras'**
  String get addExtras;

  /// No description provided for @benefitsOfThePackage.
  ///
  /// In en, this message translates to:
  /// **'Benefits of the Package'**
  String get benefitsOfThePackage;

  /// No description provided for @availableTime.
  ///
  /// In en, this message translates to:
  /// **'Available Time'**
  String get availableTime;

  /// No description provided for @noScheduleAvailableOnThisDate.
  ///
  /// In en, this message translates to:
  /// **'No schedule available on this date'**
  String get noScheduleAvailableOnThisDate;

  /// No description provided for @bookingConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Booking Confirmation'**
  String get bookingConfirmation;

  /// No description provided for @bookingDetails.
  ///
  /// In en, this message translates to:
  /// **'Booking Details'**
  String get bookingDetails;

  /// No description provided for @swipeUpForDetails.
  ///
  /// In en, this message translates to:
  /// **'Swipe up for details'**
  String get swipeUpForDetails;

  /// No description provided for @proceedToPayment.
  ///
  /// In en, this message translates to:
  /// **'Proceed to Payment'**
  String get proceedToPayment;

  /// No description provided for @collapseDetails.
  ///
  /// In en, this message translates to:
  /// **'Collapse Details'**
  String get collapseDetails;

  /// No description provided for @appointmentPackageService.
  ///
  /// In en, this message translates to:
  /// **'Appointment Package Service'**
  String get appointmentPackageService;

  /// No description provided for @extraServiceFee.
  ///
  /// In en, this message translates to:
  /// **'Extra Service Fee'**
  String get extraServiceFee;

  /// No description provided for @coupon.
  ///
  /// In en, this message translates to:
  /// **'Coupon'**
  String get coupon;

  /// No description provided for @enterCouponCode.
  ///
  /// In en, this message translates to:
  /// **'Enter Coupon Code'**
  String get enterCouponCode;

  /// No description provided for @apply.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get apply;

  /// No description provided for @totalPayable.
  ///
  /// In en, this message translates to:
  /// **'Total Payable'**
  String get totalPayable;

  /// No description provided for @choosePaymentMethod.
  ///
  /// In en, this message translates to:
  /// **'Choose Payment Method'**
  String get choosePaymentMethod;

  /// No description provided for @chooseImages.
  ///
  /// In en, this message translates to:
  /// **'Choose Images'**
  String get chooseImages;

  /// No description provided for @iAgreeWithTheTermsAndConditions.
  ///
  /// In en, this message translates to:
  /// **'I agree with the terms and conditions'**
  String get iAgreeWithTheTermsAndConditions;

  /// No description provided for @payAndConfirmOrder.
  ///
  /// In en, this message translates to:
  /// **'Pay and Confirm Order'**
  String get payAndConfirmOrder;

  /// No description provided for @paymentSuccessful.
  ///
  /// In en, this message translates to:
  /// **'Payment Successful'**
  String get paymentSuccessful;

  /// No description provided for @areYouSure.
  ///
  /// In en, this message translates to:
  /// **'Are you sure?'**
  String get areYouSure;

  /// No description provided for @deleteDialogueText.
  ///
  /// In en, this message translates to:
  /// **'Are you sure? Do you want to permanently delete your service?'**
  String get deleteDialogueText;

  /// No description provided for @welcomeBackLogin.
  ///
  /// In en, this message translates to:
  /// **'Welcome back! Login'**
  String get welcomeBackLogin;

  /// No description provided for @doNotHaveAnAccount.
  ///
  /// In en, this message translates to:
  /// **'Do not have an account?'**
  String get doNotHaveAnAccount;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// No description provided for @registerToJoinUs.
  ///
  /// In en, this message translates to:
  /// **'Register to join us'**
  String get registerToJoinUs;

  /// No description provided for @alreadyHaveAnAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get alreadyHaveAnAccount;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneNumber;

  /// No description provided for @didNotReceive.
  ///
  /// In en, this message translates to:
  /// **'Did not receive'**
  String get didNotReceive;

  /// No description provided for @pleaseWaitWhileTheProfileIsUpdating.
  ///
  /// In en, this message translates to:
  /// **'Please wait while the profile is updating'**
  String get pleaseWaitWhileTheProfileIsUpdating;

  /// No description provided for @pleaseEnterPostCode.
  ///
  /// In en, this message translates to:
  /// **'Please enter post code'**
  String get pleaseEnterPostCode;

  /// No description provided for @addressFieldIsRequired.
  ///
  /// In en, this message translates to:
  /// **'Address field is required'**
  String get addressFieldIsRequired;

  /// No description provided for @phoneFieldIsRequired.
  ///
  /// In en, this message translates to:
  /// **'Phone field is required'**
  String get phoneFieldIsRequired;

  /// No description provided for @updatingProfileItMayTakeFewSeconds.
  ///
  /// In en, this message translates to:
  /// **'Updating profile... it may take few seconds'**
  String get updatingProfileItMayTakeFewSeconds;

  /// No description provided for @haveAnAccount.
  ///
  /// In en, this message translates to:
  /// **'Have an account?'**
  String get haveAnAccount;

  /// No description provided for @pleaseEnterYourPassword.
  ///
  /// In en, this message translates to:
  /// **'Please enter your password'**
  String get pleaseEnterYourPassword;

  /// No description provided for @repeatNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Repeat New Password'**
  String get repeatNewPassword;

  /// No description provided for @pleaseRetypeNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Please retype new password'**
  String get pleaseRetypeNewPassword;

  /// No description provided for @makeSureYouRepeatedNewPasswordCorrectly.
  ///
  /// In en, this message translates to:
  /// **'Make sure you repeated new password correctly'**
  String get makeSureYouRepeatedNewPasswordCorrectly;

  /// No description provided for @yourEnteredTheOtpCorrectlyButSomethingWentWrongPleaseTryAgainLater.
  ///
  /// In en, this message translates to:
  /// **'You entered the OTP correctly but something went wrong. Please try again later'**
  String get yourEnteredTheOtpCorrectlyButSomethingWentWrongPleaseTryAgainLater;

  /// No description provided for @otpIsNull.
  ///
  /// In en, this message translates to:
  /// **'OTP is null'**
  String get otpIsNull;

  /// No description provided for @youAlreadyAppliedThisCoupon.
  ///
  /// In en, this message translates to:
  /// **'You already applied this coupon'**
  String get youAlreadyAppliedThisCoupon;

  /// No description provided for @pleaseEnterAValidCoupon.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid coupon'**
  String get pleaseEnterAValidCoupon;

  /// No description provided for @orderPlacedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Order placed successfully'**
  String get orderPlacedSuccessfully;

  /// No description provided for @failedToMakePaymentStatusSuccessful.
  ///
  /// In en, this message translates to:
  /// **'Failed to make payment status successful'**
  String get failedToMakePaymentStatusSuccessful;

  /// No description provided for @checkYourInternetConnectionAndTryAgain.
  ///
  /// In en, this message translates to:
  /// **'Check your internet connection and try again'**
  String get checkYourInternetConnectionAndTryAgain;

  /// No description provided for @youMustSelectAnImage.
  ///
  /// In en, this message translates to:
  /// **'You must select an image'**
  String get youMustSelectAnImage;

  /// No description provided for @youMustSelectCategoryAndSubcategory.
  ///
  /// In en, this message translates to:
  /// **'You must select category and subcategory'**
  String get youMustSelectCategoryAndSubcategory;

  /// No description provided for @jobPostedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Job posted successfully'**
  String get jobPostedSuccessfully;

  /// No description provided for @jobUpdatedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Job updated successfully'**
  String get jobUpdatedSuccessfully;

  /// No description provided for @onlyZipFileIsSupported.
  ///
  /// In en, this message translates to:
  /// **'Only zip file is supported'**
  String get onlyZipFileIsSupported;

  /// No description provided for @pleaseCheckYourInternetConnection.
  ///
  /// In en, this message translates to:
  /// **'Please check your internet connection'**
  String get pleaseCheckYourInternetConnection;

  /// No description provided for @hiringSuccessful.
  ///
  /// In en, this message translates to:
  /// **'Hiring successful'**
  String get hiringSuccessful;

  /// No description provided for @jobDeletedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Job deleted successfully'**
  String get jobDeletedSuccessfully;

  /// No description provided for @selectCountry.
  ///
  /// In en, this message translates to:
  /// **'Select Country'**
  String get selectCountry;

  /// No description provided for @selectState.
  ///
  /// In en, this message translates to:
  /// **'Select State'**
  String get selectState;

  /// No description provided for @reviewPostedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Review posted successfully'**
  String get reviewPostedSuccessfully;

  /// No description provided for @reportSubmitted.
  ///
  /// In en, this message translates to:
  /// **'Report submitted'**
  String get reportSubmitted;

  /// No description provided for @errorAcceptingOrderExtra.
  ///
  /// In en, this message translates to:
  /// **'Error accepting order extra'**
  String get errorAcceptingOrderExtra;

  /// No description provided for @errorDecliningOrderExtra.
  ///
  /// In en, this message translates to:
  /// **'Error declining order extra'**
  String get errorDecliningOrderExtra;

  /// No description provided for @profileUpdatedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Profile updated successfully'**
  String get profileUpdatedSuccessfully;

  /// No description provided for @walletDepositSuccess.
  ///
  /// In en, this message translates to:
  /// **'Wallet deposit success'**
  String get walletDepositSuccess;

  /// No description provided for @youMustEnterAnAmount.
  ///
  /// In en, this message translates to:
  /// **'You must enter an amount'**
  String get youMustEnterAnAmount;

  /// No description provided for @pleaseEnterAValidAmount.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid amount'**
  String get pleaseEnterAValidAmount;

  /// No description provided for @ticketCreatedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Ticket created successfully'**
  String get ticketCreatedSuccessfully;

  /// No description provided for @createJob.
  ///
  /// In en, this message translates to:
  /// **'Create Job'**
  String get createJob;

  /// No description provided for @pleaseEnterATitle.
  ///
  /// In en, this message translates to:
  /// **'Please enter a title'**
  String get pleaseEnterATitle;

  /// No description provided for @pleaseEnterYourBudget.
  ///
  /// In en, this message translates to:
  /// **'Please enter your budget'**
  String get pleaseEnterYourBudget;

  /// No description provided for @youMustEnterAValidBudget.
  ///
  /// In en, this message translates to:
  /// **'You must enter a valid budget'**
  String get youMustEnterAValidBudget;

  /// No description provided for @viewDetails.
  ///
  /// In en, this message translates to:
  /// **'View Details'**
  String get viewDetails;

  /// No description provided for @conversation.
  ///
  /// In en, this message translates to:
  /// **'Conversation'**
  String get conversation;

  /// No description provided for @hireNow.
  ///
  /// In en, this message translates to:
  /// **'Hire Now'**
  String get hireNow;

  /// No description provided for @sellerOffer.
  ///
  /// In en, this message translates to:
  /// **'Seller Offer'**
  String get sellerOffer;

  /// No description provided for @noRequestFound.
  ///
  /// In en, this message translates to:
  /// **'No request found'**
  String get noRequestFound;

  /// No description provided for @balance.
  ///
  /// In en, this message translates to:
  /// **'Balance'**
  String get balance;

  /// No description provided for @gateway.
  ///
  /// In en, this message translates to:
  /// **'Gateway'**
  String get gateway;

  /// No description provided for @youMustAgreeWithTheTermsAndConditionsToPlaceTheOrder.
  ///
  /// In en, this message translates to:
  /// **'You must agree with the terms and conditions to place the order'**
  String get youMustAgreeWithTheTermsAndConditionsToPlaceTheOrder;

  /// No description provided for @payAndConfirm.
  ///
  /// In en, this message translates to:
  /// **'Pay and Confirm'**
  String get payAndConfirm;

  /// No description provided for @iAgreeWithTermsAndConditions.
  ///
  /// In en, this message translates to:
  /// **'I agree with terms and conditions'**
  String get iAgreeWithTermsAndConditions;

  /// No description provided for @reports.
  ///
  /// In en, this message translates to:
  /// **'Reports'**
  String get reports;

  /// No description provided for @noReport.
  ///
  /// In en, this message translates to:
  /// **'No report'**
  String get noReport;

  /// No description provided for @pleaseWriteAMessageFirst.
  ///
  /// In en, this message translates to:
  /// **'Please write a message first'**
  String get pleaseWriteAMessageFirst;

  /// No description provided for @pleaseEnterYourFullName.
  ///
  /// In en, this message translates to:
  /// **'Please enter your full name'**
  String get pleaseEnterYourFullName;

  /// No description provided for @pleaseEnterYourUsername.
  ///
  /// In en, this message translates to:
  /// **'Please enter your username'**
  String get pleaseEnterYourUsername;

  /// No description provided for @enterPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter Phone Number'**
  String get enterPhoneNumber;

  /// No description provided for @bookNow.
  ///
  /// In en, this message translates to:
  /// **'Book Now'**
  String get bookNow;

  /// No description provided for @exploreNow.
  ///
  /// In en, this message translates to:
  /// **'Explore Now'**
  String get exploreNow;

  /// No description provided for @recentJobs.
  ///
  /// In en, this message translates to:
  /// **'Recent Jobs'**
  String get recentJobs;

  /// No description provided for @topBookedServices.
  ///
  /// In en, this message translates to:
  /// **'Top Booked Services'**
  String get topBookedServices;

  /// No description provided for @orderCompleted.
  ///
  /// In en, this message translates to:
  /// **'Order Completed'**
  String get orderCompleted;

  /// No description provided for @watchVideo.
  ///
  /// In en, this message translates to:
  /// **'Watch Video'**
  String get watchVideo;

  /// No description provided for @bookingInformation.
  ///
  /// In en, this message translates to:
  /// **'Booking Information'**
  String get bookingInformation;

  /// No description provided for @youCannotCancelThisOrder.
  ///
  /// In en, this message translates to:
  /// **'You cannot cancel this order'**
  String get youCannotCancelThisOrder;

  /// No description provided for @leaveFeedback.
  ///
  /// In en, this message translates to:
  /// **'Leave Feedback'**
  String get leaveFeedback;

  /// No description provided for @cancelOrder.
  ///
  /// In en, this message translates to:
  /// **'Cancel Order'**
  String get cancelOrder;

  /// No description provided for @reportToAdmin.
  ///
  /// In en, this message translates to:
  /// **'Report to Admin'**
  String get reportToAdmin;

  /// No description provided for @orderDetails.
  ///
  /// In en, this message translates to:
  /// **'Order Details'**
  String get orderDetails;

  /// No description provided for @paymentFailed.
  ///
  /// In en, this message translates to:
  /// **'Payment Failed!'**
  String get paymentFailed;

  /// No description provided for @goToHome.
  ///
  /// In en, this message translates to:
  /// **'Go to Home'**
  String get goToHome;

  /// No description provided for @unknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get unknown;

  /// No description provided for @declineHistory.
  ///
  /// In en, this message translates to:
  /// **'Decline History'**
  String get declineHistory;

  /// No description provided for @buyerDetails.
  ///
  /// In en, this message translates to:
  /// **'Buyer Details'**
  String get buyerDetails;

  /// No description provided for @completeRequest.
  ///
  /// In en, this message translates to:
  /// **'Complete Request'**
  String get completeRequest;

  /// No description provided for @sellerRequestedToMarkThisOrderComplete.
  ///
  /// In en, this message translates to:
  /// **'Seller requested to mark this order complete'**
  String get sellerRequestedToMarkThisOrderComplete;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @onOff.
  ///
  /// In en, this message translates to:
  /// **'On/Off'**
  String get onOff;

  /// No description provided for @urgent.
  ///
  /// In en, this message translates to:
  /// **'Urgent'**
  String get urgent;

  /// No description provided for @high.
  ///
  /// In en, this message translates to:
  /// **'High'**
  String get high;

  /// No description provided for @medium.
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get medium;

  /// No description provided for @low.
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get low;

  /// No description provided for @pleaseEnterTicketTitle.
  ///
  /// In en, this message translates to:
  /// **'Please enter ticket title'**
  String get pleaseEnterTicketTitle;

  /// No description provided for @createTicket.
  ///
  /// In en, this message translates to:
  /// **'Create Ticket'**
  String get createTicket;

  /// No description provided for @alreadyHiredASellerForThisJob.
  ///
  /// In en, this message translates to:
  /// **'Already hired a seller for this job.'**
  String get alreadyHiredASellerForThisJob;

  /// No description provided for @verifyEmail.
  ///
  /// In en, this message translates to:
  /// **'Verify Email'**
  String get verifyEmail;

  /// No description provided for @by.
  ///
  /// In en, this message translates to:
  /// **'By'**
  String get by;

  /// No description provided for @writeAReview.
  ///
  /// In en, this message translates to:
  /// **'Write a Review'**
  String get writeAReview;

  /// No description provided for @howWasTheService.
  ///
  /// In en, this message translates to:
  /// **'How was the service?'**
  String get howWasTheService;

  /// No description provided for @postReview.
  ///
  /// In en, this message translates to:
  /// **'Post Review'**
  String get postReview;

  /// No description provided for @whatWentWrong.
  ///
  /// In en, this message translates to:
  /// **'What went wrong?'**
  String get whatWentWrong;

  /// No description provided for @writeTheIssue.
  ///
  /// In en, this message translates to:
  /// **'Write the issue'**
  String get writeTheIssue;

  /// No description provided for @submitReport.
  ///
  /// In en, this message translates to:
  /// **'Submit Report'**
  String get submitReport;

  /// No description provided for @youMustWriteSomethingToSubmitReport.
  ///
  /// In en, this message translates to:
  /// **'You must write something to submit report'**
  String get youMustWriteSomethingToSubmitReport;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @loadFailed.
  ///
  /// In en, this message translates to:
  /// **'Load failed'**
  String get loadFailed;

  /// No description provided for @releaseToLoadMore.
  ///
  /// In en, this message translates to:
  /// **'Release to load more'**
  String get releaseToLoadMore;

  /// No description provided for @noMoreData.
  ///
  /// In en, this message translates to:
  /// **'No more data'**
  String get noMoreData;

  /// No description provided for @editJob.
  ///
  /// In en, this message translates to:
  /// **'Edit Job'**
  String get editJob;

  /// No description provided for @newPassword.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get newPassword;

  /// No description provided for @noServiceAvailableInYourArea.
  ///
  /// In en, this message translates to:
  /// **'No service available in your area'**
  String get noServiceAvailableInYourArea;

  /// No description provided for @noDateCreated.
  ///
  /// In en, this message translates to:
  /// **'No date created'**
  String get noDateCreated;

  /// No description provided for @noScheduleCreated.
  ///
  /// In en, this message translates to:
  /// **'No schedule created'**
  String get noScheduleCreated;

  /// No description provided for @supportTickets.
  ///
  /// In en, this message translates to:
  /// **'Support Tickets'**
  String get supportTickets;

  /// No description provided for @orderNumber.
  ///
  /// In en, this message translates to:
  /// **'Order Number'**
  String get orderNumber;

  /// No description provided for @orderExtraAccepted.
  ///
  /// In en, this message translates to:
  /// **'Order extra accepted'**
  String get orderExtraAccepted;

  /// No description provided for @hiredSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Hired successfully'**
  String get hiredSuccessfully;

  /// No description provided for @january.
  ///
  /// In en, this message translates to:
  /// **'January'**
  String get january;

  /// No description provided for @february.
  ///
  /// In en, this message translates to:
  /// **'February'**
  String get february;

  /// No description provided for @march.
  ///
  /// In en, this message translates to:
  /// **'March'**
  String get march;

  /// No description provided for @april.
  ///
  /// In en, this message translates to:
  /// **'April'**
  String get april;

  /// No description provided for @may.
  ///
  /// In en, this message translates to:
  /// **'May'**
  String get may;

  /// No description provided for @june.
  ///
  /// In en, this message translates to:
  /// **'June'**
  String get june;

  /// No description provided for @july.
  ///
  /// In en, this message translates to:
  /// **'July'**
  String get july;

  /// No description provided for @august.
  ///
  /// In en, this message translates to:
  /// **'August'**
  String get august;

  /// No description provided for @september.
  ///
  /// In en, this message translates to:
  /// **'September'**
  String get september;

  /// No description provided for @october.
  ///
  /// In en, this message translates to:
  /// **'October'**
  String get october;

  /// No description provided for @november.
  ///
  /// In en, this message translates to:
  /// **'November'**
  String get november;

  /// No description provided for @december.
  ///
  /// In en, this message translates to:
  /// **'December'**
  String get december;

  /// No description provided for @enterThe4DigitCodeWeSentToYourEmailInOrderVerifyYourEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter the 4 digit code we sent to your email in order to verify your email'**
  String get enterThe4DigitCodeWeSentToYourEmailInOrderVerifyYourEmail;

  /// No description provided for @describeWhyYouWantToDeclineTheRequest.
  ///
  /// In en, this message translates to:
  /// **'Please describe why you want to decline the request'**
  String get describeWhyYouWantToDeclineTheRequest;

  /// No description provided for @youMustEnterDeclineReason.
  ///
  /// In en, this message translates to:
  /// **'You must enter decline reason'**
  String get youMustEnterDeclineReason;

  /// No description provided for @orderCompleteRequestSuccessfullyApproved.
  ///
  /// In en, this message translates to:
  /// **'Order complete request successfully approved.'**
  String get orderCompleteRequestSuccessfullyApproved;

  /// No description provided for @noCityFound.
  ///
  /// In en, this message translates to:
  /// **'No city found'**
  String get noCityFound;

  /// No description provided for @searchState.
  ///
  /// In en, this message translates to:
  /// **'Search State'**
  String get searchState;

  /// No description provided for @noCountryFound.
  ///
  /// In en, this message translates to:
  /// **'No country found'**
  String get noCountryFound;

  /// No description provided for @noAreaFound.
  ///
  /// In en, this message translates to:
  /// **'No area found'**
  String get noAreaFound;

  /// No description provided for @searchArea.
  ///
  /// In en, this message translates to:
  /// **'Search Area'**
  String get searchArea;

  /// No description provided for @searchCity.
  ///
  /// In en, this message translates to:
  /// **'Search City'**
  String get searchCity;

  /// No description provided for @chooseImage.
  ///
  /// In en, this message translates to:
  /// **'Choose Image'**
  String get chooseImage;

  /// No description provided for @declineSuccess.
  ///
  /// In en, this message translates to:
  /// **'Decline success'**
  String get declineSuccess;

  /// No description provided for @extraServiceNotFound.
  ///
  /// In en, this message translates to:
  /// **'Extra service not found'**
  String get extraServiceNotFound;

  /// No description provided for @orderNotFound.
  ///
  /// In en, this message translates to:
  /// **'Order not found'**
  String get orderNotFound;

  /// No description provided for @supportTicketCreatedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Support ticket created successfully'**
  String get supportTicketCreatedSuccess;

  /// No description provided for @paymentHasBeenExpired.
  ///
  /// In en, this message translates to:
  /// **'Payment has been expired.'**
  String get paymentHasBeenExpired;

  /// No description provided for @paymentHasBeenCancelled.
  ///
  /// In en, this message translates to:
  /// **'Payment has been cancelled.'**
  String get paymentHasBeenCancelled;

  /// No description provided for @welcomeToShashaktNirman.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Shashakt Nirman'**
  String get welcomeToShashaktNirman;

  /// No description provided for @hello.
  ///
  /// In en, this message translates to:
  /// **'Hello! 👋'**
  String get hello;

  /// No description provided for @youllHaveToLoginRegisterToEditOrSeeYourProfileInfo.
  ///
  /// In en, this message translates to:
  /// **'You\'ll have to login/register to edit or see your profile info.'**
  String get youllHaveToLoginRegisterToEditOrSeeYourProfileInfo;

  /// No description provided for @signInSignUp.
  ///
  /// In en, this message translates to:
  /// **'Sign In/Sign Up'**
  String get signInSignUp;

  /// No description provided for @searchLocation.
  ///
  /// In en, this message translates to:
  /// **'Search Location'**
  String get searchLocation;

  /// No description provided for @noLocationFound.
  ///
  /// In en, this message translates to:
  /// **'No location found'**
  String get noLocationFound;

  /// No description provided for @choosingCurrentLocation.
  ///
  /// In en, this message translates to:
  /// **'Choosing current location'**
  String get choosingCurrentLocation;

  /// No description provided for @failedToGetLocation.
  ///
  /// In en, this message translates to:
  /// **'Failed to get location'**
  String get failedToGetLocation;

  /// No description provided for @locationSetSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Location set successfully'**
  String get locationSetSuccessfully;

  /// No description provided for @chooseCurrentLocation.
  ///
  /// In en, this message translates to:
  /// **'Choose current location'**
  String get chooseCurrentLocation;

  /// No description provided for @and.
  ///
  /// In en, this message translates to:
  /// **'And'**
  String get and;

  /// No description provided for @pleaseEnterADescription.
  ///
  /// In en, this message translates to:
  /// **'Please enter a description'**
  String get pleaseEnterADescription;

  /// No description provided for @pleaseEnterAValidPassword.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid password'**
  String get pleaseEnterAValidPassword;

  /// No description provided for @payByWalletIsNotAvailableForWalletDeposit.
  ///
  /// In en, this message translates to:
  /// **'Pay by wallet is not available for wallet deposit'**
  String get payByWalletIsNotAvailableForWalletDeposit;

  /// No description provided for @manualPaymentIsNotAvailableForSecondAttemptPayment.
  ///
  /// In en, this message translates to:
  /// **'Manual payment is not available for second attempt payment'**
  String get manualPaymentIsNotAvailableForSecondAttemptPayment;

  /// No description provided for @youMustUploadTheChequeImage.
  ///
  /// In en, this message translates to:
  /// **'You must upload the cheque image'**
  String get youMustUploadTheChequeImage;

  /// No description provided for @cashOnDeliveryIsNotAvailableForSecondAttemptPayment.
  ///
  /// In en, this message translates to:
  /// **'Cash on delivery is not available for second attempt payment'**
  String get cashOnDeliveryIsNotAvailableForSecondAttemptPayment;

  /// No description provided for @cashOnDeliveryIsNotAvailableForHiringInJob.
  ///
  /// In en, this message translates to:
  /// **'Cash on delivery is not available for hiring in job'**
  String get cashOnDeliveryIsNotAvailableForHiringInJob;

  /// No description provided for @vacation.
  ///
  /// In en, this message translates to:
  /// **'Vacation'**
  String get vacation;

  /// No description provided for @personalReason.
  ///
  /// In en, this message translates to:
  /// **'Personal Reason'**
  String get personalReason;

  /// No description provided for @enterOtp.
  ///
  /// In en, this message translates to:
  /// **'Enter OTP'**
  String get enterOtp;

  /// No description provided for @support.
  ///
  /// In en, this message translates to:
  /// **'Support'**
  String get support;

  /// No description provided for @productInquiry.
  ///
  /// In en, this message translates to:
  /// **'Product Inquiry'**
  String get productInquiry;

  /// No description provided for @feedback.
  ///
  /// In en, this message translates to:
  /// **'Feedback'**
  String get feedback;

  /// No description provided for @generalQuery.
  ///
  /// In en, this message translates to:
  /// **'General Query'**
  String get generalQuery;

  /// No description provided for @mediumPriority.
  ///
  /// In en, this message translates to:
  /// **'Medium Priority'**
  String get mediumPriority;

  /// No description provided for @lowPriority.
  ///
  /// In en, this message translates to:
  /// **'Low Priority'**
  String get lowPriority;

  /// No description provided for @dateTwoDaysAgo.
  ///
  /// In en, this message translates to:
  /// **'Date: 2 days ago'**
  String get dateTwoDaysAgo;

  /// No description provided for @appSetting.
  ///
  /// In en, this message translates to:
  /// **'App Settings'**
  String get appSetting;

  /// No description provided for @noSubscriptionAddedHere.
  ///
  /// In en, this message translates to:
  /// **'No Subscription Added Here'**
  String get noSubscriptionAddedHere;

  /// No description provided for @shareMessage.
  ///
  /// In en, this message translates to:
  /// **'Get Service Full Details https://play.google.com/store/apps/details?id=com.shashaktnirmanuserapp\n🔍 Key Features:\n✅ Search & connect with verified contractors\n✅ Find trusted material suppliers for every project need\n✅ Rent construction machinery hassle-free\n✅ Seamless booking & direct communication\n\nRegards\nSashakt Nirmaan'**
  String get shareMessage;

  /// No description provided for @shareSubject.
  ///
  /// In en, this message translates to:
  /// **'Discover Sashakt Nirmaan App'**
  String get shareSubject;

  /// No description provided for @failedUpdateService.
  ///
  /// In en, this message translates to:
  /// **'Failed to Update service'**
  String get failedUpdateService;

  /// No description provided for @advertisement.
  ///
  /// In en, this message translates to:
  /// **'Advertisement'**
  String get advertisement;

  /// No description provided for @menuText.
  ///
  /// In en, this message translates to:
  /// **'Menu'**
  String get menuText;

  /// No description provided for @notAvailable.
  ///
  /// In en, this message translates to:
  /// **'NA'**
  String get notAvailable;

  /// No description provided for @shareNow.
  ///
  /// In en, this message translates to:
  /// **'Share Now'**
  String get shareNow;

  /// No description provided for @thankYou.
  ///
  /// In en, this message translates to:
  /// **'Thank You'**
  String get thankYou;

  /// No description provided for @thankYouEnquiryText.
  ///
  /// In en, this message translates to:
  /// **'Thank you for your enquiry with us, we will call you back soon.'**
  String get thankYouEnquiryText;

  /// No description provided for @introTitle1.
  ///
  /// In en, this message translates to:
  /// **'Repairing Services'**
  String get introTitle1;

  /// No description provided for @introTitle2.
  ///
  /// In en, this message translates to:
  /// **'House Cleaning Service'**
  String get introTitle2;

  /// No description provided for @introTitle3.
  ///
  /// In en, this message translates to:
  /// **'Home Shifting Service'**
  String get introTitle3;

  /// No description provided for @introSubTitle1.
  ///
  /// In en, this message translates to:
  /// **'Get repaired anything from our thousands of experts'**
  String get introSubTitle1;

  /// No description provided for @introSubTitle2.
  ///
  /// In en, this message translates to:
  /// **'Get house cleaning services from expert cleaners'**
  String get introSubTitle2;

  /// No description provided for @introSubTitle3.
  ///
  /// In en, this message translates to:
  /// **'Take our home shifting service to get best service'**
  String get introSubTitle3;

  /// No description provided for @businessDescReqChar.
  ///
  /// In en, this message translates to:
  /// **'Business Description must be at \\nleast 150 characters long'**
  String get businessDescReqChar;

  /// No description provided for @selectLocation.
  ///
  /// In en, this message translates to:
  /// **'Select Location'**
  String get selectLocation;

  /// No description provided for @subscriptionSuccessMsg.
  ///
  /// In en, this message translates to:
  /// **'Subscription purchased successfully'**
  String get subscriptionSuccessMsg;

  /// No description provided for @subscriptionFailedMsg.
  ///
  /// In en, this message translates to:
  /// **'Subscription purchase failed'**
  String get subscriptionFailedMsg;

  /// No description provided for @addPosterForTopSlider.
  ///
  /// In en, this message translates to:
  /// **'Add Poster For Top Slider'**
  String get addPosterForTopSlider;

  /// No description provided for @addPosterForBottomSlider.
  ///
  /// In en, this message translates to:
  /// **'Add Poster For Bottom Slider'**
  String get addPosterForBottomSlider;

  /// No description provided for @alreadyPaid.
  ///
  /// In en, this message translates to:
  /// **'Already Subscribed'**
  String get alreadyPaid;

  /// No description provided for @logoutScreenText.
  ///
  /// In en, this message translates to:
  /// **'Oops!\nIt seems like you\'re not logged in'**
  String get logoutScreenText;

  /// No description provided for @contactTextMsg.
  ///
  /// In en, this message translates to:
  /// **'Hello Admin, I need help regarding the application. Please assist me. Thank you!'**
  String get contactTextMsg;

  /// No description provided for @contactUs.
  ///
  /// In en, this message translates to:
  /// **'Contact Us'**
  String get contactUs;

  /// No description provided for @contactViaWhatsApp.
  ///
  /// In en, this message translates to:
  /// **'Contact Via WhatsApp'**
  String get contactViaWhatsApp;

  /// No description provided for @contactViaCall.
  ///
  /// In en, this message translates to:
  /// **'Contact Via Call'**
  String get contactViaCall;

  /// No description provided for @contactViaMail.
  ///
  /// In en, this message translates to:
  /// **'Contact Via Mail'**
  String get contactViaMail;

  /// No description provided for @whatsappContactMsg.
  ///
  /// In en, this message translates to:
  /// **'Hello, I am interested in your service'**
  String get whatsappContactMsg;

  /// No description provided for @tapToChangeImage.
  ///
  /// In en, this message translates to:
  /// **'Tap here to change the image'**
  String get tapToChangeImage;

  /// No description provided for @shareText.
  ///
  /// In en, this message translates to:
  /// **'🚀 *SASHAKT NIRMAAN – Your One-Stop Construction Partner!* 🏗️\n\nIntroducing *SASHAKT NIRMAAN*, a **Comprehensive Platform** designed to connect *contractors, material suppliers, and machinery rental services* with vendors and customers effortlessly. Whether you\'re looking for a *trusted contractor, quality construction materials, or heavy machinery on rent*, our platform makes it easy to **search, compare, and appoint** the best service providers in just a few clicks.\n\n🔍 *Key Features:*\n✅ Search & connect with *verified contractors*\n✅ Find *trusted material suppliers* for every project need\n✅ Rent *construction machinery* hassle-free\n✅ Seamless booking & direct communication\n\nWith *SASHAKT NIRMAAN*, construction solutions are now **smarter, faster, and more efficient!** Download now and **build with confidence!** 🚧📲\n\nAvailable on Google Play Store\nhttps://play.google.com/store/apps/details?id=com.shashaktnirmanuserapp\n\nContact Us\nsashaktnirmaan@gmail.com\nwww.sashaktnirmaan.com'**
  String get shareText;

  /// No description provided for @noServiceProviderInYourArea.
  ///
  /// In en, this message translates to:
  /// **'No Service Provider Aavailable In Your Area'**
  String get noServiceProviderInYourArea;

  /// No description provided for @whatsappWelcomeMsg.
  ///
  /// In en, this message translates to:
  /// **'Hello! 👋\\n\\nThank you for your interest in our services. How can I assist you today? If you have any questions or need further information, feel free to ask!\\n\\nLooking forward to hearing from you soon!'**
  String get whatsappWelcomeMsg;

  /// No description provided for @skipModeMsg.
  ///
  /// In en, this message translates to:
  /// **'You are in skip mode'**
  String get skipModeMsg;

  /// No description provided for @tryDemo30.
  ///
  /// In en, this message translates to:
  /// **'Use free for 30 days'**
  String get tryDemo30;

  /// No description provided for @youAreaProMsgText.
  ///
  /// In en, this message translates to:
  /// **'You\'re already enjoying the Pro plan! Your next renewal date is'**
  String get youAreaProMsgText;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'bn', 'en', 'hi'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return AppLocalizationsAr();
    case 'bn': return AppLocalizationsBn();
    case 'en': return AppLocalizationsEn();
    case 'hi': return AppLocalizationsHi();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
