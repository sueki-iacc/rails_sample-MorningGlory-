# coding: utf-8

class LessonController < ApplicationController
	before_filter :do_before, only: :step7

	def step1
		render text: "hello, #{params[:name]} !"
	end
	
	def step2
		render text: params[:controller] +" # "+request.remote_ip
	end
	
	def step3
		redirect_to action: "step4"
	end
	
	def step4
		render text: "moved to step4."
	end
	
	def step5
		flash[:notice]="move to step6."
		redirect_to action: "step6"
	end
	
	def step6
		render text: flash[:notice]
	end
	
	def step7
		render text: @message
	end
	
	def step8
		@price=(2000*1.05).floor
	end
	
	def step9
		@price=1000
		render"step8"
	end
	
	def step13
		@time=Time.now
	end
	
	def step15
		@message="hello! how are you?\n enjoy studying rails!"
	end
	
	def step16
		@page_title="hogehgoe"
	end
	
	def step19
		@items={"flying pan" => 2680, "wine glass" => 2550, "pepper mil" => 4515, "peeler" => 945}
	end
	
	private
	def do_before
		@message="halo..a"
	end
end
