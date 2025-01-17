class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @movies = Movie.all
    # puts("Hi")
    
    params_sort = params[:sort]
    
    
    if params_sort == nil
      @sort = session[:sort]
      flash.keep
      redirect_to movies_path(:sort)
    else
      session[:sort] = params_sort
    end

   
    if session[:sort] == "title"
        @movie_hilite = "hilite"
        @movies = Movie.getSortedTitle
    elsif session[:sort] == "release"
        @release_hilite = "hilite"
        @movies = Movie.getSortedRating 
    end  
      
    
    
    
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end
  
  # def sort
  #   @movies = Movie.getSortedTitle
  # end
  
  private
  # Making "internal" methods private is not required, but is a common practice.
  # This helps make clear which methods respond to requests, and which ones do not.
  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end
end
