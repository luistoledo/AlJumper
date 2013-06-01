DEBUG = true
STRICT = true

require 'zoetrope'
require 'tools'
require 'Levels'
require 'Player'

the.app = App:new
{
    onRun = function (self, level)
        if level == nil then level = 1 end

        self.levels = Levels:new()
        self.levels.platforms = self.levels:createLevel(level)
        self.player = Player:new({ x = self.levels.xPlayer,
                                 y = self.levels.yPlayer })

        self:add(self.levels.platforms)
        self:add(self.player)
    end,

    onUpdate = function (self)
        self.levels.platforms:collide(self.player)
        if the.keys:pressed('escape') then
            the.app:quit()
        end
    end,

    gotoNextLevel = function (self)
        self.levels.sprites = {}
        self.levels.platforms = {}
        self:onRun(2)
    end
}
