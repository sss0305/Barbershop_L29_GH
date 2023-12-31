#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database, {adapter: "sqlite3",database: "barbershop.db"}
# "sqlite3:barbershop.db"

# создаем сущность
class Client < ActiveRecord::Base
end

class Barber < ActiveRecord::Base
end

class Contact < ActiveRecord::Base
end


before do
	@barbers = Barber.all
end


get '/' do
	# @barbers = Barber.all
	@barbers = Barber.order "created_at DESC"
	 erb :index
end

get '/visit' do
	erb :visit
end

post '/visit' do
	@username =	params[:username]
	# @email =	params[:email]
	@phone =	params[:phone]
	@date =		params[:date]
	@barber =	params[:barber]
	@color =	params[:color]


	Client.create :name => "#{@username}", :phone => "#{@phone}", :datestamp => "#{@date}", :barber => "#{@barber}", :color => "#{@color}"
	erb "Thanks, #{@username}. Barber #{@barber} will be waiting for you on #{@date}. "

end

get '/contacts' do
	erb :contacts
end

post '/contacts' do
	@username = params[:username]
	@email = params[:email]
	@text = params[:text]

	Contact.create :username => "#{@username}", :email => "#{@email}", :text => "#{@text}"
	erb  "Thanks, #{@username}!"
end






