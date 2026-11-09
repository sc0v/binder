# frozen_string_literal: true

class UrgentsController < ApplicationController
  load_and_authorize_resource except: %i[index archived]

  def index
    @urgents =
      Urgent
        .accessible_by(Current.ability)
        .active
        .unhidden
        .ordered_by_created_at
  end

  def show
    @urgent = Urgent.find(params[:id])
    return unless @urgent.archived?

    redirect_to archived_urgents_path, alert: t('.archived')
  end

  def new
    @urgent = Urgent.new
  end

  def edit
    @urgent = Urgent.find(params[:id])
  end

  def create
    @urgent = Urgent.new(urgent_params)
    if @urgent.save
      redirect_to root_path, notice: t('.notice')
    else
      flash.now[:alert] = t('.save_error')
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @urgent = Urgent.find(params[:id])
    if @urgent.update(urgent_params)
      redirect_to urgents_path, notice: t('.notice')
    else
      flash.now[:alert] = t('.alert')
      render :edit, status: :unprocessable_entity
    end
  end

  def archive
    @urgent.update(archived_at: Time.current)
    redirect_to root_path, notice: t('.notice')
  end

  def unarchive
    @urgent.update(archived_at: nil)
    redirect_to archived_urgents_path, notice: t('.notice')
  end

  def archived
    @urgents =
      Urgent.accessible_by(Current.ability).archived.ordered_by_created_at
  end

  private

  def urgent_params
    params.expect(urgent: %i[title value participant_id hidden])
  end
end
