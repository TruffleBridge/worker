class CreateProfileData {
  // Step 1 — Who are you?
  String fullName = '';
  String dateOfBirth = '';
  String mobileNumber = '';
  String email = '';
  String gender = '';
  String? idProofFileName;

  // Step 2 — Business details
  String businessName = '';
  String abn = '';
  String acn = '';
  String address = '';
  String suburb = '';
  String state = '';
  String postcode = '';

  // Step 3 — Mandatory documents
  final Map<String, bool> mandatoryDocs = {
    'NDIS Certificate of Registration': false,
    'NDIS Audit Certificate': false,
    'Public Liability Insurance': false,
    'Professional Indemnity Insurance': false,
    'Workers Compensation Insurance': false,
    'Incident Management Policy': false,
    'Complaints Management Policy': false,
    'Privacy Policy': false,
    'WHS Policy': false,
  };

  // Step 4 — Recommended documents
  final Map<String, bool> recommendedDocs = {
    'Annual Compliance Declaration': false,
    'Risk Management Policy': false,
    'Infection Control Policy': false,
    'Restrictive Practice Policy': false,
  };
}