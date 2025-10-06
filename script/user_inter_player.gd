extends Control

func _ready() -> void:
	GlobalValSignal.connect("Get_Hit", hp_label_change)
	GlobalValSignal.connect("Deposit_food", food_label_change)
	GlobalValSignal.connect("Sta_dis", sta_label_change)

func food_label_change():
	var pre_text = str(GlobalValSignal.Current_Number_Food) + " / 7"
	$food_display_label/food_label.text = pre_text

func hp_label_change():
	var pre_text = str(GlobalValSignal.Current_HP_Player) + " / 3"
	$hp_display_label/hp_label.text = pre_text

func sta_label_change(cur_sta):
	var pre_text = str(cur_sta) + " / 100"
	$Stamina_display_label/sta_label.text = pre_text
