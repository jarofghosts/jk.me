require 'sinatra'
require 'sinatra/activerecord'
require 'json'
require './config/env'

class Entry < ActiveRecord::Base
end

class Contact < ActiveRecord::Base
end

get '/' do
	@entry = Entry.last
	erb :index
end

get '/blog/(:slug)' do
	@entry = Entry.where( :slug => params[:slug] )
	return erb :blog_page unless !defined? @entry
	erb :fourohfour
end

post '/contact/send' do
	params[:name] ||= "Buddy"
	Contact.create ( :name => params[:contact-name], :message => params[:contact-message] )
	"Thanks for the message, #{params[:name]}"
end

post '/blog/new' do
	Entry.create ( :title => params[:title], :body => params[:body] )
end

get '/blog/new' do
	erb :