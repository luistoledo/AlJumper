Player = Animation:extend
{
    width = 32,
    height = 48,
    image = 'player.png',
  sequences = 
  {
    right = { frames = {1, 2, 3, 4, 5, 6, 5, 4, 3, 2}, fps = 8 },
    left = { frames = {7, 8, 9, 10, 11, 12, 11, 10, 9, 8}, fps = 8 } 
  },
    acceleration = { x = 0, y = 600, rotation = 0 },
    canJump = false,
    
    onUpdate = function (self)
        if the.keys:pressed('left') then
            self.velocity.x = -100
            self:play('left')
        elseif the.keys:pressed('right') then
            self.velocity.x = 100
            self:play('right')
        else
            self.velocity.x = 0
            self:freeze()
        end

        if the.keys:pressed(' ') and self.canJump then
            -- playSound('jump.ogg')
            self.velocity.y = -300
            self.canJump = false
        end

        if self.velocity.y > 0 and self.canJump then
            self.canJump = false
        end

        if self.y > the.app.height then
            self.y = 0
        end
        if self.x > the.app.width then
            self.x = 0
        end
        if self.x < 0 then
            self.x = the.app.width
        end
    end,

    onCollide = function (self, other, xOverlap, yOverlap)
        if other:instanceOf(Impassable) or other:instanceOf(Platform) then
            if self.velocity.y > 0 then
            if self.y < other.y then
            if yOverlap < (self.height-other.height) then
                self.velocity.y = 0
                self.y = other.y - self.height
                self.canJump = true
            end
            end
            end
        end
    end
}