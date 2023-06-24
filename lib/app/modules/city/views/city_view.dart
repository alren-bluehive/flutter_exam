import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:flutter_exam/app/modules/city/controllers/city_controller.dart';

part '../widgets/city_data_widget.dart';
part '../widgets/error_widget.dart';
part '../widgets/loading_overlay_widget.dart';

class CityView extends GetView<CityController> {
  const CityView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => controller.isLoading ? false : true,
      child: Stack(
        children: [
          Scaffold(
            // missing const to improve performance
            // the use of const in Dart can improve performance in certain situations because it allows objects to be created and allocated at compile-time rather than runtime
            // since the AppBar has a property centerTitle, we can now remove the center widget
            // the use of property centerTitle will improve visual aesthetics and increase readability
            // added const keyword to improve performance
            // removed center widget
            // set centerTitle to true
            appBar: AppBar(
              title: const Text('Weather Page'),
              centerTitle: true,
            ),
            // Small devices might not fit all the content due to their small screen
            // This problem will result to RenderFlex error
            // To avoid RenderFlex error on small mobile devices.
            body: SingleChildScrollView(
              // Added some padding to just have proper spacing
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const Text(
                    'Valid input are: Berlin, Manila, Tokyo or Moscow',
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      // Unnecessary container
                      // It is kinda excessive to use widget where you do not really need them.
                      // Moreover, it causes a ui error so we are changing it from container to a expanded widget
                      Expanded(
                        child: Form(
                          key: controller.formKey,
                          // Converted to TextFormField to really have a validation on the input
                          child: TextFormField(
                            controller: controller.cityController,
                            // Just use a normal city string here
                            // It makes no sense for this to change from time to time anyways
                            decoration: const InputDecoration(
                                hintText: 'Enter City Name'),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'City name cannot be empty';
                              }
                              return null;
                            },
                            autocorrect: false,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      // Missing child argument for this button
                      // Added child widget
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.30,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            ElevatedButton(
                              onPressed: () =>
                                  getCityData(context, withValidToken: true),
                              child: const Text('Valid Fetch'),
                            ),
                            ElevatedButton(
                              onPressed: () =>
                                  getCityData(context, withValidToken: false),
                              child: const Text('Invalid Fetch'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),
                  Obx(
                    () => SizedBox(
                      child: controller.hasError
                          ? const _ErrorWidget()
                          : const _CityDataWidget(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Obx(() => _LoadingOverlayWidget(isLoading: controller.isLoading)),
        ],
      ),
    );
  }

  void getCityData(BuildContext context, {required bool withValidToken}) {
    FocusScope.of(context).unfocus();
    final isValidationSuccessful =
        controller.formKey.currentState?.validate() ?? false;
    if (!isValidationSuccessful) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('City Input Error'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }
    final userToken = withValidToken ? 'valid_token' : 'invalid_token';
    controller.fetchCityData(userToken);
  }
}
