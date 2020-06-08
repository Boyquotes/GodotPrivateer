extends Node

var city = null
var product = null
var price = 0

func _ready():
	pass

func _init(_city, _product):
	city = _city
	product = _product
	GetRandomPrice()

func GetRandomPrice():
	price =  product.CalculatePrice()
