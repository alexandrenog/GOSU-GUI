require 'gosu'
require_relative 'GosuGUI'

class Calculator < Gosu::Window
	attr_reader :tf1, :tf2
	def initialize(width,height,fullscreen=false)
		super(width,height,fullscreen)
		self.caption="Calculator"
		buttonColor,buttonFontColor=0xff222222,0xffcccc00
		textfieldColor,textfieldFontColor=0xffbbbbbb,0xdd111111
		x1,x2,xtitle=30,210,10
		y1,ydif1,ydif2,ytitle=70,50,80,width/4
		@buttons=[]
		@tf1=GosuTextField.new(self,[x2,y1],[width/3+10,30],"",true,10,textfieldColor,textfieldFontColor)
		@tf2=GosuTextField.new(self,[x2,y1+ydif2],[width/3+10,30],"",true,10,textfieldColor,textfieldFontColor)
		@buttons<<GosuButton.new(self,[x1,y1],[width/3,30],"Add",lambda{|window| window.assign window.tf1.to_f+window.tf2.to_f},nil,buttonColor,buttonFontColor)
		@buttons<<GosuButton.new(self,[x1,y1+ydif1],[width/3,30],"Subtract",lambda{|window| window.assign window.tf1.to_f-window.tf2.to_f},nil,buttonColor,buttonFontColor)
		@buttons<<GosuButton.new(self,[x1,y1+ydif1*2],[width/3,30],"Multiply",lambda{|window| window.assign window.tf1.to_f*window.tf2.to_f},nil,buttonColor,buttonFontColor)
		@buttons<<GosuButton.new(self,[x1,y1+ydif1*3],[width/3,30],"Divide",lambda{|window| window.assign window.tf1.to_f/window.tf2.to_f},nil,buttonColor,buttonFontColor)
		@labelResult=GosuLabel.new(self,[x2-10,y1+ydif2*2],[width/3+10,30],"",false,14)
		@labelTitle=GosuLabel.new(self,[ytitle,xtitle],[width/2,40],self.caption,false)
		@inputhandler=GosuInputHandler.new(self) #must be named "inputhandler" to work properly on button events' overwriting, equivalent to this a GosuTextInput should be named textinput
		@inputhandler.addTextField([@tf1,@tf2])
		@drawables=[@buttons,@inputhandler,@labelResult,@labelTitle]
	end
	def draw
		backGround(0xff333333)
		drawMouse
		@drawables.draw # Array monkeypatched
	end
	def key_up(id) # required by buttons(explicit) and Input handling(implicit),
				   # replaces button_up role(and key_down would do the same for button_down)
		@buttons.handle(id) # Array monkeypatched
	end
	def update # required by use of textfields' buffered operation and actual display updates
		@inputhandler.update
	end
	def assign(value) # method executed by the button, there's no binding to the lib GosuGUI
		@labelResult.text="= "+value.to_s
	end
end
Calculator.new(400,300).show