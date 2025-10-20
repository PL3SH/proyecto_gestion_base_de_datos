class EmployersController < ApplicationController
  def index
    @employers = Employer.all
  end

  def show
    @employer = Employer.find(params[:id])
  end

  def new
    @employer = Employer.new
  end

  def create
    @employer = Employer.new(employer_params)
    if @employer.save
      redirect_to employer_path(@employer), notice: "Employer created"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def employer_params
    params.require(:employer).permit(:name, :email, :available)
  end
end
