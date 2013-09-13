class MembersController < ApplicationController
	before_filter :login_required

	def index
		@members=Member.order("number")
	end
	
	def show
		@member=Member.find(params[:id])
	end
	
	def search
		@members=Member.search(params[:q])
		render "index"
	end
end
