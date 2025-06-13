require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database, {adapter: "sqlite3", database: "leprosorium.db"}

class Post < ActiveRecord::Base
end

class Comment < ActiveRecord::Base
end

# before вызывается каждый раз при перезагрузке
# любой страницы
before do 
	
end

	# @db.execute 'CREATE TABLE IF NOT EXISTS Comments (
	# ID	INTEGER,
	# created_date DATA,
	# content	TEXT,
	# post_id INTEGER,
	# PRIMARY KEY("ID" AUTOINCREMENT))'


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
	@p.save

	erb :new
end

get '/post/:id' do

	@post = Post.find(params[:id])

# 	@comments = @db.execute 'select * from Comments where post_id = ? order by id',[post_id]

 	erb :post
 end

# post '/post/:post_id' do
# 	post_id = params[:post_id]
# 	content = params[:content]	
	
# 	# if content.length <= 0 
#   	#  	@error = 'Type comment'
#   	#  	return /post/post_id
# 	#  end
	
# 	@db.execute 'insert into Comments 
# 	(content, created_date, post_id) 
# 	values (?, datetime (), ?)', [content, post_id]
	
# 	redirect to('/post/' + post_id)
# end