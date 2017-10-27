class CompaniesController < ApplicationController
  before_action :set_company, only: [:edit, :update, :show]
#  before_action :require_same_user, only: [:edit, :update, :destroy]
#  before_action :require_admin, only: [:destroy]

  def index
    @companies = Company.all
  end

  def new
    @company = Company.new
  end

  def create
    @company = Company.new(company_params)
    if @company.save
      flash[:success] = "Company was successfully added"
      redirect_to company_path(@company)
    else
      render 'new'
    end
  end

  def edit
    #@company = Company.find(params[:id])
  end

  def update
    #@company = Company.find(params[:id])
    if @company.update(company_params)
      flash[:success] = "Company was updated succcessfully"
      redirect_to companies_path
    else
        render 'edit'
    end
  end

  def show
    #  @company = Company.find(params[:id])
  end

  def destroy
    @company = Company.find(params[:id])
    @company.destroy
    flash[:danger] = "Comapnies are deleted"
    redirect_to companies_path
  end

  private
    def company_params
      params.require('company').permit(:company_name, :company_url)
    end

    def set_company
      @company = Company.find(params[:id])
    end

    def require_same_user
      if current_user != @app.user and !current_user.admin?
        flash[:danger] = "You can only edit or delete"
        redirect_to root_path
      end
    end

end
