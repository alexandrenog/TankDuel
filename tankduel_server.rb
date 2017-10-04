require 'socket'

$winW, $winH= 600, 400

class Player
	attr_accessor :clientSocket, :player_id, :x, :y, :life
	def initialize(client,id)
		@clientSocket = client
		@player_id = id
		@x=rand($winW)
		@y=rand($winH)
		@life=100
	end
	def listen(players_list)
		loop{
			if(players_list.size==2)
				#puts "listening player #{@player_id}"
				info=@clientSocket.gets.chomp.split(",")
				id=info[0].to_i
				if id ==0 and $players.size>0
					$players=[]
				elsif id==1
					@x,@y,@life=info[1].to_f,info[2].to_f,info[3].to_f
					players_list[1-@player_id].clientSocket.puts "1,#{@x},#{@y},#{@life}"
				elsif id==2
					x,y=info[1].to_f,info[2].to_f
					vx,vy=info[3].to_f,info[4].to_f
					players_list[1-@player_id].clientSocket.puts "2,#{x},#{y},#{vx},#{vy}"
				end
				#puts "#{id},#{@x},#{@y}"
			end
		}
		@clientSocket.close
	end
end


server = TCPServer.new '127.0.0.1', 2000
$players=[]
loop {
  	Thread.fork(server.accept) do |client|
  		num_players=$players.size
  		if num_players<2
  			player=Player.new(client,num_players)
  			$players<<player
  			info="conectado #{player.player_id},#{player.x},#{player.y}"
  			player.clientSocket.puts info
  			#puts info
  			#puts "player #{num_players} adicionado"
  			player.listen($players)
  		else
  			client.puts "error SalaCheia"
	    	client.close
  		end
	end
}