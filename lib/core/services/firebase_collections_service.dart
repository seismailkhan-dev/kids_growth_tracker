import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseCollectionService {
  static const companyCollection = 'companies';
  static const vehiclesCollection = 'vehicles';
  static const expenseCollection = 'expenses';
  static const tripsCollection = 'trips';
  static const driversCollection = 'drivers';
  static const adminsCollection = 'admins';
  static const usersCollection = 'users';
  static const expenseCategoriesCollection = 'expense_categories';
  static const maintainanceCategoriesCollection = 'maintenance_categories';
  static const walletCollection = 'wallet';
  static const globalExpenseCategoriesCollection = 'global_expense_categories';

  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// ================= TOP-LEVEL COLLECTIONS =================
  static CollectionReference get companies =>
      _firestore.collection(companyCollection);

  static CollectionReference get globalExpenseCategories =>
      _firestore.collection(globalExpenseCategoriesCollection);

  static CollectionReference get vehicles =>
      _firestore.collection(vehiclesCollection);

  static CollectionReference get expenses =>
      _firestore.collection(expenseCollection);

  static CollectionReference get trips =>
      _firestore.collection(tripsCollection);

  static CollectionReference get drivers =>
      _firestore.collection(driversCollection);

  static CollectionReference get admins =>
      _firestore.collection(adminsCollection);


  static CollectionReference get users =>
      _firestore.collection(usersCollection);

  static CollectionReference get expenseCategories =>
      _firestore.collection(expenseCategoriesCollection);

  static CollectionReference get maintenanceCategories =>
      _firestore.collection(maintainanceCategoriesCollection);

  static CollectionReference get wallet =>
      _firestore.collection(walletCollection);

  /// ================= NESTED COLLECTIONS (COMPANY LEVEL) =================
  static CollectionReference companyDrivers(String companyId) =>
      _firestore.collection(companyCollection).doc(companyId).collection(driversCollection);

  static CollectionReference companyAdmins(String companyId) =>
      _firestore.collection(companyCollection).doc(companyId).collection(adminsCollection);

  static CollectionReference companyVehicles(String companyId) =>
      _firestore.collection(companyCollection).doc(companyId).collection(vehiclesCollection);

  static CollectionReference companyTrips(String companyId) =>
      _firestore.collection(companyCollection).doc(companyId).collection(tripsCollection);

  static CollectionReference companyExpenses(String companyId) =>
      _firestore.collection(companyCollection).doc(companyId).collection(expenseCollection);

  static CollectionReference companyWallet(String companyId) =>
      _firestore.collection(companyCollection).doc(companyId).collection(walletCollection);

  static CollectionReference companyExpenseCategories(String companyId) =>
      _firestore.collection(companyCollection).doc(companyId)
          .collection(expenseCategoriesCollection);

  /// ================= DOCUMENT REFERENCES =================

  /// Specific company
  static DocumentReference companyDoc(String companyId) =>
      _firestore.collection(companyCollection).doc(companyId);

  /// Specific driver
  static DocumentReference driverDoc(String companyId, String driverId) =>
      _firestore.collection(companyCollection).doc(companyId)
          .collection(driversCollection).doc(driverId);


  static DocumentReference adminDoc(String companyId, String driverId) =>
      _firestore.collection(companyCollection).doc(companyId)
          .collection(adminsCollection).doc(driverId);

  /// Specific vehicle
  static DocumentReference vehicleDoc(String companyId, String vehicleId) =>
      _firestore.collection(companyCollection).doc(companyId)
          .collection(vehiclesCollection).doc(vehicleId);

  /// Specific trip
  static DocumentReference tripDoc(String companyId, String tripId) =>
      _firestore.collection(companyCollection).doc(companyId)
          .collection(tripsCollection).doc(tripId);

  /// Specific expense
  static DocumentReference expenseDoc(String companyId, String expenseId) =>
      _firestore.collection(companyCollection).doc(companyId)
          .collection(expenseCollection).doc(expenseId);

  /// Specific wallet record
  static DocumentReference walletDoc(String companyId, String walletId) =>
      _firestore.collection(companyCollection).doc(companyId)
          .collection(walletCollection).doc(walletId);

  /// Specific user (admin)
  static DocumentReference userDoc(String userId) =>
      _firestore.collection(usersCollection).doc(userId);
}
