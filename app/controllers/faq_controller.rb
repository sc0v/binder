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
    @faq.update(update_params)
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

  def update_params
    params.require(:faq).permit(
      Current.ability.permitted_attributes(:update, @faq)
    )
  end

  def create_params
    params.require(:faq).permit(
      Current.ability.permitted_attributes(:create, FAQ)
    )
  end

end
