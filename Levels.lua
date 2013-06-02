Levels = View:extend {
  
  onNew = function(self)
    self:loadASCIIMap(1)
    self.focus = the.player
  end,
  
  loadASCIIMap = function(self, levelNumber)
    level = Maps[levelNumber]

    for i,v in ipairs(level) do
      for j=0, #v do
        if (v:sub(j,j) == '#') then
          self:add(Platform:new({x=(j-1)*Platform.width, y=(i-1)*Platform.height}))
        end
        if (v:sub(j,j) == '@') then
          self:add(Impassable:new({x=(j-1)*Impassable.width, y=(i-1)*Impassable.height}))
        end
        if (v:sub(j,j) == 'P') then
          self.xPlayer, self.yPlayer = (j-1)*Platform.width, (i-1)*Platform.height
        end
        if (v:sub(j,j) == '~') then
          self:add(Water:new({x=(j-1)*Water.width, y=(i-1)*Water.height}))
        end
      end
    end
  end
}

Platform = Tile:extend
{
    width = 32,
    height = 32,
    image = 'brick.png',

    onCollide = function (self, other, horizontal)
        if horizontal < 0 then
            self:displace(other)
        end
    end
}

Impassable = Tile:extend
{
    width = 32,
    height = 32,
    image = 'impassable.png',

    onCollide = function (self, other, horizontal)
      self:displace(other)
    end
}

Water = Animation:extend
{
    width = 32,
    height = 32,
    image = 'water.png',

    sequences = {
      move1 = { frames = {3, 3, 3, 3, 1, 2}, fps = 1 },
      move2 = { frames = {1, 3, 3, 2}, fps = 1 },
      move3 = { frames = {3, 3, 2, 3, 3}, fps = 1 }
    },

    seq = 'move1',

    onNew = function ( self )
      self:onEndSequence()
    end,

    onEndSequence = function ( self )
      local seqs = {'move1', 'move2', 'move3'}
      self.seq = seqs[math.random(#seqs)]
    end,

    onUpdate = function ( self )
        self:play(self.seq)
    end,

    onCollide = function (self, other, horizontal)
        if horizontal < 0 then
            self:displace(other)
        end
    end
}