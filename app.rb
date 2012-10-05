require 'sinatra'
require 'sinatra/activerecord'
require 'stringex'
require 'redcarpet'
require './config/env'

class Entry < ActiveRecord::Base
	self.table_name = "entries"
end

class Message < ActiveRecord::Base
end
class Ghostjar < ActiveRecord::Base
end

get '/' do
	@entry = Entry.last
	erb :index
end

get '/b/' do
	@entries = Entry.order("created_at desc").last(25)
	erb :blog_list
end

get '/b/:slug' do
	@entry = Entry.where( :slug => params[:slug] ).first
	@previous = Entry.where( :id => @entry.id - 1 ).first
	@next = Entry.where( :id => @entry.id + 1 ).first
	return erb :blog_page unless !defined? @entry
	erb :fourohfour
end

post '/contact/send' do
	return "C'mon, what do you want to say?" if params[:contact_message].empty?
	params[:contact_name] ||= "Buddy"
	params[:contact_info] ||= "-didn't say-"
	Message.create( :name => params[:contact_name],
					 :message => params[:contact_message],
					 :respond => params[:contact_info] )

	"Thanks for the message, #{params[:contact_name]}!"
end

post '/blog/new' do
	Entry.create( :title => params[:title], :body => params[:body], :slug => params[:title].to_url ) unless params[:password] != Ghostjar.first.password
	redirect '/b/'
end

get '/blog/new' do
	erb :blog_input
end

get '/e/:slug' do
	@entry = Entry.where( :slug => params[:slug] ).first
	erb :blog_input
end

post '/blog/edit' do
	entry = Entry.where( :slug => params[:slug] ).first

	entry.title = params[:title]
	entry.body = params[:body]
	# oh, piss off.. who's gonna hack my blog?
	entry.save unless params[:password] != Ghostjar.first.password

	redirect "/b/#{params[:slug]}"
end