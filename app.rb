require 'sinatra/base'
require 'data_mapper'
require 'pp'

DataMapper::Logger.new($stdout, :debug)
DataMapper.setup(:default, (ENV["DATABASE_URL"]|| 'sqlite://'+File.expand_path('../platten.db',__FILE__)))
DataMapper::Model.raise_on_save_failure=true

class Music
  include DataMapper::Resource
  property :id, Serial
  property :lfdnr, Text
  property :interpret, Text
  property :titel, Text
  property :record, Text
  property :size, Text
  property :seite, Text
  property :datum, Text
  property :label, Text
  property :no, Text
  property :ablage, Text
  property :dauer, Text
  property :anzahl, Text
  property :reihenfolge, Text
  property :name, Text
end


DataMapper.finalize
DataMapper.auto_upgrade!


class MusicApp < Sinatra::Base

  get '/' do
    erb :index
  end
  
  get '/neu' do
    erb :neu
  end
  
  post '/entry' do
    Music.create!(params)
      pp params
    redirect '/'
  end

  post '/delete' do
    pp params
    @del=Music.get(params["id"])
    @del.destroy
    redirect 'search'
  end
    
  get '/search' do
    hash={}

    Music.properties.each{|p|
      hash[p.name.like]=params[p.name.to_s]+"%" if params[p.name.to_s]
    }
    #methods.sort
#exit
   # hash[:interprete.like]=params["interprete"]+"%" if params["interprete"]
    @music=Music.all(hash)
    erb :result
  end

end
