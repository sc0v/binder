class FaqsController < ApplicationController
  load_and_authorize_resource skip_load_resource only: [:create] 
  before_action :set_faq, only: [:edit, :update, :destroy]
  responders :flash, :html_cache

  # GET /faqs
  # GET /faqs.json
  def index
    @faqs = Faq.all
  end

  # GET /faqs/new
  # GET /faqs/new.json
  def new
    @faq = Faq.new
  end

  # GET /faqs/1/edit
  def edit
  end

  # POST /faqs
  # POST /faqs.json
  def create
    @faq = Faq.new(faq_params)
    @faq.save
    respond_with(@faq)
  end

  # PUT /faqs/1
  # PUT /faqs/1.json
  def update
    @faq.update_attributes(faq_params)
    respond_with(@faq)
  end

  # DELETE /faqs/1
  # DELETE /faqs/1.json
  def destroy
    @faq.destroy
    respond_with(@faq)
  end

  private
  def set_faq
    @faq = Faq.find(params[:id])
  end

  def faq_params
    params.require(:faq).permit(:question, :answer)
  end
end
