class AddBookingRequest {
  AddBookingRequest({
    this.orderDate = '',
    this.productId = const [],
    this.paymentType = '',
  });

  final String orderDate;
  final List<int> productId;
  final String paymentType;

  Map<String, dynamic> toMap() {
    return {
      "order_date": orderDate,
      "product_id": productId,
      "payment_type": paymentType,
    };
  }
}
