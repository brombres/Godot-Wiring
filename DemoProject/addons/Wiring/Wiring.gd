extends Node

var _cached_scene:Node
var _cache := {}

## Clears the node cache. Note: this happens automatically when the scene changes.
func clear_cache():
	_cache = {}

func _get( node_name:StringName )->Variant:
	var cur_scene = _get_current_scene( node_name )
	if not cur_scene: return null

	if _cache.has(node_name):
		return _cache[node_name]

	var node = _cached_scene.find_child( node_name, true, false )
	if node:
		_cache[node_name] = node
		return node

	push_error( "[Wiring] No such node in current scene: %s" % [node_name] )
	return null

func _get_current_scene( node_name:StringName )->Variant:
	var cur_scene = get_tree().current_scene
	if not cur_scene:
		push_warning( "[Wiring] No current scene when accessing Wiring.%s" % [node_name] )
		return null

	if _cached_scene != cur_scene:
		_cached_scene = cur_scene
		_cache = {}

	return cur_scene

func _set( node_name:StringName, value:Variant ):
	_get_current_scene( node_name )  # clears the cache if necessary
	_cache[ node_name ] = value
	return true
