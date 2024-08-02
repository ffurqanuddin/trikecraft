// amount_to_words_extension.dart
extension AmountToWords on int {
  String toWords() {
    if (this == 0) return "zero";

    final units = ["", "thousand", "lakh", "crore"];
    final teens = [
      "", "eleven", "twelve", "thirteen", "fourteen", "fifteen",
      "sixteen", "seventeen", "eighteen", "nineteen"
    ];
    final tens = ["", "", "twenty", "thirty", "forty", "fifty", "sixty", "seventy", "eighty", "ninety"];
    final ones = [
      "", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten"
    ];

    List<String> parts = [];
    int unitIndex = 0;
    int amount = this;

    while (amount > 0) {
      int part = amount % 1000;
      if (part != 0) {
        String partStr = "";
        if (part > 99) {
          partStr += "${ones[part ~/ 100]} hundred ";
          part %= 100;
        }
        if (part > 10 && part < 20) {
          partStr += "${teens[part - 10]} ";
        } else {
          if (part >= 20) {
            partStr += "${tens[part ~/ 10]} ";
            part %= 10;
          }
          if (part > 0) {
            partStr += "${ones[part]} ";
          }
        }
        parts.insert(0, "$partStr${units[unitIndex]}");
      }
      amount ~/= 1000;
      unitIndex++;
    }

    return parts.join(" ").trim();
  }
}
