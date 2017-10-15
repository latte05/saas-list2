class AppsController < ApplicationController

  def index
    @apps = App.all
  end


  def new
    @app = App.new
  end

  def edit
   @app = App.find(params[:id])
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
   @app = App.find(params[:id])
   if @app.update(app_params)
      flash[:notice] = "Application was successfully updated"
      redirect_to app_path(@app)
  else
     render 'edit'
  end

 end


 def show
   @app = App.find(params[:id])
 end


  private
  def app_params
      params.require(:app).permit(:app_name, :remarks)
  end

end
