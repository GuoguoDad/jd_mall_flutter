enum EnvEnum {
  host("host");

  const EnvEnum(this.value);

  final String value;
}

final Map<String, dynamic> dev = {
  EnvEnum.host.value: "http://172.20.10.2:8091",
};

final Map<String, dynamic> prd = {
  EnvEnum.host.value: "https://server.guoguodad.cn",
};
