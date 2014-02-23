class FaqsController < ApplicationController
  load_and_authorize_resource skip_load_resource only: [:create] 
  before_action :set_faq, only: [:edit, :update, :destroy]
  
  # GET /faqs
  # GET /faqs.json
  def index
    @faqs = Faq.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @faqs }
    end
  end

  # GET /faqs/new
  # GET /faqs/new.json
  def new
    @faq = Faq.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @faq }
    end
  end

  # GET /faqs/1/edit
  def edit
  end

  # POST /faqs
  # POST /faqs.json
  def create
    @faq = Faq.new(faq_params)

    respond_to do |format|
      if @faq.save
        format.html { redirect_to faqs_path, notice: 'Faq was successfully created.' }
        format.json { render json: @faq, status: :created, location: @faq }
      else
        format.html { render action: "new" }
        format.json { render json: @faq.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /faqs/1
  # PUT /faqs/1.json
  def update
    respond_to do |format|
      if @faq.update_attributes(faq_params)
        format.html { redirect_to faqs_path, notice: 'Faq was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @faq.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /faqs/1
  # DELETE /faqs/1.json
  def destroy
    @faq.destroy

    respond_to do |format|
      format.html { redirect_to faqs_url }
      format.json { head :no_content }
    end
  end

  private
  def set_faq
    @faq = Faq.find(params[:id])
  end

  def faq_params
    params.require(:faq).permit(:question, :answer)
  end
end
