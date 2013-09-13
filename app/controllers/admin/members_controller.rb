class Admin::MembersController < Admin::Base

	def index
		@members=Member.order("number")
	end
	
	def show
		@member=Member.find(params[:id])
	end
	
	def new
		@member=Member.new(birthday: Date.new(1980, 1, 1))
	end
	
	def edit
		@member=Member.find(params[:id])
	end
	
	def create
		@member=Member.new(params[:member], as: :admin)
		if @member.save
			redirect_to [:admin, @member], notice: "successfully registered."
		else
			render "new"
		end
	end
	
	def update
		@member=Member.find(params[:id])
		@member.assign_attributes(params[:member])
		if @member.save
			redirect_to [:admin, @member], notice: "update member info."
		else
			render "edit"
		end
	end
	
	def destroy
		@member=Member.find(params[:id])
		@member.destroy
		redirect_to :admin_members, notice: "member No.#{params[:id]} deleted."
	end
	
	def search
		@members=Member.search(params[:q])
		render "index"
	end
end
