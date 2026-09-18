/// @description Clean

if surface_exists(surf)
{
    surface_free(surf)
	layer_clear_fx("Instances_general")
}