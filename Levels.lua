Levels = Group:extend {
  level1 = {
  '                         ',
  '                         ',
  '                         ',
  '                         ',
  '       #######  ###    ##',
  '                        #',
  '    ##              #####',
  '##                      #',
  '     ###   ####        ##',
  ' ##                     #',
  '    ###                 #',
  '        #               #',
  'P          ######       #',
  '    ##                   ',
  '###################    ##',
  '~~~~~~~~~~~~~~~~~~~~~~~~~',
  '~~~~~~~~~~~~~~~~~~~~~~~~~',
  '~~~~~~~~~~~~~~~~~~~~~~~~~',
  '~~~~~~~~~~~~~~~~~~~~~~~~~',
  '~~~~~~~~~~~~~~~~~~~~~~~~~'
  },

  xPlayer = 0,
  yPlayer = 0,

  platforms = Group:new(),
  
  createLevel = function(self, level)
    -- local pl = Group:new()
    for i,v in ipairs(level) do
      for j=0, #v do
        if (v:sub(j,j) == '#') then
          self.platforms:add(Platform:new({x=(j-1)*Platform.width, y=(i-1)*Platform.height}))
        end
        if (v:sub(j,j) == '~') then
          self.platforms:add(Water:new({x=(j-1)*Water.width, y=(i-1)*Water.height}))
        end
        if (v:sub(j,j) == 'P') then
          self.xPlayer, self.yPlayer = (j-1)*Platform.width, (i-1)*Platform.height
        end
      end
    end
    return self.platforms
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

-- Water = Tile:extend
Water = Animation:extend
{
    width = 32,
    height = 32,
    image = 'water.png',

    sequences = {
      move1 = { frames = {3, 3, 3, 1, 2}, fps = 1 },
      move2 = { frames = {1, 2, 3, 3, 3}, fps = 1 },
      move3 = { frames = {3, 3, 1, 2, 3}, fps = 1 }
      -- stay = { frames = {3}, fps = 0.1 }
    },

    seq = 'move1',

    onEndSequence = function ( self )
      local randomSeq = math.floor(math.random(4))
      local cnt = 1
      for i,v in pairs(self.sequences) do
        cnt = cnt + 1
        if cnt==randomSeq then
          self.seq = i
        end
      end
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