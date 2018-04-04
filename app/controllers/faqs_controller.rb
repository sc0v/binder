# ## Schema Information
#
# Table name: `faqs`
#
# ### Columns
#
# Name              | Type               | Attributes
# ----------------- | ------------------ | ---------------------------
# **`answer`**      | `text`             |
# **`created_at`**  | `datetime`         |
# **`id`**          | `integer`          | `not null, primary key`
# **`question`**    | `text`             |
# **`updated_at`**  | `datetime`         |
#

class FaqsController < ApplicationController
  load_and_authorize_resource skip_load_resource only: [:create] 
  before_action :set_faq, only: [:edit, :update, :destroy]

  # GET /faqs
  # GET /faqs.json
  def index
    @faqs = Faq.all
    authorize! :read, @faqs
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
    redirect_to faqs_path
  end

  # PUT /faqs/1
  # PUT /faqs/1.json
  def update
    @faq.update_attributes(faq_params)
    redirect_to faqs_path
  end

  # DELETE /faqs/1
  # DELETE /faqs/1.json
  def destroy
    @faq.destroy
    redirect_to faqs_path
  end

  private
  def set_faq
    @faq = Faq.find(params[:id])
  end

  def faq_params
    params.require(:faq).permit(:question, :answer)
  end
end
