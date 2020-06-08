extends Panel

var city = preload("res://Scripts/City.gd")
var product = preload("res://Scripts/Product.gd")
var city_product = preload("res://Scripts/CityProduct.gd")
var product_panel = preload("res://Scenes/ProductPanel.tscn")


var cash = 250
var firm_name = "Godot Privateer"
var city_data = [{'name': "Hong Kong"}, {'name': "Shanghai"}, {'name': "Nagasaki"}, {'name': "Manila"}]
var product_data = [{'name': "General Goods", 'min_price': 1, 'max_price': 16},
					{'name': "Arms", 'min_price': 3, 'max_price': 21},
					{'name': "Silk", 'min_price': 5, 'max_price': 26},
					{'name': "Opium", 'min_price': 10, 'max_price': 31}]
var cities = []
var products = []
var current_city_index = 0

func _ready():
	CreateProducts()
	CreateProductPanels()
	CreateCities()
	CreateCityProducts()
	PrintCityProducts()
	ArriveAtPort()
	UpdateUI()

func CreateCities():
	for _city in city_data:
		var current_city = city.new()
		current_city.city_name = _city.name
		cities.append(current_city)

func CreateProducts():
	for _product in product_data:
		var current_product = product.new(_product.name, _product.min_price, _product.max_price)
		products.append(current_product)

func ArriveAtPort():
	for _city_product in cities[current_city_index].city_products:
		randomize()
		if randf() > 0.5:
			_city_product.GetRandomPrice()
		_city_product.product.product_panel.Update_Price(_city_product.price)

func CreateProductPanels():
	for _product in products:
		_product.product_panel = product_panel.instance()
		_product.product_panel.init(_product)
		_product.product_panel.UpdateUI(_product.product_name)
		$ProductListContainer.add_child(_product.product_panel)

func CreateCityProducts():
	for _city in cities:
		for _product in products:
			var _city_product = city_product.new(_city, _product)
			_city.city_products.append(_city_product)

func PrintCityProducts():
	for _city in cities:
		for _city_product in _city.city_products:
			print("City: %s, Product: %s, Price: $%s" \
			%[_city_product.city.city_name, _city_product.product.product_name, _city_product.price])

func UpdateUI():
	$FirmLabel.text = firm_name
	$CashLabel.text = "Cash: $" + str(cash)
	$CityLabel.text = "City: " + cities[current_city_index].city_name

func DepartFromCity(_new_city_index):
	if current_city_index != _new_city_index:
		current_city_index = _new_city_index
		# Check for Pirates
		ArriveAtPort()
		UpdateUI()
