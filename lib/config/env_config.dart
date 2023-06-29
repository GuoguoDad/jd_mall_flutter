enum EnvKey {
  host("host");

  const EnvKey(this.value);

  final String value;
}

final Map<String, dynamic> dev = {
  EnvKey.host.value: "http://127.0.0.1:8091",
};

final Map<String, dynamic> prd = {
  EnvKey.host.value: "https://api.example.com",
};
