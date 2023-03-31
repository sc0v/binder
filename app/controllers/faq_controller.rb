# frozen_string_literal: true

class FAQController < ApplicationController
  load_and_authorize_resource

  def index
    @category_faq =
      FAQ.accessible_by(Current.ability).group_by(&:organization_category)
  end

  def new; end

  # TODO: Inline Edit
  def edit; end

  def create
    if @faq.save
      redirect_to faq_index_path, notice: t('.notice', name: @faq.question)
    else
      flash.now[:alert] = t('.alert')
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @faq.update(faq_params)
    if @faq.valid?
      redirect_to faq_index_path, notice: t('.notice', name: @faq.question)
    else
      flash.now[:alert] = t('.alert')
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @faq.destroy
      redirect_to faq_index_path, notice: t('.notice', name: @faq.question)
    else
      redirect_to faq_index_path, alert: t('.alert', name: @faq.question)
    end
  end

  private

  def faq_params
    params.require(:faq).permit(:question, :answer, :organization_category_id)
  end
end
