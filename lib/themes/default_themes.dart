import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qixer/helper/extension/context_extension.dart';

import '../view/utils/constant_colors.dart';

class DefaultThemes {
  InputDecorationTheme? inputDecorationTheme(BuildContext context) =>
      InputDecorationTheme(
          hintStyle: WidgetStateTextStyle.resolveWith((states) {
            return Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: cc.black5,
                );
          }),
          counterStyle: WidgetStateTextStyle.resolveWith((states) {
            if (states.contains(WidgetState.focused)) {
              return Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(color: cc.primaryColor);
            }
            return Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(color: cc.black3);
          }),
          fillColor: cc.black8,
          errorStyle: Theme.of(context)
              .textTheme
              .titleSmall!
              .copyWith(color: cc.warningColor),
          filled: true,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(8)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ConstantColors().primaryColor)),
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ConstantColors().warningColor)),
          focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ConstantColors().primaryColor)),
          prefixIconColor: WidgetStateColor.resolveWith((states) {
            if (states.contains(WidgetState.focused)) {
              return cc.primaryColor;
            }
            if (states.contains(WidgetState.error)) {
              return cc.warningColor;
            }
            return cc.black5;
          }));

  CheckboxThemeData? checkboxTheme() => CheckboxThemeData(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        side: BorderSide(
          width: 2,
          color: cc.black7,
        ),
        fillColor: WidgetStateColor.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return cc.primaryColor;
          }
          return cc.white;
        }),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(3),
            side: BorderSide(
              // width: 1,
              color: cc.primaryColor,
            )),
      );
  RadioThemeData? radioThemeData(dProvider) => RadioThemeData(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        fillColor: WidgetStateColor.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return dProvider.secondaryColor;
          }
          return cc.white;
        }),
        visualDensity: VisualDensity.compact,
      );

  OutlinedButtonThemeData? outlinedButtonTheme(BuildContext context) =>
      OutlinedButtonThemeData(
          style: ButtonStyle(
        overlayColor:
            WidgetStateColor.resolveWith((states) => Colors.transparent),
        shape: WidgetStateProperty.resolveWith<OutlinedBorder?>((states) {
          return RoundedRectangleBorder(borderRadius: BorderRadius.circular(8));
          // }
        }),
        side: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.pressed)) {
            return BorderSide(
              color: cc.primaryColor,
            );
          }
          return BorderSide(
            color: cc.black8,
          );
        }),
        textStyle: WidgetStateProperty.resolveWith((states) =>
            context.titleMedium!.copyWith(fontWeight: FontWeight.w600)),
        foregroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.pressed)) {
            return cc.primaryColor;
          }
          return cc.black5;
        }),
      ));

  ElevatedButtonThemeData? elevatedButtonTheme(BuildContext context) =>
      ElevatedButtonThemeData(
          style: ButtonStyle(
        elevation: WidgetStateProperty.resolveWith((states) => 0),
        overlayColor:
            WidgetStateColor.resolveWith((states) => Colors.transparent),
        shape: WidgetStateProperty.resolveWith<OutlinedBorder?>((states) {
          return RoundedRectangleBorder(borderRadius: BorderRadius.circular(8));
          // }
        }),
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return cc.primaryColor.withOpacity(.05);
          }
          if (states.contains(WidgetState.pressed)) {
            return cc.black3;
          }
          return cc.primaryColor;
        }),
        textStyle: WidgetStateProperty.resolveWith((states) => Theme.of(context)
            .textTheme
            .titleMedium!
            .copyWith(fontWeight: FontWeight.w600)),
        foregroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return cc.black5;
          }
          if (states.contains(WidgetState.pressed)) {
            return cc.white;
          }
          return cc.white;
        }),
      ));
  TextButtonThemeData? textButtonThemeData(BuildContext context) =>
      TextButtonThemeData(
          style: ButtonStyle(
              elevation: WidgetStateProperty.resolveWith((states) => 0),
              overlayColor:
                  WidgetStateColor.resolveWith((states) => Colors.transparent),
              backgroundColor: WidgetStateProperty.resolveWith((states) {
                return cc.black3.withOpacity(0.0);
              }),
              foregroundColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.disabled)) {
                  return cc.black5;
                }
                if (states.contains(WidgetState.pressed)) {
                  return cc.black3;
                }
                return cc.black3;
              }),
              textStyle: WidgetStateProperty.resolveWith((states) =>
                  Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.w600))));

  appBarTheme(BuildContext context) => AppBarTheme(
        backgroundColor: cc.white,
        foregroundColor: cc.black3,
        titleTextStyle: Theme.of(context)
            .textTheme
            .titleLarge
            ?.copyWith(fontWeight: FontWeight.w600),
        iconTheme: IconThemeData(color: cc.black3),
        actionsIconTheme: IconThemeData(color: cc.black3),
        elevation: 0,
        surfaceTintColor: cc.white,
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark),
      );

  sliderTheme(BuildContext context) {
    return SliderThemeData(
      thumbColor: cc.white,
      inactiveTrackColor: cc.black7,
      activeTrackColor: cc.primaryColor,
      trackHeight: 3,
    );
  }

  dropdownMenuTheme() {
    return DropdownMenuThemeData(
        menuStyle: MenuStyle(
      backgroundColor: WidgetStateProperty.resolveWith((states) => cc.white),
      surfaceTintColor: WidgetStateProperty.resolveWith((states) => cc.white),
    ));
  }

  // themeData(BuildContext context, dProvider) => ThemeData(
  //     primaryColor: cc.primaryColor,
  //     fontFamily: "Gilroy",
  //     scaffoldBackgroundColor: Colors.transparent,
  //     scrollbarTheme: scrollbarTheme(dProvider),
  //     useMaterial3: true,
  //     appBarTheme: DefaultThemes().appBarTheme(context),
  //     elevatedButtonTheme: elevatedButtonTheme(dProvider, context),
  //     outlinedButtonTheme: outlinedButtonTheme(dProvider, context),
  //     inputDecorationTheme: inputDecorationTheme(context, dProvider),
  //     checkboxTheme: checkboxTheme(dProvider),
  //     textButtonTheme: textButtonThemeData(),
  //     // navigationBarTheme: navigationBarThemeData(context),
  //     switchTheme: switchThemeData(dProvider),
  //     radioTheme: radioThemeData(dProvider));

  // navigationBarThemeData(BuildContext context) {
  //   return NavigationBarThemeData(
  //     backgroundColor: context.dProvider.navBarColor,
  //     surfaceTintColor: context.dProvider.navBarColor,
  //     indicatorColor: context.dProvider.navBarColor,
  //   );
  // }
}

SwitchThemeData switchThemeData() => SwitchThemeData(
      thumbColor:
          WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
        if (states.contains(WidgetState.disabled)) {
          return cc.primaryColor.withOpacity(.10);
        }
        return cc.white;
      }),
      trackColor:
          WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
        if (!states.contains(WidgetState.selected)) {
          return cc.black8;
        }
        return cc.primaryColor.withOpacity(.60);
      }),
      trackOutlineColor:
          WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
        if (!states.contains(WidgetState.selected)) {
          return cc.black8;
        }
        return cc.primaryColor.withOpacity(.40);
      }),
    );

ScrollbarThemeData scrollbarTheme() => ScrollbarThemeData(
      thumbVisibility: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.scrolledUnder)) {
          return true;
        }
        return false;
      }),
      thickness: WidgetStateProperty.resolveWith((states) => 6),
      thumbColor: WidgetStateProperty.resolveWith(
          (states) => cc.primaryColor.withOpacity(.60)),
    );
