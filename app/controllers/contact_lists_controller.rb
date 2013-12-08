class ContactListsController < ApplicationController
  load_and_authorize_resource
  
  # GET /contact_lists
  # GET /contact_lists.json
  def index
    @contact_lists = ContactList.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @contact_lists }
    end
  end

  # GET /contact_lists/1
  # GET /contact_lists/1.json
  def show
    @contact_list = ContactList.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @contact_list }
    end
  end

  # GET /contact_lists/new
  # GET /contact_lists/new.json
  def new
    @contact_list = ContactList.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @contact_list }
    end
  end

  # GET /contact_lists/1/edit
  def edit
    @contact_list = ContactList.find(params[:id])
  end

  # POST /contact_lists
  # POST /contact_lists.json
  def create
    @contact_list = ContactList.new(params[:contact_list])

    respond_to do |format|
      if @contact_list.save
        format.html { redirect_to @contact_list, notice: 'Contact list was successfully created.' }
        format.json { render json: @contact_list, status: :created, location: @contact_list }
      else
        format.html { render action: "new" }
        format.json { render json: @contact_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /contact_lists/1
  # PUT /contact_lists/1.json
  def update
    @contact_list = ContactList.find(params[:id])

    respond_to do |format|
      if @contact_list.update_attributes(params[:contact_list])
        format.html { redirect_to @contact_list, notice: 'Contact list was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @contact_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contact_lists/1
  # DELETE /contact_lists/1.json
  def destroy
    @contact_list = ContactList.find(params[:id])
    @contact_list.destroy

    respond_to do |format|
      format.html { redirect_to contact_lists_url }
      format.json { head :no_content }
    end
  end
end
