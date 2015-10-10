require 'simplecov'
require 'test/unit'
require 'gosu'
require 'texplay'
SimpleCov.start do
	@filters = []
	add_filter 'test'
end
require '../lib/base_collision'
require '../lib/constructor'
require '../lib/player'
require '../lib/tile'
require '../lib/sprite'
require '../lib/point'
require '../lib/virtual_model'
require '../lib/map'
require '../lib/unit'
require '../lib/menu'
#require '../lib/mapGeneratorStatic1'
