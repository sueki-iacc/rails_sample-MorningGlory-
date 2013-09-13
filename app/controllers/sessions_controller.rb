# coding: utf-8

class SessionsController < ApplicationController
	def create
		member=Member.authenticate(params[:name], params[:password])
		if member
			session[:member_id]=member.id
		else
			flash.alert="invalid name or password."
		end
		redirect_to params[:from] || :root
	end

	def destroy
		session.delete(:member_id)
		redirect_to :root
	end
end
