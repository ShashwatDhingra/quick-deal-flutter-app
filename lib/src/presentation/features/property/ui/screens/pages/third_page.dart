import 'package:quickdeal/src/presentation/customs/custom_inc_dec.dart';
import 'package:quickdeal/src/presentation/customs/custom_dropdown_field.dart';
import 'package:quickdeal/src/presentation/features/dashboard/subscreens/profile/profile.dart';
import 'package:quickdeal/src/presentation/features/property/states/thrid_page_state.dart';

import '../../../../../customs/custom_select_field.dart';
import '../../../../../customs/custom_textformfield.dart';

class ThirdPage extends ConsumerWidget {
  const ThirdPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final thridPageState = ref.watch(thirdPageStateProvider);
    final thridPageNotifier = ref.watch(thirdPageStateProvider.notifier);
    return Form(
      key: thridPageNotifier.thirdPageFormKey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(children: [
            Text('Details', style: Theme.of(context).textTheme.titleLarge),
            12.hBox,
            const Align(
                alignment: Alignment.centerLeft, child: Text('Indoor Details')),
            12.hBox,
            IncrementDecrementField(
                controller: thridPageState.bedroomNoController,
                labelText: 'Bedrooms'),
            16.hBox,
            IncrementDecrementField(
                controller: thridPageState.bathroomNoController,
                labelText: 'Bathrooms'),
            16.hBox,
            CustomTextformField(
              cont: thridPageState.areaSizeController,
              labelText: 'Area Size',
              keyboardType: TextInputType.number,
            ),
            16.hBox,
            CustomSelectField(
              options: const [
                'Air Conditioning',
                'TV',
                'Gym',
                'Laundry',
                'Microwave',
                'Refrigerator',
                'Wifi',
                'Windows Covering'
              ],
              selectedValues: thridPageState.featureList,
              labelText: 'Features',
              onChanged: (values) {
                thridPageNotifier.updateFeatureList(values);
              },
            ),
            16.hBox,
            const Align(
                alignment: Alignment.centerLeft,
                child: Text('Outdoor Details')),
            16.hBox,
            CustomDropdownField(
                value: thridPageState.isParkingAvailable,
                onChanged: (bool? val) {
                  thridPageNotifier.updateIsParkingValue(val ?? false);
                },
                labelText: 'Is Parking Available'),
            16.hBox,
            CustomTextformField(
              cont: thridPageState.twoWheelerParkingController,
              labelText: 'Parking For Two Wheeler',
              keyboardType: TextInputType.number,
            ),
            16.hBox,
            CustomTextformField(
              cont: thridPageState.fourWheelerParkingController,
              labelText: 'Parking for Four Wheeler',
              keyboardType: TextInputType.number,
            ),
            16.hBox,
            CustomTextformField(
              cont: thridPageState.yearBuildController,
              labelText: 'Year Build',
              keyboardType: TextInputType.number,
            ),
            16.hBox,
            CustomSelectField(
              options: const [
                'Security Camera',
                'Electric Fence',
                'Wooden Fence',
                'Security Guard',
              ],
              selectedValues: thridPageState.securityFeatureList,
              labelText: 'Security Features',
              onChanged: (values) {
                thridPageNotifier.updateSecurityFeatureList(values);
              },
            ),
            16.hBox,
            CustomSelectField(
              options: const [
                'Swimming Pool',
                'ClubHouse',
              ],
              selectedValues: thridPageState.amenetiesList,
              labelText: 'Ameneties',
              onChanged: (values) {
                thridPageNotifier.updateAmenetiesList(values);
              },
            ),
          ]),
        ),
      ),
    );
  }
}
