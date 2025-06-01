class TransactionResponse {
  final bool success;
  final String message;
  final String snapToken;
  final String redirectUrl;

  TransactionResponse({
    required this.success,
    required this.message,
    required this.snapToken,
    required this.redirectUrl,
  });

  factory TransactionResponse.fromJson(Map<String, dynamic> json) {
    return TransactionResponse(
      success: json['success'],
      message: json['message'],
      snapToken: json['snap_token'],
      redirectUrl: json['redirect_url'],
    );
  }
}
