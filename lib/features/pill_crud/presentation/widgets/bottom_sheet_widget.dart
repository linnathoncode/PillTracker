import 'package:flutter/material.dart';
import 'package:pill_tracker/features/pill_crud/presentation/provider/bottom_sheet_view_model.dart';
import 'package:pill_tracker/features/pill_crud/presentation/widgets/custom_checkboxlist_widget.dart';
import 'package:provider/provider.dart';
import 'custom_text_form_field_widget.dart';

class BottomSheetWidget extends StatelessWidget {
  const BottomSheetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<BottomSheetViewModel>(context);

    return Form(
      key: viewModel.formKey,
      child: SingleChildScrollView(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // CustomDropdownMenu(
              //   items: viewModel.dropDownItems,
              //   selectedValue: viewModel.selectedDropdownValue,
              //   onValueChanged: viewModel.updateDropdownValue,
              // ),
              const SizedBox(height: 10),
              CustomTextFormField(
                controller: viewModel.nameController,
                label: "Pill Name",
                maxLength: 25,
                hintText: "e.g., Aspirin",
                errorMessage: "Please enter a name",
                keyboardType: TextInputType.text,
                isNumeric: false,
                hasAutofocus: false,
                formKey: viewModel.nameKey,
                validator: viewModel.validateName,
              ),
              const SizedBox(height: 10),
              CustomTextFormField(
                controller: viewModel.totalPillsController,
                label: "Number of pills left",
                maxLength: 25,
                hintText: "e.g., 2",
                errorMessage: "Please enter a number",
                keyboardType: TextInputType.number,
                isNumeric: true,
                hasAutofocus: false,
                formKey: viewModel.totalPillsKey,
                validator: viewModel.validateTotalPills,
              ),
              const SizedBox(height: 10),
              const CustomCheckboxList(),
              const SizedBox(height: 16),
              ElevatedButton(
                style: Theme.of(context).elevatedButtonTheme.style,
                onPressed: () async {
                  viewModel.savePill(context);
                },
                child: const Text("Save Pill"),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
