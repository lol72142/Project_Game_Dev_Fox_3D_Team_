extends Node

const Max_food: int = 7

var Current_HP_Player: int = 3
var Current_Number_Food: int = 0
var Current_Enemy_speed: float = 10.0

signal Get_Hit()
signal Deposit_food()
signal Sta_dis(num_sta)
