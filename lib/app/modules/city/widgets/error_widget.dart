part of '../views/city_view.dart';

class _ErrorWidget extends GetView<CityController> {
  const _ErrorWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Icon(
          Icons.error,
          color: Colors.red,
          size: 50,
        ),
        Obx(
          () => Text(
            controller.errorMessage,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
