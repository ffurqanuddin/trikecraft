extension DeliveryDateExtension on DateTime {
  /// Adds 10 days to the current date and returns the delivery date.
  DateTime get deliveryDate => this.add(Duration(days: 10));
}
