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
  erb :show
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

post '/update/:id' do
  File.open("articles.txt", "w+") do |f|
    @articles = f.read.split("\n") #ファイルの中身を配列に入れる
    @articles[params["id"].to_i] = params[:article].split("\r\n").join(",") #要素を置き換える
    f.puts("#{@articles}") #書き込む
  end
  @article_array = params[:article].split("\r\n")
  erb :show
end
