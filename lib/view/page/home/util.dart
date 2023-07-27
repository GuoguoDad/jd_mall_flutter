double calc2Top(double scrollY) {
  double result = 45;
  if (scrollY > 0 && scrollY <= 45) {
    result -= scrollY * 0.92;
  } else if (scrollY <= 0) {
    result = 45;
  } else {
    result = 45 * 0.08;
  }
  return result;
}

double calcWidth(double scrollY) {
  double result = 32;
  if (scrollY > 0 && scrollY <= 45) {
    result += scrollY * 2;
  } else if (scrollY <= 0) {
    result = 32;
  } else {
    result = 45 * 2 + 32;
  }
  return result;
}
