class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index' 
  end

  get '/pets/new' do 
    @owners = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do 
    @pet = Pet.create(name: params[:pet_name])
    @pet.owner = Owner.find_by_id(params[:owner_id])
    @new_owner = Owner.new(name: params[:owner_name]) if !params[:owner_name].empty? 
    @pet.owner = @new_owner if !@new_owner.nil?
    @pet.save
    # binding.pry
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do 

    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  get '/pets/:id/edit' do 

    @pet = Pet.find(params[:id])
    @owners= Owner.all

    erb :'/pets/edit'
  end

  patch '/pets/:id' do
    @pet = Pet.find_by_id(params[:id])
    @pet.update(name:params[:pet_name])
    @pet.owner = Owner.find_by_id(params[:owner_id])
    @new_owner = Owner.new(name: params[:owner_name]) if !params[:owner_name].empty? 
    @pet.owner = @new_owner if !@new_owner.nil?
    # binding.pry

    @pet.save
    redirect to "pets/#{@pet.id}"
  end
end