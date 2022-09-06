require 'gosu'
require_relative 'GosuGUI'

class Test < Gosu::Window
	attr_accessor :exemplo
	def initialize(width,height,bool)
		super(width,height,bool)
		self.caption="Contador em Gosu"
		@exemplo=0
		@buttons=[]
		@buttons<<GosuButton.new(self,[width/2-width/4,60],[width/2,30],"Incrementar",lambda{|window| window.incrementar; window.atualizaLabel},nil,0xffbbbb22,0xff000000)
		@buttons<<GosuButton.new(self,[width/2-width/4,120],[width/2,30],"Resetar",lambda{|window| window.resetar; window.atualizaLabel},nil,0xff992222,0xff000000)
		@label=GosuLabel.new(self,[width/2-width/4,180],[width/2,30],"",true,1<<8,0xbb009922,0xff111111)
		@bgimg = Gosu::Image.new(self,'texture.png')
		atualizaLabel
	end
	def button_up(id)
		@buttons.each{|b| b.button_up(id)}
	end
	def draw
		backGround(@bgimg)
		@buttons.each{|b| b.draw}
		@label.draw
		drawMouse(0xff000044,2)
	end
	def needs_cursor?
		false
	end
	def incrementar
		@exemplo+=1
	end
	def resetar
		@exemplo=0
	end
	def atualizaLabel
		@label.text="Exemplo: "+@exemplo.to_s
	end
end

test = Test.new(350,250,false);
test.show()