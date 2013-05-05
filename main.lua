require 'zoetrope'
require 'Levels'
require 'Player'
repler = require 'repler'

the.app = App:new
{
    onRun = function (self)
        self.levels = Levels:new()
        self.levels.platforms = self.levels:createLevel(self.levels.level1)
        self.player = Player:new({ x = self.levels.xPlayer,
                                 y = self.levels.yPlayer })

        self:add(self.levels.platforms)
        self:add(self.player)
        -- self.platforms = Group:new()
        -- self.platforms:add(Platform:new({ x = 0, y = 400 }))
        -- self:add(self.platforms)
    end,

    onUpdate = function (self)
        self.levels.platforms:collide(self.player)
        if the.keys:pressed('escape') then
            the.app:quit()
        end
        if the.keys:pressed('c') then
            debug.debug()
            -- repler.load()
        end
    end
}
