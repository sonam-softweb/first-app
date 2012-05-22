class ProjectController < ApplicationController
   def list
      @projects = Project.find(:all)
   end
   def show
      @project = Project.find(params[:id])
   end
   def new
      @project = Project.new
      @user_right = UserRight.find(@current_user.id)
      @installer_id = @user_right.installer_id
   end
   def create
      @project = Project.new(params[:project])
      if @project.save
            redirect_to :action => 'list'
      else           
            render :action => 'new'
      end
   end
   def edit
      @project = Project.find(params[:id])
   end
   def update
      @project = Project.find(params[:id])
      if @project.update_attributes(params[:project])
         redirect_to :action => 'list'
      else
         render :action => 'edit'
      end
   end
   def delete
      Project.find(params[:id]).destroy
      redirect_to :action => 'list'
   end
end
