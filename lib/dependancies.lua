dependancies = Class{}
push = require 'lib/push'
Camera = require 'lib/Camera'
screen = require "lib/shack"

require 'lib/constants'
require 'lib/StateMachine'

require 'states/BaseState'
require 'states/CountdownState'
require 'states/PlayState'
require 'states/ScoreState'
require 'states/TitleScreenState'
