import 'package:flutter/material.dart';

class NetworkPicture extends StatelessWidget {
  const NetworkPicture({
    super.key,
    required this.url,
    this.fit = BoxFit.contain,
    this.width,
    this.iconSize = 40,
    this.errorWidget,
  });

  final String url;
  final BoxFit fit;
  final double? width;
  final double iconSize;
  final Widget? errorWidget;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      key: ValueKey(url),
      fit: fit,
      width: width,
      webHtmlElementStrategy: WebHtmlElementStrategy.fallback,
      loadingBuilder: (context, child, progress) {
        if (progress == null) return child;
        return const Center(child: CircularProgressIndicator(strokeWidth: 2));
      },
      errorBuilder: (context, error, stackTrace) =>
          errorWidget ??
          Icon(
            Icons.image_not_supported_outlined,
            size: iconSize,
            color: Colors.grey,
          ),
    );
  }
}
