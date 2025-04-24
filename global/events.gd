extends Node

func delayed(callable : Callable, delay : float):
	get_tree().create_timer(delay, false).connect("timeout", callable)

func delayed_set(target, propertyName, delay, value):
	get_tree().create_timer(delay, false).connect("timeout", target.set.bind(propertyName, value))

func delayed_destroy(target : Node2D, delay : float):
	delayed(func(): target.queue_free(), delay)
