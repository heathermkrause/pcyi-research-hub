class DocumentsController < ApplicationController
  # GET /documents
  # GET /documents.json

  #before_filter :authenticate_user!
  
  def index

    if params[:search].present?
      @documents = Document.search(params[:search])
      @page_title = "Search results"
    elsif (age_range = params[:age_range]).present?
      age_range.eql?("All ages") ? @documents = Document.all : @documents = Document.tagged_with(age_range)
      @page_title = age_range
    else
      #@documents = Document.link_present.random(5)
      @documents = Document.link_present.limit(5)
    end

    @keyfinding_of_document = @documents.empty? ? [] : Keyfinding.where(:document_id => @documents.map(&:id))

    @keyword = Keyword.new

    respond_to do |format|
    format.html # index.html.erb
    format.json { render json: @documents }
    end
  end

  # GET /documents/1
  # GET /documents/1.json
  def show
    @document = Document.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @document }
    end
  end

  # GET /documents/new
  # GET /documents/new.json
  def new
    @document = Document.new
    @keyfinding = Keyfinding.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @document }
    end
  end

  # GET /documents/1/edit
  def edit
    @document = Document.find(params[:id])
  end

  # POST /documents
  # POST /documents.json
  def create
    @document = current_user.documents.new(params[:document])

    respond_to do |format|
      if @document.save
        format.html { redirect_to :action => "index", notice: 'Document was successfully created.' }
        format.json { render json: @document, status: :created, location: @document }
      else
        flash[:alert] = error_messages(@document.errors)

        format.html { render action: "new" }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /documents/1
  # PUT /documents/1.json
  def update
    @document = Document.find(params[:id])

    respond_to do |format|
      if @document.update_attributes(params[:document])
          format.html { redirect_to :action => "index", notice: 'Document was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /documents/1
  # DELETE /documents/1.json
  def destroy
    @document = Document.find(params[:id])
    @document.destroy

    respond_to do |format|
      format.html { redirect_to documents_url }
      format.json { head :no_content }
    end
  end

  def create_with_excelsheet
    excelsheet = current_user.excelsheets.new(params[:excelsheet])

    respond_to do |format|
      if excelsheet.save
        format.html { redirect_to :action => "index", notice: 'Document was successfully created.' }
      else
        format.html { redirect_to :back , :alert=> excelsheet.errors[:excelsheet_file].first}
      end
    end

  end

  # Using Searchkick gem. (https://github.com/ankane/searchkick)
  # I don't think this controller method is necessary. (JM, 2014-01-22)
  #def search
  #  require 'will_paginate/array'
  #  if current_user.admin
  #    @documents = Document.find(:all, :include => [:keyfindings,:keywords], :conditions => ["keywords.keyword_text LIKE :search OR keyfindings.keyfinding_text LIKE :search ", :search => "%#{params[:search]}%"])
  #  else
  #    @documents = current_user.documents.find(:all, :include => [:keyfindings,:keywords], :conditions => ["keywords.keyword_text LIKE :search OR keyfindings.keyfinding_text LIKE :search ", :search => "%#{params[:search]}%"])
  #  end
  #  @keyfinding_of_document = @documents.empty? ? [] : Keyfinding.where(:document_id => @documents.map(&:id))
  #  @keyword = Keyword.new
  #
  #  unless @documents.empty?
  #     respond_to do |format|
  #      format.html { render :index }
  #      format.json { render json: @documents }
  #    end
  #  else
  #     #error handeling code
  #     flash[:alert] = "No search results."
  #     redirect_to :action => "index"
  #  end
  #end

  def keywords
    @document = Document.find(params[:id])
     @keyword = Document.find(params[:id]).keywords.first
     respond_to do |format|
        format.js
     end 
  end
end
