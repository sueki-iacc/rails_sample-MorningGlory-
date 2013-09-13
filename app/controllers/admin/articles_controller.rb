# coding: utf-8

class Admin::ArticlesController < Admin::Base
	def index
		@articles=Article.order("released_at DESC")
	end
	
	def new
		@article=Article.new
	end
	
	def show
		@article=Article.find(params[:id])
	end
	
	def edit
		@article=Article.find(params[:id])
	end
	
	def create
		@article=Article.new(params[:article], as: :admin)
		if @article.save
			redirect_to [:admin, @article], notice: "add new article."
		else
			render "new"
		end
	end
	
	def update
		@article=Article.find(params[:id])
		@article.assign_attributes(params[:article], as: :admin)
		if @article.save
			redirect_to [:admin, @article], notice: "update article."
		else
			render "edit"
		end
	end
	
	def destroy
		@article=Article.find(params[:id])
		@article.destroy
		redirect_to :admin_articles
	end
end
