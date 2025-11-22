extension StringExtensions on String{
  String get rmQuotes => replaceAll("\"", "");
  String get formatError => replaceAll("Exception: ", "").replaceAll("-", " ");
  String get formatTxtValidate => contains("Enter") ? this : "Enter $this";
}


