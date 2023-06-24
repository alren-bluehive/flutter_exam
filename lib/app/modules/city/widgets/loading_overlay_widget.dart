part of '../views/city_view.dart';

class _LoadingOverlayWidget extends StatelessWidget {
  const _LoadingOverlayWidget({
    Key? key,
    required this.isLoading,
  }) : super(key: key);

  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Container(
            height: double.maxFinite,
            width: double.maxFinite,
            color: Colors.white,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          )
        : const SizedBox();
  }
}
