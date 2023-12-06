-- Assets
assets = require('load_assets')
push = require "libraries/push"

-- Globals 5:4 ratio
WIDTH = 1250
HEIGHT = 1000

virtual_WIDTH = 800
virtual_HEIGHT = 640

cellSize = virtual_WIDTH / assets.level_datas[1]:getWidth()
player_positions = {}
player_start_pos = {}
