```
'/login': (context, {arguments}) => LoginPage(arguments: arguments),
```

```dart
class LoginPage extends StatefulWidget {
  final Map arguments;

  LoginPage({Key key, this.arguments}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState(arguments: this.arguments);
}

class _LoginPageState extends State<LoginPage> {
  Map arguments;

  _LoginPageState({this.arguments});
}
```

```
Navigator.pushNamed(context, '/login', arguments: {"checkCode": 123456});
```