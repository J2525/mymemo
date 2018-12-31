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
  @paraData = File.open("articles.txt").readlines
  @article_array = @paraData[params["id"].to_i].split(",")
  erb :show
end
