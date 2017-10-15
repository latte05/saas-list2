class AppsController < ApplicationController

  before_action :set_app, only:[:edit, :update, :show, :destroy]


  def index
    @apps = App.all
  end

  def new
    @app = App.new
  end

  def edit
  end

  def create
    #render plain: params[:app].inspect
    @app = App.new(app_params)
    if @app.save
      flash[:notice] = "App was successfully added"
      redirect_to app_path(@app)
    else
      render 'new'
    end
 end

 def update
   if @app.update(app_params)
      flash[:notice] = "Application was successfully updated"
      redirect_to app_path(@app)
  else
     render 'edit'
  end

 end

 def show
 end

 def destroy
    @app.destroy
    flash[:notice] = "Application was successfully deleted"
    redirect_to apps_path
 end


  private
    def set_app
      @app = App.find(params[:id])
    end

    def app_params
        params.require(:app).permit(:app_name, :remarks)
    end

end
