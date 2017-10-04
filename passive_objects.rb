require_relative 'position'
$winW, $winH = 600, 400
$rop = 20

class Enemy
	attr_accessor :pos, :life
	attr_reader :l
	def initialize
		@pos=Position.zero
		@life=100.0
		@l=$rop
		@color=0xff_ff0000
	end
	def setP(pos)
		@pos=pos
	end
	def draw(window)
	 	window.draw_rect(@pos.x-@l, @pos.y-@l, @pos.x+@l, @pos.y+@l, @color, 1)
	end
end
class Block
	CONST_VEL=6.5
	attr_accessor :pos, :vel, :for_delete
	attr_reader :l, :from_enemy
	def initialize(pos, vel, from_enemy=false)
		@pos=pos
		@vel=vel
		@l=$rop/5.0
		@from_enemy=from_enemy
		@color=(from_enemy)?0xff_ff8800:0xff_88ff00
		@for_delete=false
	end
	def setP(pos)
		@pos=pos
	end
	def draw(window)
	 	window.draw_rect(@pos.x-@l, @pos.y-@l, @pos.x+@l, @pos.y+@l, @color, 1)
	end
	def update
		@pos=Position.add(@pos,@vel)
		if !@pos.x.between?(0,$winW) or !@pos.y.between?(0,$winH)
			@for_delete=true
		end 
	end
end