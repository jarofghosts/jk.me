require 'sinatra'
require 'sinatra/activerecord'
require 'json'
require './config/env'

class Thing < ActiveRecord::Base
end

get '/' do
	@things = Thing.last(10)
	erb :index
end

get '/:number/things' do
	number = params[:number].to_i <= 50 ? params[:number].to_i : 50;
	Thing.last(number).to_json
end

get '/:number/old/things' do
	number = params[:number].to_i <= 50 ? params[:number].to_i : 50;
	Thing.first(number).to_json
end

get '/:number/new/things' do
	number = params[:number].to_i <= 50 ? params[:number].to_i : 50;
	Thing.last(number).to_json
end

post '/:thing/is/:definition' do
  Thing.create( :thing => params[:thing], :definition => params[:definition]) unless Thing.exists?(:thing => params[:thing])
  Thing.where(:thing => params[:thing]).to_json
end

get '/:thing/is' do
  Thing.where(:thing => params[:thing]).to_json
end

delete '*' do
  "nope.avi"
end
