class PostsController < ApplicationController
	before_action :find_post, except:[:index,:new,:create]
# ---------------------------------------------------------------------------------------------
	def index
		if params[:featured].present? and params[:featured]=="true"
			@posts = Post.where(is_featured:true)
		else
	  		@posts = Post.order("created_at DESC")
		end
	end
#----------------------------------------------------------------------------------------------
	def show
		@comments = @post.comments
	end
# ---------------------------------------------------------------------------------------------
	def new
		@post = Post.new
	end  

	def create
		@post = Post.new(post_params)
		if @post.save
			redirect_to root_path
			flash[:success]="Thanks for posting!"
		else
			flash[:error]="Oops, something went wrong. Please try again"
			render:new
		end
	end
# ---------------------------------------------------------------------------------------------
	def edit
#	  	
	end
	
	def update
#	  	
		if @post.update(post_params)
			redirect_to post_path(@post)
			flash[:success]="Updated '#{@post.title}'"
		else
			render :edit
			flash[:error]=""
		end
	end
# ---------------------------------------------------------------------------------------------
	def destroy
		@post.destroy
	end
# ---------------------------------------------------------------------------------------------
private
	def post_params
		params.require(:post).permit(:title,:body,:is_published,:is_featured)
	end
	def find_post
		@post = Post.find(params[:id])
	end
end
