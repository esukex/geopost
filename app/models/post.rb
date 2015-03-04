class Post < ActiveRecord::Base
	has_many :comments
	
	validates :title, presence:true, uniqueness:true
	validates :body, {length:{minimum:10, maximum:50000}}
end
