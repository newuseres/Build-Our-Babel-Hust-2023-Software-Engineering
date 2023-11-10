extends Node

enum FloorType{
	default =0,
	gun = 1,
	mine =2
}

enum AttackType{
	default = 0,
	straight = 1,
	blow = 2,
}

enum DamageType{
	default = 0,
	normal = 1,
	gravity = 2,
	sacrifice = 3,
}

var WinFloors = 20
