require "sinatra"
require "./lib/database"
require "./lib/contact_database"
require "./lib/user_database"

class ContactsApp < Sinatra::Base
  enable :sessions

  def initialize
    super
    @contact_database = ContactDatabase.new
    @user_database = UserDatabase.new

    jeff = @user_database.insert(username: "Jeff", password: "jeff123")
    hunter = @user_database.insert(username: "Hunter", password: "puglyfe")

    @contact_database.insert(:name => "Spencer", :email => "spen@example.com", user_id: jeff[:id])
    @contact_database.insert(:name => "Jeff D.", :email => "jd@example.com", user_id: jeff[:id])
    @contact_database.insert(:name => "Mike", :email => "mike@example.com", user_id: jeff[:id])
    @contact_database.insert(:name => "Kirsten", :email => "kirsten@example.com", user_id: hunter[:id])
  end

  get "/" do
    if session[:user]  != []
      @user = @user_database.find(params[:id])
      @user_contacts = @contact_database.find_for_user(@user[:id])
      erb :logged_in_root
    else
      erb :root
    end
  end

  get '/login' do
    erb :login
  end

  post '/login' do
    active_user = []
    active_user << @user_database.all.find do |user_hash|
      params[:username] == user_hash[:username] && params[:password] == user_hash[:password]
    end
    if active_user != []
      session[:user] = active_user
      redirect '/'
    end
  end

  get '/logout' do
    session[:user] = []
    redirect '/'
  end

end
