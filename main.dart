import 'dart:io';
import 'dart:math';

// 캐릭터 클래스: 플레이어와 몬스터의 공통 속성과 메서드를 정의
class Character {
  String name;
  int maxHealth;
  int currentHealth;
  int attackPower;

  Character(this.name, this.maxHealth, this.attackPower)
      : currentHealth = maxHealth;

  // 공격 메서드: 대상에게 피해를 입힘
  void attack(Character target) {
    int damage = attackPower;
    target.currentHealth -= damage;
    print('$name이(가) ${target.name}에게 $damage의 피해를 입혔습니다.');
  }

  // 생존 여부 확인 메서드
  bool isAlive() {
    return currentHealth > 0;
  }
}

// 플레이어 클래스: Character를 상속받아 추가 기능 구현
class Player extends Character {
  int experience = 0;
  int level = 1;

  Player(String name) : super(name, 100, 10);

  // 경험치 획득 및 레벨 업 메서드
  void gainExperience(int exp) {
    experience += exp;
    print('$name이(가) $exp의 경험치를 획득했습니다.');
    if (experience >= level * 10) {
      levelUp();
    }
  }

  // 레벨 업 메서드
  void levelUp() {
    level++;
    maxHealth += 10;
    attackPower += 2;
    currentHealth = maxHealth;
    experience = 0;
    print('$name이(가) 레벨 $level로 상승했습니다! 체력과 공격력이 증가했습니다.');
  }
}

// 몬스터 클래스: Character를 상속받아 추가 기능 구현
class Monster extends Character {
  Monster(String name, int maxHealth, int attackPower)
      : super(name, maxHealth, attackPower);
}

// 전투 함수: 플레이어와 몬스터 간의 전투를 진행
void battle(Player player, Monster monster) {
  print('${monster.name}이(가) 나타났습니다!');
  while (player.isAlive() && monster.isAlive()) {
    print('\n${player.name}의 턴입니다.');
    print('1. 공격하기');
    print('2. 도망치기');
    stdout.write('선택: ');
    String? input = stdin.readLineSync();
    if (input == '1') {
      player.attack(monster);
      if (!monster.isAlive()) {
        print('${monster.name}을(를) 물리쳤습니다!');
        player.gainExperience(10);
        break;
      }
    } else if (input == '2') {
      print('${player.name}이(가) 도망쳤습니다.');
      break;
    } else {
      print('잘못된 입력입니다. 다시 선택해주세요.');
      continue;
    }
    if (monster.isAlive()) {
      print('\n${monster.name}의 턴입니다.');
      monster.attack(player);
      if (!player.isAlive()) {
        print('${player.name}이(가) 쓰러졌습니다. 게임 오버.');
        break;
      }
    }
  }
}

// 메인 함수: 게임 실행
void main() {
  stdout.write('플레이어의 이름을 입력하세요: ');
  String? playerName = stdin.readLineSync();
  if (playerName == null || playerName.isEmpty) {
    playerName = '플레이어';
  }
  Player player = Player(playerName);
  print('\n${player.name}의 모험이 시작됩니다!\n');

  // 무작위 몬스터 생성 및 전투 시작
  List<Monster> monsters = [
    Monster('고블린', 30, 5),
    Monster('오크', 50, 8),
    Monster('드래곤', 100, 15)
  ];
  Random random = Random();
  while (player.isAlive()) {
    Monster monster = monsters[random.nextInt(monsters.length)];
    battle(player, monster);
    if (!player.isAlive()) {
      print('게임 오버. ${player.name}의 모험이 끝났습니다.');
      break;
    }
    print('\n다음 전투를 준비합니다...\n');
  }
}