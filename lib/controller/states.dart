abstract class AppStates {}

class InitialState extends AppStates {}

class ChangeModeState extends AppStates {}

class ChangeColorState extends AppStates {}

class SelectRepeateState extends AppStates {}

class SelectRemaindState extends AppStates {}

// Database states

class CreateDatabaseState extends AppStates {}

class InsertDatabaseState extends AppStates {}

class GetDatabaseState extends AppStates {}

class DeleteDatabaseState extends AppStates {}

class UpdateDatabaseState extends AppStates {}
