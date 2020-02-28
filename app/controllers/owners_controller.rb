class OwnersController < ApplicationController

  get '/owners' do
    @owners = Owner.all
    erb :'/owners/index' 
  end

  get '/owners/new' do 
    @pets = Pet.all 
    erb :'/owners/new'
  end

  post '/owners' do 
    owner = Owner.create(params[:owner])
    # BEST PRACTICE???
    # new_pet = Pet.new(params[:pet]) if !params[:pet][:name].empty? 
    # owner.pets.push(new_pet) if !new_pet.nil?
    if !params[:pet][:name].empty? 
      owner.pets << Pet.create(params["pet"]) # Shovel to push one instance?
    end
    redirect "/owners/#{owner.id}"
  end

  get '/owners/:id/edit' do 
    @owner = Owner.find(params[:id])
    @pets = Pet.all
    erb :'/owners/edit'
  end

  get '/owners/:id' do 
    @owner = Owner.find(params[:id])
    erb :'/owners/show'
  end

  patch '/owners/:id' do 
    owner = Owner.update(params[:id],params[:owner])
    new_pet = Pet.new(params[:pet]) if !params[:pet][:name].empty? 
    owner.pets.push(new_pet) if !new_pet.nil?
    redirect "/owners/#{owner.id}"
  end
end