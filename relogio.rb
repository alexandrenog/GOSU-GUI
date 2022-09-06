require 'gosu'
require_relative 'GosuGUI'

class Relogio < Gosu::Window
	def initialize(widht=720,height=480,fullscreen=false)
		super widht, height, fullscreen
		self.caption="Controle"
		/buttons/;			@button=GosuButton.new(self,[100,130],[50,35],"Ver Hora",lambda{|window| window.checa_hora})
		/textfields/;	@relogio=GosuTextField.new(self,[40,50],[100,19],"",true,5)
						@inputhandler=GosuInputHandler.new(self)
						@inputhandler.addTextField(@relogio)
		@drawables=[@button,@inputhandler]
	end
	def draw
		backGround (0xff333333)
		drawMouse
		@drawables.draw
	end
	def update
		#@inputhandler.update
	end
	def key_up(id)
		@button.handle(id)
	end
	def checa_hora
		@relogio.text=Time.now.to_s
	end
end

relogio = Relogio.new(250,250).show