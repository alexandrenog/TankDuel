require_relative 'position'

$winW, $winH = 600, 400
$rop = 20

class Player
	attr_accessor :pos, :vel, :life, :dmg, :regen_rate
	attr_reader :l
	def initialize
		@pos=Position.zero
		@vel=Position.zero
		@life=100.0
		@dmg=4.3
		@regen_rate=0.05
		@l=$rop
		@color=0xff_00ff00
		@buttons={Gosu::KbA => false, Gosu::KbD => false, Gosu::KbW => false, Gosu::KbS => false}
	end
	def setP(pos)
		@pos=pos
	end
	def setV(vel)
		@vel=vel
	end
	def draw(window)
	 	window.draw_rect(@pos.x-@l, @pos.y-@l, @pos.x+@l, @pos.y+@l, @color, 2)
	end
	def update
		@pos=Position.add(@pos,@vel)
		@pos=Position.add(@pos,Position.new($winW,$winH))
		@pos.x%=$winW
		@pos.y%=$winH
		check_presseds
		@life=[@life+@regen_rate,100.0].min
	end
	def check_presseds()
		a=0.35
		v_lim=1.8
		if @buttons[Gosu::KbA]
			@vel.x+=-a
		end
		if @buttons[Gosu::KbD]
			@vel.x+=a
		end
		if @buttons[Gosu::KbW]
			@vel.y+=-a
		end
		if @buttons[Gosu::KbS]
			@vel.y+=a
		end
		@vel.x=[@vel.x,v_lim].min
		@vel.x=[@vel.x,-v_lim].max
		@vel.y=[@vel.y,v_lim].min
		@vel.y=[@vel.y,-v_lim].max
	end
	def button_down(id)
		@buttons[id]=true
	end
	def button_up(id)
		@buttons[id]=false
	end
end