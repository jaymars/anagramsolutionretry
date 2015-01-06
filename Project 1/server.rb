require './db/connection.rb'
require './db/class.rb'
require 'sinatra'
require 'sinatra/reloader'
require 'mustache'
require 'active_record'
require 'pry'

get "/" do
	File.read("./views/index.html")
end

get "/posts" do
	File.read("./views/feed.html")
	posts = Micro_post.all.as_json

	# binding.pry

	posts.each do |post|
		post["path"] = "/post/#{post["id"]}/edit"
	end

	Mustache.render(File.read("./views/feed.html"), {post: posts})
end

post "/" do
 	User.create(name: params[:name], email: params[:email])
 	redirect "/posts"
end

get "/post/new" do
	File.read("./views/post_new.html")
end

post "/post/new" do
	Micro_post.create(title: params[:title], post: params[:post], photo: params[:photo])
	redirect "/posts"
end

# 

get "/post/:id/edit" do
	template = File.read("./views/update.html")
	post = Micro_post.find_by(id: params["id"])
	Mustache.render(template, post: post)
end

put "/post/:id/edit" do
	title_from_params = params["title"]
	post_from_params = params["post"]
	photo_from_params = params["photo"]
	id_from_params = params["id"]
	post_update = Micro_post.find(id_from_params.to_i)
	post_update.title = title_from_params
	post_update.post = post_from_params
	post_update.photo = photo_from_params
	post_update.save
	# Micro_post.update(title: params[:title], post: params[:post], photo: params[:photo])
	redirect "/posts"
end

delete "/post/:id/edit" do
	id_from_params = params["id"]
	deleted_post = Micro_post.find(id_from_params)
	deleted_post.destroy
	redirect "/posts"
end



# get "/posts/:id" do
# 	Micro_post.all.to_a
# #find post by id
# #set up a template page that lets you edit and delete a post.
# end