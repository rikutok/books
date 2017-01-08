require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?

require 'net/http'
require 'uri'
require 'json'

post '/search' do
    keyword = params[:keyword];
    uri = URI.parse('https://www.googleapis.com/books/v1/volumes?q=' + keyword + '&country=JP')
    json = Net::HTTP.get(uri)
    result = JSON.parse(json)
    @items = result['items']
    erb :index2 
end

get '/' do
    erb :index
end
