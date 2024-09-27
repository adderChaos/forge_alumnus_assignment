class AppConstants {
  static final RegExp nameRegex =
      RegExp(r"^[\p{L}.' ]*$", //allow accented Latin letters
          caseSensitive: false,
          unicode: true,
          dotAll: true);

  ///The email cannot have two or more consecutive special characters from ._%+-.
//  cannot have five or more periods, must start with an alphanumeric character.
// The local part can include alphanumeric characters and the special characters ._%+-.
// The domain part (after the @) can include alphanumeric characters, periods, or hyphens, and must end with a period followed by 2 to 6 alphabetic characters.
  static final RegExp emailRegex = RegExp(
      r"(^(?!.*[._%+-]{2,})(?!.*\..*\..*\..*\..*\..*)([a-zA-Z0-9][a-zA-Z0-9._%+-]*@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6})$)");

  static final RegExp phoneRegex = RegExp(r'^[0-9]+$');
}
