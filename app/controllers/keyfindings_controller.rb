class KeyfindingsController < ApplicationController
  # GET /keyfindings
  # GET /keyfindings.json
  def index
    @keyfindings = Keyfinding.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @keyfindings }
    end
  end

  # GET /keyfindings/1
  # GET /keyfindings/1.json
  def show
    @keyfinding = Keyfinding.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @keyfinding }
    end
  end

  # GET /keyfindings/new
  # GET /keyfindings/new.json
  def new
    @keyfinding = Keyfinding.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @keyfinding }
    end
  end

  # GET /keyfindings/1/edit
  def edit
    @keyfinding = Keyfinding.find(params[:id])
  end

  # POST /keyfindings
  # POST /keyfindings.json
  def create
    @keyfinding = Keyfinding.new(params[:keyfinding])

    respond_to do |format|
      if @keyfinding.save
        format.html { redirect_to @keyfinding, notice: 'Keyfinding was successfully created.' }
        format.json { render json: @keyfinding, status: :created, location: @keyfinding }
      else
        format.html { render action: "new" }
        format.json { render json: @keyfinding.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /keyfindings/1
  # PUT /keyfindings/1.json
  def update
    @keyfinding = Keyfinding.find(params[:id])

    respond_to do |format|
      if @keyfinding.update_attributes(params[:keyfinding])
        format.html { redirect_to @keyfinding, notice: 'Keyfinding was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @keyfinding.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /keyfindings/1
  # DELETE /keyfindings/1.json
  def destroy
    @keyfinding = Keyfinding.find(params[:id])
    @keyfinding.destroy

    respond_to do |format|
      format.html { redirect_to keyfindings_url }
      format.json { head :no_content }
    end
  end
end
