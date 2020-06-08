extends Panel

var product = null

func _ready():
	pass

func init(_product):
	product = _product

func UpdateUI(_product_name):
	$ProductName.text = _product_name

func Update_Price(price):
	$Price.text = "$" + str(price)
