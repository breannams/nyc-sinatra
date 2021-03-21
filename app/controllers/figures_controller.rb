class FiguresController < ApplicationController

  get '/figures' do
    @figure = Figure.all
    erb :'/figures/index' 
  end

  get '/figures/new' do 
    @title = Title.all
    @landmark = Landmark.all
    erb :'/figures/new'
  end

  post '/figures' do 
    @figure = Figure.create(params[:figure])
    if !params[:landmark][:name].empty?
      @figure.landmarks << Landmark.create(params[:landmark])
    end

    if !params[:title][:name].empty?
      @figure.titles << Title.create(params[:title])
    end

    @figure.save
    redirect "figures/#{@figure.id}"
  end

  get '/figures/:id/edit' do 
    @figure = Figure.find_by_id(params[:id])
    @title = Title.all
    @landmark = Landmark.all
    erb :'/figures/edit'
  end

  get '/figures/:id' do 
    @figure = Figure.find_by_id(params[:id])
    erb :'/figures/show'
  end

  patch '/figures/:id' do 
    @figure = Figure.find_by_id(params[:id])

    @figure.update(params[:figure])

    if !params[:title][:name].empty?
      @figure.titles << Title.create(name: params[:title])
    end

    if !params[:landmark][:name].empty?
      @figure.landmarks << Landmark.create(name: params[:landmark])
    end
    @figure.save
    redirect to "/figures/#{@figure.id}"
  end

end
