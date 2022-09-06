require 'gosu'
require_relative 'GosuGUI'
require_relative 'calccontrole'

class Controle < Gosu::Window
	include Control
	def initialize(widht=720,height=480,fullscreen=false)
		super widht, height, fullscreen
		self.caption="Controle"
		/buttons/;			@button=GosuButton.new(self,[100,200],[50,20],"Limpar",lambda{|window| window.reseta})
		/textfields/;	@r=GosuTextField.new(self,[40,35],[70,26],"",true,5)
						@theta=GosuTextField.new(self,[160,35],[70,26],"",true,5)
						@inputhandler=GosuInputHandler.new(self)
						@inputhandler.addTextField([@r,@theta])
		/labels/;	@labels=[]
					@labels<<@tleft=GosuLabel.new(self,[widht/2,height*0.5],[70,26],"",true)
					@labels<<@tright=GosuLabel.new(self,[widht/2,height*0.65],[70,26],"",true)
					@labels<<GosuLabel.new(self,[40,20],[70,16],"R",false)
					@labels<<GosuLabel.new(self,[160,20],[70,16],"THETA",false)
					@labels<<GosuLabel.new(self,[widht/2-35,height*0.4],[70,16],"Resultados",false)
					@labels<<GosuLabel.new(self,[widht/2-70,height*0.51],[70,16],"MLEFT:",false)
					@labels<<GosuLabel.new(self,[widht/2-70,height*0.66],[70,16],"MRIGHT:",false)
		@drawables=[@button,@inputhandler,@labels]
	end
	def draw
		backGround (0xff333333)
		drawMouse
		@drawables.draw
	end
	def update
		@inputhandler.update
		calcula
	end
	def key_up(id)
		@button.handle(id)
		reseta if id == Gosu::KbReturn
	end
	def calcula
		r,theta=[@r,@theta].map{|e| e.text.to_f}
		values=throttle_angle_to_thrust(r, theta)
		@tleft.text,@tright.text=values.map{|e| ((e*10.0).to_i/10.0).to_s}
	end
	def reseta
		[@r,@theta].each{|e| e.text=""}
		calcula
	end
end

controle = Controle.new(250,250).show