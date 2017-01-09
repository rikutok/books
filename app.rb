require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?

require 'net/http'
require 'uri'
require 'json'

post '/search' do
    
    keyword = params[:keyword];
    uri_escape = URI.escape('https://www.googleapis.com/books/v1/volumes?q=' + keyword + '&country=JP')
    uri = URI.parse(uri_escape)
    json = Net::HTTP.get(uri)
    result = JSON.parse(json)
    @items = result['items']
    if @items
        erb :index2
    else
        erb :index
    end
end

get '/' do
    erb :index
end
