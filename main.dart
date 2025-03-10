import 'dart:io';

class Product {
  String name;
  int price;

  Product(this.name, this.price);
}

class ShoppingMall {
  List<Product> products = [];
  int totalPrice = 0;

  ShoppingMall() {
    products = [
      Product('셔츠', 45000),
      Product('원피스', 30000),
      Product('반팔티', 35000),
      Product('반바지', 38000),
      Product('양말', 5000),
    ];
  }

  void showProducts() {
    for (var product in products) {
      print('${product.name} / ${product.price}원');
    }
  }

  void addToCart(String productName, int quantity) {
    var product = products.firstWhere(
      (p) => p.name == productName,
      orElse: () => Product('', 0),
    );

    if (product.name == '') {
      print('입력값이 올바르지 않아요!');
    } else if (quantity <= 0) {
      print('0개보다 많은 개수의 상품만 담을 수 있어요!');
    } else {
      totalPrice += product.price * quantity;
      print('장바구니에 상품이 담겼어요!');
    }
  }

  void showTotal() {
    print('장바구니에 ${totalPrice}원 어치를 담으셨네요!');
  }
}

void main() {
  var shoppingMall = ShoppingMall();
  bool isRunning = true;

  while (isRunning) {
    print(
      '[1] 상품 목록 보기 / [2] 장바구니에 담기 / [3] 장바구니에 담긴 상품의 총 가격 보기 / [4] 프로그램 종료',
    );
    String? input = stdin.readLineSync();

    switch (input) {
      case '1':
        shoppingMall.showProducts();
        break;
      case '2':
        print('상품 이름을 입력하세요:');
        String? productName = stdin.readLineSync();
        print('상품 개수를 입력하세요:');
        String? quantityInput = stdin.readLineSync();
        int? quantity = int.tryParse(quantityInput ?? '');

        if (productName != null && quantity != null) {
          shoppingMall.addToCart(productName, quantity);
        } else {
          print('입력값이 올바르지 않아요!');
        }
        break;
      case '3':
        shoppingMall.showTotal();
        break;
      case '4':
        isRunning = false;
        print('이용해 주셔서 감사합니다 ~ 안녕히 가세요!');
        break;
      default:
        print('지원하지 않는 기능입니다! 다시 시도해 주세요 ..');
    }
  }
}
