class ApplicationController < Sinatra::Base

  set :default_content_type, 'application/json'
  # add routes

  get '/bakeries' do
    #get all the bakeries from the database
    bakeries = Bakery.all
    #send them back as a JSON array
    bakeries.to_json
  end

  #use the :id syntax to create a dynamic route
  get '/bakeries/:id' do
    #look up the bakery in the database using its ID
    bakery = Bakery.find(params[:id])
    #send a JSON-formatted response of the bakery data
    bakery.to_json(include: :baked_goods)
  end

  get '/baked_goods/by_price' do
    #get all the baked_goods from the database
    baked_goods = BakedGood.order(price: :desc)
    #send a JSON-formatted response of the baked_goods data sorted by price
    baked_goods.to_json(only: [:name, :price])
  end

  get '/baked_goods/most_expensive' do
    #get all the baked_goods from the database
    baked_goods = BakedGood.order(price: :desc).first
    #send a JSON-formatted response of the baked_goods data sorted by price
    baked_goods.to_json(only: [:name, :price])
  end

end
