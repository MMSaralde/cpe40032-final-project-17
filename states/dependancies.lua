dependancies = Class{}

Camera = require 'lib/Camera'
screen = require "lib/shack"

require 'lib/intro'
require 'lib/Util'
require 'states/constants'
require 'lib/StateMachine'
require 'states/BaseState'
require 'states/CountdownState'
require 'states/PlayState'
require 'states/ScoreState'
require 'states/TitleScreenState'
require 'states/TutorialState'

require 'states/HighScoreState'
require 'states/EnterHighScoreState'

