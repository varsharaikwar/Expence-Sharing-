class DebtsController < ApplicationController
  def index
    @debts = Debt.all
  end

  def show
    @debt = Debt.find(params[:id])
  end

  def new
    @user = User.find(params[:user_id])
    @debt = @user.debt.new
  end

  def create
    @user = User.find(params[:user_id])

    @debt = @user.debt.create(debt_params)

    redirect_to debt_path(@debt)
  end

  def edit
    @debt = Debt.find(params[:id])
  end

  def update
    @debt = Debt.find(params[:id])
    @debt.update(debt_params)

    redirect_to debt_path(@debt)
  end

  def destroy
    @debt = Debt.find(params[:id])
    @debt.destroy

    redirect_to debts_path
  end

  # strong params
  private
  def debt_params
    params.require(:debt).permit(:debtor_id, :reconciled, :expense_id, :amount)
  end
end
