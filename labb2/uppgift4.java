import java.util.Random;

public class uppgift4 {
  public static void main(String[] args) {
    Hero aragorn      = new Hero("Aragorn",100,30);
    Monster smallorc  = new Monster("Small Orc",50,10,15);
    Monster bigorc    = new Monster("Big Orc",70,15,25);
    Monster witchking = new Monster("Witch King",300,50,100);

    Game game = new Game();

    game.fight(aragorn,smallorc);
    //game.fight(aragorn,bigorc);
    game.fight(aragorn,witchking);
}
}

class Character {
  private String name;
  private int hp;
  private int damage;

  public Character(String name, int hp, int damage) {
    this.name = name;
    this.hp = hp;
    this.damage = damage;
  }

  public String getName() {
    return name;
  }

  public int getDamage() {
    return damage;
  }

  public int getHP() {
    return hp;
  }

  public boolean isDead() {
    return hp <= 0;
  }

  void incDamage(int x) {
    hp += x;
  }

  void incHP(int x) {
    hp += x;
  }

  void decHP(int x) {
    hp -= x;
  }
}

//Monster subclass that gives xp
class Monster extends Character {

  private int giveExp;

  public Monster(String name, int hp, int damage, int giveExp) {
    super(name, hp, damage);
    this.giveExp = giveExp;
  }

  public int getGiveExp() {
    return giveExp;
  }

}

//Hero subclass with exp and level
class Hero extends Character {

  private int exp;
  private int level;

  public Hero(String name, int hp, int damage) {
    super(name, hp, damage);
    this.exp = 0;
    this.level = 0;
  }

  public int getExp() {
    return exp;
  }

  public int getLevel() {
    return level;
  }

  public void levelUp(int x) {
    level += x;
    incDamage(x * 5);
    incHP(x * 10);
    System.out.println(getName() + " level up!");
    System.out.println("current level: " + getLevel());
  }

  public void incExp(int x) {
    exp += x;

    System.out.println("Current exp: " + getExp());

    int incAmount = (exp - level * 10) / 10;

    if(incAmount > 0) {
      levelUp(incAmount);
    }
  }

}

//Game class that simulates a fight between a monster and a hero
class Game {

  Random rand = new Random();

  void fight(Hero hero, Monster monster) {
    if(hero.isDead()) {
      System.out.println("The hero is dead and can't fight");
      return;
    }

    if(monster.isDead()) {
      System.out.println("The hero is dead and can't fight");
      return;
    }

    System.out.println( 
      hero.getName() + " is going to fight " + monster.getName());

    while(!(hero.isDead() || monster.isDead())) {
      int x = rand.nextInt(100);
      boolean hit = x + 10 * hero.getLevel() > 50;
      
      if (hit) {
          printFight(hero.getName(), monster.getName(), hero.getDamage());
          monster.decHP(hero.getDamage());
      } else {
          printFight(monster.getName(), hero.getName(), monster.getDamage());
          hero.decHP(monster.getDamage());
      }
    }

    if(monster.isDead()) {
      System.out.println(
        hero.getName() + " won the fight and got " + monster.getGiveExp() + " xp");

      hero.incExp(monster.getGiveExp());
    }

    if(hero.isDead()) {
      System.out.println(
        monster.getName() + " won the fight and killed " + hero.getName());
    }
  }

  private void printFight(String attacker, String defender, int damage) {
    System.out.println(
        attacker + " hits " + defender + " and does " 
        + damage + " damage!");
  }
}
