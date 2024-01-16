extends Node

var _active_scene:Node
var _node_cache := {}

func _get( node_name:StringName )->Variant:
	var cur_scene = get_tree().current_scene
	if not cur_scene:
		push_warning( "[Wiring] No current scene when accessing Wiring.%s" % [node_name] )
		return null

	if _active_scene != cur_scene:
		_active_scene = cur_scene
		_node_cache = {}

	if _node_cache.has(node_name):
		return _node_cache[node_name]

	var node = _active_scene.find_child( node_name )
	if node:
		_node_cache[node_name] = node
		return node

	push_error( "[Wiring] No such node in current scene: %s" % [node_name] )
	return null

func _set( node_name:StringName, value:Variant ):
	_node_cache[ node_name ] = value
	return true
