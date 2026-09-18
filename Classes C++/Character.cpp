#include "Character.h"
#include <iostream>

using namespace std;
using namespace C;

Character::Character(string _name, int _hp_max, int _sp_max, int _attack, int _defense, int _magic_attack, int _magic_defense)
{
	name = _name;
	hp_max = _hp_max;
	hp = _hp_max;
	sp_max = _sp_max;
	sp = _sp_max;

	attack = _attack;
	defense = _defense;
	magic_attack = _magic_attack;
	magic_defense = _magic_defense;
}

bool Character::is_alive() const
{
	return (hp > 0);
}

void Character::get_attack(int attack, int type)
{
	int damage;
	if (type == 0)
	{
		int damage = (attack/defense);
	} else {
		int damage = (attack/magic_defense);
	}
	hp -= damage;
	cout << name << " subit " << damage << " points de dégâts !" << endl;
	if (!is_alive()) { hp = 0; }
}

/*
{
	int damage = (attack/defense);
	hp -= damage;
	cout << name << " subit " << damage << " points de dégâts !" << endl;
	if (hp < 0)
	{
		hp = 0;
	}
}
*/

void Character::attack_character(int power, int type, Character &target)
{
	int damage;
	if (type == 0)
	{
		damage = power * attack;
	} else {
		damage = power * magic_attack;
	}
	cout << name << " attaque " << target.name << " !" << endl;
	target.get_attack(damage, type);
}