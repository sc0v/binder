class DocumentsController < ApplicationController
  load_and_authorize_resource skip_load_resource only: [:create] 

  def index
    @documents = Document.order(:name)
  end

  def show
    @document = Document.find(params[:id])
    @document_url_path = @document.url.to_s
  end

  def new
    @document = Document.new
  end

  def edit
    @document = Document.find(params[:id])
  end


  def create
    @document = Document.new(create_document_params)

    if @document.save
      flash[:notice] = "#{@document.name} has been created."
      redirect_to documents_path
    else
      render :action => 'new'
    end
  end

  def update
    @document = Document.find(params[:id])

    if @document.update_attributes(update_document_params)
      flash[:notice] = "#{@document.name} was updated."
      redirect_to documents_path
    else
      render :action => 'edit'
    end
  end

  def destroy
    @document = Document.find(params[:id])
    @document.destroy

    flash[:notice] = "Successfully removed #{@document.name} from BOA."
    redirect_to documents_path
  end

  private

  def create_document_params
    params.require(:document).permit(:name, :organization_id, :public, :url)
  end

  def update_document_params
    params.require(:document).permit(:name, :organization_id, :public)
  end
end

