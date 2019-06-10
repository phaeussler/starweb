class StarshipsController < ApplicationController
  before_action :set_starship, only: [:show, :edit, :update, :destroy]

  # GET /starships
  # GET /starships.json
  def index
    @starships = get_all()
  end

  # GET /starships/1
  # GET /starships/1.json
  def show
    # puts "id #{params[:id]}"
    @starship= get_one(params[:id])
  end

  # GET /starships/new
  def new
    @starship = Starship.new
  end

  # GET /starships/1/edit
  def edit
  end

  # POST /starships
  # POST /starships.json
  def create
    @starship = Starship.new(starship_params)

    respond_to do |format|
      if @starship.save
        format.html { redirect_to @starship, notice: 'Starship was successfully created.' }
        format.json { render :show, status: :created, location: @starship }
      else
        format.html { render :new }
        format.json { render json: @starship.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /starships/1
  # PATCH/PUT /starships/1.json
  def update
    respond_to do |format|
      if @starship.update(starship_params)
        format.html { redirect_to @starship, notice: 'Starship was successfully updated.' }
        format.json { render :show, status: :ok, location: @starship }
      else
        format.html { render :edit }
        format.json { render json: @starship.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /starships/1
  # DELETE /starships/1.json
  def destroy
    @starship.destroy
    respond_to do |format|
      format.html { redirect_to starships_url, notice: 'Starship was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_starship
      # @starship = Starship.find(params[:id])
      # @starship = execute_request("starships/#{params[:id]}")
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def starship_params
      params.fetch(:starship, {})
    end

    def get_all()
      puts "get all starships"
      query = 
      "{
        allStarships {
          edges {
            node {
              ...starshipFragment
            }
          }
        }
      }
      
      fragment starshipFragment on Starship {
        # id
        name
        model
      #   starshipClass
      #   manufacturers
        costInCredits
      #   length
      #   crew
      #   passengers
      #   maxAtmospheringSpeed
      #   hyperdriveRating
      #   MGLT
        cargoCapacity
      #   consumables
      #   pilotConnection { edges { node { ...pilotFragment }}}
      #   filmConnection { edges { node { ...filmFragment }}}
      # }
      # fragment pilotFragment on Person {
      #   name
      # }
      # fragment filmFragment on Film{
      #   title
      }"
      code, body = execute_request(query)
      puts "body[:data] #{body['data']['allStarships']['edges']}, #{body.class.name}"
      return body['data']['allStarships']['edges']
    end

    def get_one(id)
      puts "get one starship id #{id}"
      query = 
        "{
          starship(starshipID: #{id}) {
            ...starshipFragment
          } 
        }
        
        fragment starshipFragment on Starship {
          id
          name
          model
          starshipClass
          manufacturers
          costInCredits
          length
          crew
          passengers
          maxAtmospheringSpeed
          hyperdriveRating
          MGLT
          cargoCapacity
          consumables
          MGLT
          pilotConnection { edges { node { ...pilotFragment }}}
          filmConnection { edges { node { ...filmFragment }}}
        }
        fragment pilotFragment on Person {
          name
        }
        fragment filmFragment on Film{
          title
        }"
      code, body = execute_request(query)
      puts "body[:data] #{body['data']['starship']}, #{body.class.name}"
      return body['data']["starship"]
  end
end
