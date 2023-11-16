extends Node

enum DamageType{
	default = 0,
	normal = 1,
	gravity = 2,
	sacrifice = 3,
	lock = 4,
}

enum BuffType{
	default = 0,
	lock = 1,
}

var WinFloors = 20

var FLOOR_HEIGHT = 60

var FLOOR_OCCUPY_HEIGHT = 60
