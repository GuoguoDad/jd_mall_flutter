enum EnvEnum {
  host("host");

  const EnvEnum(this.value);

  final String value;
}

final Map<String, dynamic> dev = {
  EnvEnum.host.value: "http://192.168.1.3:8091",
};

final Map<String, dynamic> prd = {
  EnvEnum.host.value: "https://server.guoguodad.cn",
};
