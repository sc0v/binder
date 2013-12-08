class TaskCategoriesController < ApplicationController
  # GET /task_categories
  # GET /task_categories.json
  def index
    @task_categories = TaskCategory.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @task_categories }
    end
  end

  # GET /task_categories/1
  # GET /task_categories/1.json
  def show
    @task_category = TaskCategory.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @task_category }
    end
  end

  # GET /task_categories/new
  # GET /task_categories/new.json
  def new
    @task_category = TaskCategory.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @task_category }
    end
  end

  # GET /task_categories/1/edit
  def edit
    @task_category = TaskCategory.find(params[:id])
  end

  # POST /task_categories
  # POST /task_categories.json
  def create
    @task_category = TaskCategory.new(params[:task_category])

    respond_to do |format|
      if @task_category.save
        format.html { redirect_to @task_category, notice: 'Task category was successfully created.' }
        format.json { render json: @task_category, status: :created, location: @task_category }
      else
        format.html { render action: "new" }
        format.json { render json: @task_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /task_categories/1
  # PUT /task_categories/1.json
  def update
    @task_category = TaskCategory.find(params[:id])

    respond_to do |format|
      if @task_category.update_attributes(params[:task_category])
        format.html { redirect_to @task_category, notice: 'Task category was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @task_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /task_categories/1
  # DELETE /task_categories/1.json
  def destroy
    @task_category = TaskCategory.find(params[:id])
    @task_category.destroy

    respond_to do |format|
      format.html { redirect_to task_categories_url }
      format.json { head :no_content }
    end
  end
end
