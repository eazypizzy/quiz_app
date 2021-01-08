class User {
  final String _userId;
  final String _username;
  final String _email;
  final String _password;

  User(this._userId, this._username, this._email, this._password);

  get name => _username;
  get email => _email;
  get password => _password;
  get userId => _userId;
}
