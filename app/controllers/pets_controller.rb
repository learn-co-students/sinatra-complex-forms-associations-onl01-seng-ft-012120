class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  get '/pets/new' do
    erb :'/pets/new'
  end

  post '/pets' do
    @pet = Pet.create(params[:pet])
    # binding.pry
    # @pet.owner = Owner.find(params("pet")("owner_id").first.to_i) 
    if !params["owner"]["name"].empty?
      @pet.owner = Owner.create(name: params["owner"]["name"])
    end 
    @pet.save
    redirect "pets/#{@pet.id}"
  end

  # post '/pets' do
  #   @pet = Pet.create(params[:pet])
  #   @pet.owner = Owner.find(params.fetch("pet").fetch("owner_id").first.to_i) 
  #   if !params["owner"]["name"].empty?
  #     @pet.owner = Owner.create(name: params["owner"]["name"])
  #   end #end is blocking it to save and redirect
  #   @pet.save
  #   redirect "pets/#{@pet.id}"
  # end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    # binding.pry
    erb :'/pets/edit'
  end

  post '/pets/:id' do
    @pet = Pet.find(params[:id])
    @pet.update(params[:pet])
    @pet.owner = Owner.find(params.fetch("pet").fetch("owner_id").last.to_i) if params.fetch("pet")["owner_id"]
    # binding.pry
    if !params["owner"]["name"].empty?
      # binding.pry
      @pet.owner = Owner.create(name: params["owner"]["name"])
    end
    @pet.save
    redirect "pets/#{@pet.id}"
  end
end