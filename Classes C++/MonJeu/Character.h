#include <string>

namespace C
{
    struct Stats
    {
        int hp_max;
		int sp_max;

		int attack;
		int defense;
		int magic_attack;
		int magic_defense;
    }

    struct Skill
    {
        int kind;
        int potency;
    }

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
			Character(std::string _name, Stats _stats);
			bool is_alive() const;
			void get_damage(int damage, int type);
			void use_skill(Skill skill, Character &target);
	};
}