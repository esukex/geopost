class CommentsController < ApplicationController
	before_action :find_post, only: [:new, :create, :edit, :update]
	def new
		@comment = @post.comments.new
	end
	
	def create
		@comment = @post.comments.new(comment_params)
		if @comment.save
			flash[:success]="Thanks for leaving a comment!"
			redirect_to post_path(@post)
		else
			flash[:error]="Oops, something went wrong. Please try again"
			render:new
		end
	end
	
	def edit
		@comment = @post.comments.find(params[:id])
	end
	
	def update
		@comment= @post.comments.find(params[:id])
		if @comment.update(comment_params)
			flash[:success]="Comment has been updated"
			redirect_to post_path(@post)
		else
			flash[:error]="Oops, something went wrong. Please try again"
			render :edit
		end
	end
	
	private
		def comment_params
			params.require(:comment).permit(:body)
		end
		
		def find_post
			@post = Post.find(params[:post_id])
		end
end
