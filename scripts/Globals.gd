extends Node

enum DamageType{
	default = 0,
	normal = 1,
	gravity = 2,
	sacrifice = 3,
	lock = 4,
	maxhealth = 5,
	weak = 6,
}

enum BuffType{
	default = 0,
	lock = 1,
	weak = 2,
}

var WinFloors = 20

var FLOOR_HEIGHT = 60

var FLOOR_OCCUPY_HEIGHT = 60
