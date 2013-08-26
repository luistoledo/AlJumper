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
        self.view:loadASCIIMap(1)
    end,

    onUpdate = function (self)
        self.view:collide(self.player)
        if the.keys:pressed('escape') then
            the.app:quit()
        end

        if the.keys:pressed('n') then
            self.view = Levels:new()
            local x = self.view.currentLevel + 1
            print('-'..x)
            self.view:loadASCIIMap(x)
        end
    end
}
