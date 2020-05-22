require 'dm-core'
require 'dm-timestamps'
require 'dm-validations'
require 'dm-migrations'
require 'sinatra'

DataMapper.setup :default, "sqlite://#{Dir.pwd}/nine.db"

class User
  include DataMapper::Resource

  property :id, Serial
  property :user_name, String
  property :name, String
  property :created_at, DateTime
  property :updated_at, DateTime

  has n, :posts

end

class Post
  include DataMapper::Resource

  property :slug, String, key: true, unique_index: true, default: lambda { |resource, prop| resource.title.downcase.gsub " ", "-" }
  property :title, String
  property :body, String
  property :created_at, DateTime
  property :updated_at, DateTime

  belongs_to :user

end

class Chitter < Sinatra::Base
    enable :sessions

  get '/' do
    redirect '/sign_in'
  end

  get '/sign_in' do
    erb :sign_in
  end

  post '/sign_in' do
    user = User.new
    user.user_name = (params[:username])
    user.save
    session[:user_id] = user.id
    redirect '/new_post'
  end

  get '/new_post' do
    erb :new_post
  end

  post '/new_post' do
    post = Post.new
    post.user = User.get(session[:user_id])
    post.title = (params[:title])
    post.body = (params[:body])
    post.updated_at
    post.save
    redirect '/posts'
  end

  get '/posts' do
    posts = Post.all
    @new_posts = posts.sort!
    erb :posts
  end

  get '/search_posts' do
    erb :search_posts
  end

  post '/search_posts' do
    @search_post = params[:search]
    erb :search_results
  end

  run! if app_file == $0

end

DataMapper.auto_upgrade!
