require 'sinatra'
require 'sinatra/reloader'
require 'erb'

get "/" do
  File.open("articles.txt", "r") do |f|
    @articles = f.read.split("\n")
  end
  erb :top
end

get "/new" do
  erb :new
end

post "/" do
  @article_array = params[:article].split("\r\n")
  @article = @article_array.join(",")
  File.open("articles.txt", "a") do |f|
    f.puts("#{@article}")
  end
  redirect "/"
end

get '/show/:id' do
  @id = params["id"].to_i
  @paraData = File.open("articles.txt").readlines
  @article_array = @paraData[params["id"].to_i].split(",")
  erb :show
end

get '/edit/:id' do
  @id = params["id"].to_i
  @paraData = File.open("articles.txt").readlines
  @article_array = @paraData[params["id"].to_i].split(",")
  erb :edit
end

patch '/update/:id' do
  id = params["id"].to_i
  articles = []

  File.open("articles.txt", "r") do |f|
    row_text = f.read
    articles = row_text.split("\n")
  end

  articles[id] = params[:article].split("\r\n").join(",")
  updated_row_text = articles.join("\n")

  File.open("articles.txt", "w") do |f|
    f.puts(updated_row_text)
  end

  @article_array = params[:article].split("\r\n")
  redirect "/show/#{params["id"]}"
end

delete "/destroy/:id" do
  @id = params["id"].to_i
  @paraData = File.open("articles.txt").readlines
  @paraData.delete_at(params["id"].to_i)
  File.open("articles.txt", "w") do |f|
    f.puts(@paraData)
  end
  redirect "/"
end
