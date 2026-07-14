import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'client_profile_event.dart';
import 'client_profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(const ProfileState()) {
    on<LoadProfileEvent>(_loadProfile);

    on<PickDocumentEvent>(_pickDocument);
    on<RemoveDocumentEvent>(_removeDocument);
    on<UploadDocumentEvent>(_uploadDocument);
    on<ResetUploadSuccessEvent>(_resetUploadSuccess);
    on<ToggleNewMessagesEvent>(_toggleNewMessages);
    on<ToggleJobUpdatesEvent>(_toggleJobUpdates);
    on<TogglePaymentAlertsEvent>(_togglePaymentAlerts);
    on<ToggleDocumentAlertsEvent>(_toggleDocumentAlerts);

    on<AddPaymentCardEvent>(_addCard);
    on<RemovePaymentCardEvent>(_removeCard);
    on<RemoveSelectedDocumentEvent>(_removeSelectedDocument);
    on<ToggleTwoFactorEvent>(_toggleTwoFactor);
    on<UpdatePasswordEvent>(_updatePassword);
    on<UpdatePersonalInformationFieldEvent>(
      _updatePersonalInformationField,
    );

    on<SignOutEvent>(_logout);
  }


  // Load Profile


  Future<void> _loadProfile(
      LoadProfileEvent event,
      Emitter<ProfileState> emit,
      ) async {
    emit(state.copyWith(loading: true));

    await Future.delayed(const Duration(milliseconds: 600));

    emit(
      state.copyWith(
        loading: false,
        name: "Margaret Liu",
        email: "margaret@gmail.com",
        profileImage: "assets/images/profile.jpg",
        paymentCards: const [
          PaymentCardModel(
            cardName: "Visa ending 4242",
            expiry: "Expires 12/26",
            isDefault: true,
          ),
          PaymentCardModel(
            cardName: "Mastercard ending 8871",
            expiry: "Expires 08/25",
          ),
        ],
      ),
    );
  }


  // Pick Document

  Future<void> _pickDocument(
      PickDocumentEvent event,
      Emitter<ProfileState> emit,
      ) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
    );

    if (result != null) {
      emit(
        state.copyWith(
          selectedDocument: result.files.first,
        ),
      );
    }
  }


  // Remove Document

  Future<void> _removeDocument(
      RemoveDocumentEvent event,
      Emitter<ProfileState> emit,
      ) async {
    final documents = List<DocumentModel>.from(state.documents);

    documents.removeAt(event.index);

    emit(
      state.copyWith(
        documents: documents,
      ),
    );
  }


  // Upload Document

  Future<void> _uploadDocument(
      UploadDocumentEvent event,
      Emitter<ProfileState> emit,
      ) async {
    if (state.selectedDocument == null) {
      emit(
        state.copyWith(
          errorMessage: "Please select a document first.",
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        loading: true,
        uploadSuccess: false,
      ),
    );

    await Future.delayed(const Duration(seconds: 2));

    final file = state.selectedDocument!;

    final document = DocumentModel(
      name: file.name,
      type: "NDIS Plan", // Replace with dropdown value later
      path: file.path ?? "",
      uploadDate: DateTime.now(),
      fileSize: file.size,
      status: "Verified",
    );

    emit(
      state.copyWith(
        loading: false,
        uploadSuccess: true,
        successMessage: "Document uploaded successfully.",
        selectedDocument: null,
        documents: [...state.documents, document],
      ),
    );
  }

  // Remove selected documents

  void _removeSelectedDocument(
      RemoveSelectedDocumentEvent event,
      Emitter<ProfileState> emit,
      ) {
    emit(
      state.copyWith(
        clearSelectedDocument: true,
      ),
    );
  }

  // Reset Upload documents

  void _resetUploadSuccess(
      ResetUploadSuccessEvent event,
      Emitter<ProfileState> emit,
      ) {
    emit(
      state.copyWith(
        uploadSuccess: false,
      ),
    );
  }


  // Notification Toggles


  void _toggleNewMessages(
      ToggleNewMessagesEvent event,
      Emitter<ProfileState> emit,
      ) {
    emit(
      state.copyWith(
        newMessages: event.value,
      ),
    );
  }

  void _toggleJobUpdates(
      ToggleJobUpdatesEvent event,
      Emitter<ProfileState> emit,
      ) {
    emit(
      state.copyWith(
        jobUpdates: event.value,
      ),
    );
  }

  void _togglePaymentAlerts(
      TogglePaymentAlertsEvent event,
      Emitter<ProfileState> emit,
      ) {
    emit(
      state.copyWith(
        paymentAlerts: event.value,
      ),
    );
  }

  void _toggleDocumentAlerts(
      ToggleDocumentAlertsEvent event,
      Emitter<ProfileState> emit,
      ) {
    emit(
      state.copyWith(
        documentAlerts: event.value,
      ),
    );
  }


  // Payment Card

  void _addCard(
      AddPaymentCardEvent event,
      Emitter<ProfileState> emit,
      ) {
    final updatedCards = List<PaymentCardModel>.from(state.paymentCards);

    // If this is the first card, make it default
    if (updatedCards.isEmpty) {
      updatedCards.add(
        PaymentCardModel(
          cardName: event.card.cardName,
          expiry: event.card.expiry,
          isDefault: true,
        ),
      );
    } else {
      updatedCards.add(event.card);
    }

    emit(
      state.copyWith(
        paymentCards: updatedCards,
        successMessage: "Payment card added successfully.",
      ),
    );
  }

  void _removeCard(
      RemovePaymentCardEvent event,
      Emitter<ProfileState> emit,
      ) {
    final updatedCards = List<PaymentCardModel>.from(state.paymentCards);

    if (event.index >= updatedCards.length) return;

    final removedCard = updatedCards[event.index];
    updatedCards.removeAt(event.index);

    // If default card removed, make first remaining card default
    if (removedCard.isDefault && updatedCards.isNotEmpty) {
      updatedCards[0] = PaymentCardModel(
        cardName: updatedCards[0].cardName,
        expiry: updatedCards[0].expiry,
        isDefault: true,
      );
    }

    emit(
      state.copyWith(
        paymentCards: updatedCards,
        successMessage: "Payment card removed successfully.",
      ),
    );
  }


  // Sign Out


  void _logout(
      SignOutEvent event,
      Emitter<ProfileState> emit,
      ) {
    emit(const ProfileState());
  }

  // Account settings
  void _toggleTwoFactor(
      ToggleTwoFactorEvent event,
      Emitter<ProfileState> emit,
      ) {
    emit(
      state.copyWith(
        twoFactorEnabled: event.enabled,
      ),
    );
  }

  Future<void> _updatePassword(
      UpdatePasswordEvent event,
      Emitter<ProfileState> emit,
      ) async {
    emit(
      state.copyWith(
        passwordUpdating: true,
        passwordError: '',
        passwordSuccess: '',
      ),
    );

    await Future.delayed(const Duration(seconds: 1));

    if (event.currentPassword.isEmpty ||
        event.newPassword.isEmpty ||
        event.confirmPassword.isEmpty) {
      emit(
        state.copyWith(
          passwordUpdating: false,
          passwordError: "All fields are required",
        ),
      );
      return;
    }

    if (event.newPassword != event.confirmPassword) {
      emit(
        state.copyWith(
          passwordUpdating: false,
          passwordError: "Passwords do not match",
        ),
      );
      return;
    }
    emit(
      state.copyWith(
        passwordUpdating: false,
        passwordSuccess: "Password updated successfully",
      ),
    );
  }

  void _updatePersonalInformationField(
      UpdatePersonalInformationFieldEvent event,
      Emitter<ProfileState> emit,
      ) {
    switch (event.field) {
      case "name":
        emit(
          state.copyWith(
            name: event.value,
          ),
        );
        break;

      case "email":
        emit(
          state.copyWith(
            email: event.value,
          ),
        );
        break;

      case "phone":
        emit(
          state.copyWith(
            phone: event.value,
          ),
        );
        break;

      case "dob":
        emit(
          state.copyWith(
            dob: event.value,
          ),
        );
        break;
    }
  }
}