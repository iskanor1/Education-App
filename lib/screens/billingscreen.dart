import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';
import '../models/payment_request.dart';

const _cardBackgroundOpacity = 0.1;

class BillingScreen extends StatefulWidget {
  final PaymentModel? paymentModel;

  const BillingScreen({Key? key, this.paymentModel}) : super(key: key);

  @override
  State<BillingScreen> createState() => _BillingScreenState();
}

class _BillingScreenState extends State<BillingScreen> {
  final _formKey = GlobalKey<FormState>();
  late PaymentModel paymentModel;
  final _scrollController = ScrollController();
  bool _isProcessing = false;

  // Controllers
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneController = TextEditingController();
  final countryController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final streetController = TextEditingController();
  final buildingController = TextEditingController();
  final floorController = TextEditingController();
  final apartmentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    paymentModel = widget.paymentModel ?? PaymentModel.fromJson({
      'amount': 0,
      'currency': '',
      'payment_methods': [],
      'items': [],
      'billing_data': null,
      'extras': null,
      'expiration': 0,
      'notification_url': '',
      'redirection_url': ''
    });

    if (paymentModel.billingData != null) {
      _initializeControllers();
    }
  }

  void _initializeControllers() {
    firstNameController.text = paymentModel.billingData!.firstName;
    lastNameController.text = paymentModel.billingData!.lastName;
    phoneController.text = paymentModel.billingData!.phoneNumber;
    countryController.text = paymentModel.billingData!.country;
    cityController.text = paymentModel.billingData!.city;
    stateController.text = paymentModel.billingData!.state;
    streetController.text = paymentModel.billingData!.street;
    buildingController.text = paymentModel.billingData!.building;
    floorController.text = paymentModel.billingData!.floor;
    apartmentController.text = paymentModel.billingData!.apartment;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    countryController.dispose();
    cityController.dispose();
    stateController.dispose();
    streetController.dispose();
    buildingController.dispose();
    floorController.dispose();
    apartmentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Billing Information'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  buildPersonalInfoSection(theme),
                  const SizedBox(height: 24),
                  buildShippingAddressSection(theme),
                  const SizedBox(height: 32),
                ],
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  buildActionButtons(colorScheme),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPersonalInfoSection(ThemeData theme) {
    return Card(
      elevation: 0,
      color: theme.colorScheme.primary.withOpacity(_cardBackgroundOpacity),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: theme.dividerColor.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Personal Information',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            buildModernTextField(
              controller: firstNameController,
              label: 'First Name',
              icon: Icons.person_outline,
              validator: (value) => value!.isEmpty ? 'Required' : null,
            ),
            const SizedBox(height: 12),
            buildModernTextField(
              controller: lastNameController,
              label: 'Last Name',
              icon: Icons.person_outline,
              validator: (value) => value!.isEmpty ? 'Required' : null,
            ),
            const SizedBox(height: 12),
            buildModernTextField(
              controller: phoneController,
              label: 'Phone Number',
              icon: Icons.phone_outlined,
              keyboardType: TextInputType.phone,
              validator: (value) => value!.isEmpty ? 'Required' : null,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildShippingAddressSection(ThemeData theme) {
    return Card(
      elevation: 0,
      color: theme.colorScheme.primary.withOpacity(_cardBackgroundOpacity),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: theme.dividerColor.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Shipping Address',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            buildModernTextField(
              controller: countryController,
              label: 'Country',
              icon: Icons.flag_outlined,
            ),
            const SizedBox(height: 12),
            buildModernTextField(
              controller: cityController,
              label: 'City',
              icon: Icons.location_city_outlined,
            ),
            const SizedBox(height: 12),
            buildModernTextField(
              controller: stateController,
              label: 'State/Region',
              icon: Icons.map_outlined,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: buildModernTextField(
                    controller: streetController,
                    label: 'Street',
                    icon: Icons.streetview_outlined,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: buildModernTextField(
                    controller: buildingController,
                    label: 'Building',
                    icon: Icons.home_outlined,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: buildModernTextField(
                    controller: floorController,
                    label: 'Floor',
                    icon: Icons.stairs_outlined,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: buildModernTextField(
                    controller: apartmentController,
                    label: 'Apartment',
                    icon: Icons.door_sliding_outlined,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildModernTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      style: TextStyle(
        color: Theme.of(context).colorScheme.onSurface,
      ),
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, size: 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Theme.of(context).colorScheme.surface,
        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      ),
    );
  }

  Widget buildActionButtons(ColorScheme colorScheme) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: _isProcessing ? null : () => Navigator.pop(context),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              side: BorderSide(color: colorScheme.outline),
            ),
            child: Text(
              'Cancel',
              style: TextStyle(
                color: colorScheme.onSurface,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ElevatedButton(
            onPressed: _isProcessing ? null : _submitForm,
            style: ElevatedButton.styleFrom(
              backgroundColor: colorScheme.primary,
              foregroundColor: colorScheme.onPrimary,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
            child: _isProcessing
                ? const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.white,
              ),
            )
                : Text(
              'Pay Now',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isProcessing = true);

    try {
      // Simulate payment processing
      await Future.delayed(const Duration(seconds: 2));

      paymentModel.billingData = BillingData.fromJson({
        "apartment": apartmentController.text,
        "first_name": firstNameController.text,
        "last_name": lastNameController.text,
        "street": streetController.text,
        "building": buildingController.text,
        "phone_number": phoneController.text,
        "city": cityController.text,
        "country": countryController.text,
        "floor": floorController.text,
        "state": stateController.text
      });

      toastification.show(
        context: context,
        type: ToastificationType.success,
        style: ToastificationStyle.flat,
        title: const Text('Payment processed successfully'),
        autoCloseDuration: const Duration(seconds: 3),
      );

      Navigator.pop(context, paymentModel);
    } finally {
      if (mounted) {
        setState(() => _isProcessing = false);
      }
    }
  }
}