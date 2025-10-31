
# author: Boris Barroso
# email: boriscyber@gmail.com

=begin
このプロジェクトは、単に経費を括るだけのもの。タスク管理・進捗管理も何もない

-> Production Order として作り直す
Production Process がどのようなものか、については、例えば
https://learning.sap.com/courses/managing-logistics-in-sap-business-one/running-the-production-process-in-sap-business-one
=end


class ProdOrdersController < ApplicationController
  before_action :set_project, :only => [:show, :edit, :update, :destroy]
  # GET /projects
  def index
    @projects = Project.page(@page)
  end

  # GET /projects/1
  def show
  end

  # GET /projects/new
  def new
    @project = Project.new(:active => true)
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects
  # POST /projects.xml
  def create
    @project = Project.new(project_params)

    if @project.save
      redirect_ajax(@project, notice: 'El project fue creado.')
    else
      render "new"
    end
  end

  # PUT /projects/1
  # PUT /projects/1.xml
  def update
    if @project.update(project_params)
      redirect_to(@project, :notice => 'El project fue actualizado.')
    else
      render :action => "edit"
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.xml
  def destroy
    @project.destroy
    redirect_ajax @project
  end

  private

    def set_project
      @project = Project.find(params[:id])
    end

    def project_params
      params.require(:project).permit(:name, :active, :date_start,
                                     :date_end, :description)
    end
end
