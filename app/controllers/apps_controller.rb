class AppsController < ApplicationController
  before_action :set_app, only:[:edit, :update, :show, :destroy]
  before_action :require_user, except: [:index, :show]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def index
    #if it is searched
    @apps = if params[:term]
          @apps = App.search(params[:term])
    else
          @apps = App.all
    end

    respond_to do |format|
      format.html
      format.csv { send_data @apps.to_csv }
      format.xls
    end

  end

  def new
    @app = App.new
  end

  def edit
  end

  def import
    App.import(params[:file], current_user)
    flash[:success] = "Application File is imported."
    redirect_to apps_path
  end

  def create
    #render plain: params[:app].inspect
    #debugger
    @app = App.new(app_params)

    @app.user = current_user
    if @app.save
      flash[:success] = "App was successfully added"
      redirect_to app_path(@app)
    else
      render 'new'
    end
 end

 def update
   if @app.update(app_params)
      flash[:success] = "Application was successfully updated"
      redirect_to app_path(@app)
  else
     render 'edit'
  end

 end

 def show

 end

 def destroy
    @app.destroy
    flash[:danger] = "Application was successfully deleted"
    redirect_to apps_path
 end


  private
    def set_app
      @app = App.find(params[:id])
    end

    def app_params
        params.require(:app).permit(:app_name, :remarks, :term, :req_latency, :req_jitter, :req_packet_drop, :req_bw, :user_id)
    end

    def require_same_user
      if current_user != @app.user and !current_user.admin?
        flash[:danger] = "You can only edit or delete your own app"
        redirect_to root_path
      end
    end

end
