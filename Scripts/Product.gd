extends Node

var product_name = "[Product Name]"
var min_price = 3
var max_price = 15

var product_panel = null

func _ready():
	pass

func _init(_product_name, _min_price, _max_price):
	product_name = _product_name
	min_price = _min_price
	max_price = _max_price

func CalculatePrice():
	randomize()
	return int(rand_range(min_price, max_price))
