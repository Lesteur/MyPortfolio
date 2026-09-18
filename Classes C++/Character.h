#include <string>

namespace C
{
	class Character
	{
		std::string name;
		int hp_max;
		int hp;
		int sp_max;
		int sp;

		int attack;
		int defense;
		int magic_attack;
		int magic_defense;

		public:
			Character(std::string _name, int _hp_max, int _sp_max, int _attack, int _defense, int _magic_attack, int _magic_defense);
			bool is_alive() const;
			void get_attack(int attack, int type);
			void attack_character(int power, int type, Character &target);
	};
}