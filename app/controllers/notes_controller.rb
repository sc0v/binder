# frozen_string_literal: true

class NotesController < ApplicationController
  load_and_authorize_resource except: :index

  def index
    notes = Note.accessible_by(Current.ability).ordered_by_created_at
    respond_to do |format|
      format.html
      format.json { render json: notes_json_page(notes) }
    end
  end

  def show
    @note = Note.find(params[:id])
  end

  def edit
    @note = Note.find(params[:id])
  end

  def create
    @note = Note.new(note_params)
    if @note.save
      redirect_to root_path, notice: t('.notice')
    else
      redirect_to root_path, notice: t('.save_error')
    end
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
    if @note.destroy
      redirect_to root_path, notice: t('.notice')
    else
      redirect_to root_path, alert: t('.alert')
    end
  end

  def archive
    @note = Note.find(params[:id])
    @note.update(archived_at: Time.current)
    redirect_to root_path, notice: "Note archived."
  end

  def hide
    @note = Note.find(params[:id])
    @note.update(hidden: params[:hidden])

    render json: { message: 'Success' }
  end

  private

  def notes_json_page(notes)
    page = params[:page].present? ? params[:page].to_i : 1
    size = params[:size].present? ? params[:size].to_i : 1
    offset = (page - 1) * size
    last_page = (notes.count / size) + ((notes.count % size).zero? ? 0 : 1)
    { last_page:, data: load_json(notes.offset(offset).limit(size)) }
  end

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
    params.expect(note: %i[title value participant_id hidden color])
  end
end
