require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database, {adapter: "sqlite3", database: "leprosorium.db"}

class Post < ActiveRecord::Base
	has_many :comments 
	validates :author, presence: true 
	validates :content, presence: true
end

class Comment < ActiveRecord::Base
	validates :content, presence: true
end

# before вызывается каждый раз при перезагрузке
# любой страницы
before do 
	@posts = Post.all
end

# обработчик get запроса /
get '/' do
	
	@posts = Post.all
	
	erb :index
end

# обработчик get запроса /new
get '/new' do
  	erb :new
end

# обработчик post запроса /new
post '/new' do
  
	@p = Post.new params[:post]
	
	if @p.save
		erb :new
	else
		@error  = @p.errors.full_messages.first
		erb :new
	end
end

get '/post/:id' do

	@post = Post.find(params[:id])
	
	@comments = Comment.all
	#find(params[:post_id])

 	erb :post
 end

  post '/post/:id' do
  	@c = Comment.new params[:comment]	
	@c.post_id = params[:id]
	
	if @c.save
		erb :index
	else
		@error  = @c.errors.full_messages.first
		erb :index
	end
	
 end