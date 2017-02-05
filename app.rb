require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?

require 'net/http'
require 'uri'
require 'json'

require './models'
enable :sessions

helpers do
    def current_user
        User.find_by(id: session[:user])
    end
end


post '/search' do
    begin
        keyword = params[:keyword];
        uri_escape = URI.escape('https://www.googleapis.com/books/v1/volumes?q=' + keyword + '&country=JP')
        uri = URI.parse(uri_escape)
        json = Net::HTTP.get(uri)
        result = JSON.parse(json)
    @items = result['items']
    puts @items
    if @items
        puts "ok"
        erb :search2
    else
        puts "error2"
        erb :search
    end
    rescue
        puts "error"
        erb :error
    end
end

get '/' do
    @title = ""
    erb :index
end

get '/search_on' do
   erb :search
end

post '/post' do
    puts params
    @title = params[:title]
    puts @title
    erb :post
end

get '/post' do
    if session[:user].nil?
        redirect '/'
    end
    @title = ""
    erb :post
end
    
get '/signin' do
    erb :sign_in
end

get '/signup' do
    erb :sign_up
end

get '/signout' do
    session[:user] = nil
    
    redirect '/'
end



post '/signin' do
    user = User.find_by(name: params[:name])
    if user && user.authenticate(params[:password])
        session[:user] = user.id
   else
       redirect '/error'
   
    end
        

    redirect '/'
end

post '/signup' do
    @user = User.create(name: params[:name], password: params[:password], password_confirmation: params[:password_confirmation], email: params[:email])
    
    if @user.persisted?
        session[:user] = @user.id
    else
        redirect '/error'
    end
    
    redirect '/'
end

post '/new' do
    Post.create!({
        title: params[:title],
        content: params[:content],
        url: params[:url],
        user_id: current_user.id,
        book_id: params[]
    })
end