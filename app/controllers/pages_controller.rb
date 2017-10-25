class PagesController < ApplicationController

  def home
    redirect_to apps_path if logged_in?
  end

end
