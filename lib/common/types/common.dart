typedef VoidCallback = void Function();

typedef ValueCallback<T> = void Function(T value);

typedef RefreshCallback = void Function(VoidCallback successCallback, VoidCallback errorCallback);
