# frozen_string_literal: true
class NotesController < ApplicationController
  include Pagy::Backend
  load_and_authorize_resource except: :index

  def index
    pagy, notes =
      pagy(Note.accessible_by(Current.ability).ordered_by_created_at)
    respond_to do |format|
      format.html
      format.json do
        render json: { last_page: pagy.pages, data: load_json(notes) }
      end
    end
  end

  def create
    @note = Note.new(note_params)
    if @note.save
      redirect_to notes_path, notice: t('.notice', name: @note.title)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @note = Note.find(params[:id])
  end

  def update
    @note = Note.find(params[:id])
    @note.update(note_params)
    if @note.valid?
      redirect_to notes_path
    else
      flash.now[:alert] = t('.alert')
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    redirect_to notes_path
  end

  def hide
    @note = Note.find(params[:id])
    @note.update(hidden: params[:hidden])
    
    render json: { message: "Success" }
  end

  private

  def load_json(notes)
    notes.as_json(
      methods: %i[
        hidden?
        link
        organization_name
        organization_link
        participant_name
        participant_link
      ]
    )
  end

  def note_params
    params.require(:note).permit(:title, :value)
  end
end
