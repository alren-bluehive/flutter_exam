part of '../views/city_view.dart';

// Instead of using a helper method  buildBody(context), I decided to use a separate widget in here
// According to flutter team, a separate widget is more performant than a helper method
// Video from flutter team: https://www.youtube.com/watch?v=IOyq-eTRhvo
// Moreover, this makes our code more granular.
class _CityDataWidget extends GetView<CityController> {
  const _CityDataWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          // Added some white space for the text not to touch the card's border
          const SizedBox(height: 20),
          // Removed unnecessary container here
          // It is kinda excessive to use widget where you do not really need them.
          Obx(() => Text('City: ${controller.cityData.name}')),
          // Removed unnecessary container here
          // It is kinda excessive to use widget where you do not really need them.
          // Also removed the Richtext Widget as the text its display is already displayed
          // Remove redundant widget
          Obx(
            () => Container(
              // Added const to improve performance
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              // Changed height from  750.0
              // This is to avoid the RenderFlex error
              height: MediaQuery.of(context).size.height * 0.35,
              child: Image.network(
                controller.cityData.imageUrl,
                fit: BoxFit.fill,
              ),
            ),
          ),
          Padding(
            // Added some padding for the text to be visually appealing
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Obx(
              () => Row(
                // Added alignment for children spacing
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Removed unnecessary container here
                  // It is kinda excessive to use widget where you do not really need them.
                  Column(
                    children: [
                      // Added const here to improve performance
                      const Text('Temperature:'),
                      Text(controller.cityData.temp.toString()),
                    ],
                  ),
                  // Updated to just a simple container with color and dimensions for readability
                  Container(
                    height: 40,
                    width: 1,
                    color: Colors.black,
                  ),
                  // Removed unnecessary container here
                  // It is kinda excessive to use widget where you do not really need them.
                  Column(
                    children: [
                      // Added const here to improve performance
                      const Text('Unit:'),
                      Text(controller.cityData.unit),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
