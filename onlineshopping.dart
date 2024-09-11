import 'dart:io';

// Function to calculate the total price with optional tax
double calculateTotal(List<double> prices, {double taxRate = 0.0}) {
  double total = prices.fold(0.0, (sum, price) => sum + price);
  return total + (total * taxRate);
}

// Anonymous function to filter out items below a certain threshold
List<double> filterItems(List<double> prices, double threshold) {
  return prices.where((price) => price >= threshold).toList();
}

// Higher-Order Function to apply a discount
List<double> applyDiscount(List<double> prices, double Function(double) discountFunction) {
  return prices.map((price) => discountFunction(price)).toList();
}

// Recursive function to calculate the factorial of a number
double calculateFactorial(int n) {
  if (n <= 1) return 1.0;
  return n * calculateFactorial(n - 1);
}

// Recursive function to calculate a special discount
double calculateFactorialDiscount(int numberOfItems) {
  double factorial = calculateFactorial(numberOfItems);
  return factorial / 100.0; // Convert factorial to a percentage
}

void main() {
  // Input: List of item prices
  print("Enter item prices separated by spaces (e.g., 20 15 8 30):");
  List<double> prices = stdin.readLineSync()!.split(' ').map(double.parse).toList();

  // Input: Tax rate
  print("Enter tax rate as a percentage (e.g., 7 for 7%):");
  double taxRate = double.parse(stdin.readLineSync()!) / 100.0;

  // Input: Discount percentage
  print("Enter discount percentage (e.g., 10 for 10%):");
  double discountPercentage = double.parse(stdin.readLineSync()!) / 100.0;

  // Apply discount to items
  List<double> discountedPrices = applyDiscount(prices, (price) => price * (1 - discountPercentage));

  // Filter out items under a certain threshold
  print("Enter price threshold to filter items (e.g., 10):");
  double threshold = double.parse(stdin.readLineSync()!);
  List<double> filteredPrices = filterItems(discountedPrices, threshold);

  // Calculate the total price after applying discount and tax
  double totalPrice = calculateTotal(filteredPrices, taxRate: taxRate);

  // Calculate special factorial discount and apply it to the final price
  double factorialDiscount = calculateFactorialDiscount(filteredPrices.length);
  double finalPrice = totalPrice * (1 - factorialDiscount);

  // Display results
  print("Final price after discount and tax: \$${finalPrice.toStringAsFixed(2)}");
}
