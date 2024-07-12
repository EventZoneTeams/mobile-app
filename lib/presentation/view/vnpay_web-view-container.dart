import 'package:eventzone/core/resources/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:webview_flutter/webview_flutter.dart'; // Import webview_flutter
class VnPayWebView extends StatefulWidget {
  final String url;
  const VnPayWebView({super.key, required this.url});

  @override
  State<VnPayWebView> createState() => _VnPayWebViewState();
}
class _VnPayWebViewState extends State<VnPayWebView> {
  late final WebViewController controller; // Declare controller

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted) // You might need unrestricted mode
      ..loadRequest(Uri.parse(widget.url))
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (url) {
            if (url.contains('vnp_TransactionStatus=')) {
              // Extract transaction status from URL
              final uri = Uri.parse(url);
              final transactionStatus = uri.queryParameters['vnp_TransactionStatus'];

              // Navigate to Account screen with transaction status as extra
              context.goNamed(
                AppRoutes.account,
                extra: transactionStatus,
              );
            }
          },
        ),
      );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
      ),
      body: WebViewWidget(controller: controller), // Use WebViewWidget
    );
  }
}