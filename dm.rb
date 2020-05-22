require 'dm-core'
require 'dm-timestamps'
require 'dm-validations'
require 'dm-migrations'
require 'sinatra'

DataMapper.setup :default, "sqlite://#{Dir.pwd}/data.db"

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

  attr_accessor :user

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
    redirect '/new_post'
  end

  get '/new_post' do
    erb :new_post
  end

  post '/posts' do
    post = Post.new
    post.user = user
    post.title = (params[:title])
    post.body = (params[:body])
    post.updated_at
    post.save
    @posts = Post.all
    erb :posts
  end

  # get 'your_posts' do
  #
  # end

  run! if app_file == $0

end

DataMapper.auto_upgrade!
