DEBUG = true
STRICT = true

require 'zoetrope'
require 'utils/tools'
require 'Levels'
require 'Player'
require 'maps'

the.app = App:new
{
    onRun = function (self)
        self.view = Levels:new()
        self.player = Player:new({ x = self.view.xPlayer,
                                 y = self.view.yPlayer })

        self.view:add(self.player)
    end,

    onUpdate = function (self)
        self.view:collide(self.player)
        if the.keys:pressed('escape') then
            the.app:quit()
        end
    end
}
