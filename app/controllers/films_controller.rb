class FilmsController < ApplicationController
  before_action :set_film, only: [:show, :edit, :update, :destroy]
  
  # GET /films
  # GET /films.json
  def index
    # @films = Film.all
    @films = get_all()
  end

  # GET /films/1
  # GET /films/1.json
  def show
    @film = get_one(params[:id])
  end

  # GET /films/new
  def new
    @film = Film.new
  end

  # GET /films/1/edit
  def edit
  end

  # POST /films
  # POST /films.json
  def create
    @film = Film.new(film_params)

    respond_to do |format|
      if @film.save
        format.html { redirect_to @film, notice: 'Film was successfully created.' }
        format.json { render :show, status: :created, location: @film }
      else
        format.html { render :new }
        format.json { render json: @film.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /films/1
  # PATCH/PUT /films/1.json
  def update
    respond_to do |format|
      if @film.update(film_params)
        format.html { redirect_to @film, notice: 'Film was successfully updated.' }
        format.json { render :show, status: :ok, location: @film }
      else
        format.html { render :edit }
        format.json { render json: @film.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /films/1
  # DELETE /films/1.json
  def destroy
    @film.destroy
    respond_to do |format|
      format.html { redirect_to films_url, notice: 'Film was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_film
      # @film = Film.find(params[:id])
      # @film = execute_request("films/#{params[:id]}")
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def film_params
      params.require(:film).permit(:name, :year, :director, :productor, :episode)
    end
    
    def get_all()
      query = 
      "{allFilms {
        edges {
          node {
            episodeID
            title
            director
            producers
            releaseDate
          }
        }
      }}"
      code, body = execute_request(query)
      puts "body[:data] #{body['data']['allFilms']['edges']}, #{body.class.name}"
      return body['data']['allFilms']['edges']

      # {"data"=>{"allFilms"=>{"edges"=>
      # response = execute_request("films")
      # response['results'].sort_by { |f| [f['release_date']] }
    end

    def get_one(id)
      puts "get one film id #{id}"
      query = 
        "{
          film(filmID: #{id}) {
            title
            episodeID
            openingCrawl
            director
            producers
            releaseDate
            starshipConnection {
              edges {
                node {
                  id
                }
              }
            }
            characterConnection {
              edges {
                node {
                  id
                }
              }
            }
          }
        }"
      code, body = execute_request(query)
      puts "body[:data] #{body['data']['film']}, #{body.class.name}"
      return body['data']["film"]

    end
    
    

    # def execute_request(extra)
    #   require 'net/http'
      # require 'json'
    #   uri = URI("#{BASE_URL}/#{extra}")
    #   response = Net::HTTP.get(uri)
    #   JSON.parse(response)
    # end
end
