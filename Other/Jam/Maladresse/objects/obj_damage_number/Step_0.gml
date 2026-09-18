/// @description Increment timer

switch step
{
	case 0:
		t += spd

		if t >= 1
		{
			step = 1
			alarm[0] = 60
		}
		break
	case 1:
		break
}