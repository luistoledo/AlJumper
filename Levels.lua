Levels = Group:extend {
  maps = {
    {
    -- level 1
    '@@@@@@@@@@@@@@@@@@@@@@@@@',
    '@                       @',
    '@                       @',
    '@                       @',
    '@      #######  ###    #@',
    '@                       @',
    '@   ##              ####@',
    '@#                      @',
    '@    ###   ####        #@',
    '@##                     @',
    '@   ###                 @',
    '@       #  E            @',
    '@P         ######       @',
    '@   ##                  @',
    '@#################    ##@',
    '@~~~~~~~~~~~~~~~~~~~~~~~@',
    '@~~~~~~~~~~~~~~~~~~~~~~~@',
    '@~~~~~~~~~~~~~~~~~~~~~~~@',
    '@@@@@@@@@@@@@@@@@@@@@@@@@'
    },

    {
    -- level 2
    '@@@@@@@@@@@@@@@@@@@@@@@@@',
    '@                       @',
    '@                       @',
    '@        P              @',
    '@      #######  ###    #@',
    '@                       @',
    '@   ##              ####@',
    '@#                      @',
    '@    ###   ####        #@',
    '@##                     @',
    '@   ###                 @',
    '@       #               @',
    '@          ######       @',
    '@   ##       E          @',
    '@#################    ##@',
    '@~~~~~~~~~~~~~~~~~~~~~~~@',
    '@~~~~~~~~~~~~~~~~~~~~~~~@',
    '@~~~~~~~~~~~~~~~~~~~~~~~@',
    '@@@@@@@@@@@@@@@@@@@@@@@@@'
    }
  },

  xPlayer = 0,
  yPlayer = 0,

  currentLevel = 1,

  platforms = Group:new(),
  
  createLevel = function(self, levelId)
    self.currentLevel = levelId

    level = self.maps[levelId]
    print("--" .. levelId)

    self.platforms = Group:new()

    for i,v in ipairs(level) do
      for j=0, #v do
        if (v:sub(j,j) == '#') then
          self.platforms:add(Platform:new({x=(j-1)*Platform.width, y=(i-1)*Platform.height}))
        end
        if (v:sub(j,j) == '@') then
          self.platforms:add(Impassable:new({x=(j-1)*Impassable.width, y=(i-1)*Impassable.height}))
        end
        if (v:sub(j,j) == 'E') then
          self.platforms:add(ExitDoor:new({x=(j-1)*ExitDoor.width, y=(i-1)*ExitDoor.height}))
        end
        if (v:sub(j,j) == 'P') then
          self.xPlayer, self.yPlayer = (j-1)*Platform.width, (i-1)*Platform.height
        end
        if (v:sub(j,j) == '~') then
          self.platforms:add(Water:new({x=(j-1)*Water.width, y=(i-1)*Water.height}))
        end
      end
    end
    return self.platforms
  end
}

ExitDoor = Tile:extend
{

  width = 32,
  height = 32,
  image = 'exitDoorOpen.png',

  state = 'open',

  onCollide = function ( self, other )
    if self.state == 'open' then
      the.app:gotoNextLevel()
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