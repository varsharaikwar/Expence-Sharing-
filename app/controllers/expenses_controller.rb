class ExpensesController < ApplicationController

  # replace Expense
  # replace expense
  def index
    @expenses = Expense.all
  end

  def show
    @expense = Expense.find(params[:id])
  end

  def new
    @expense = Expense.new
  end

  def create
    @expense = Expense.new(expense_params)
    @expense.user_id = current_user.id
    @expense.save

    # Should I create the debt here?
    @debt = Debt.new()

    redirect_to user_path(current_user)
  end

  def edit
    @expense = Expense.find(params[:id])
  end

  def update
    @expense = Expense.find(params[:id])
    @expense.update(expense_params)

    redirect_to expense_path(@expense)
  end

  def destroy
    @expense = Expense.find(params[:id])
    @expense.destroy

    redirect_to expenses_path
  end

  # strong params
  private
  def expense_params
    params.require(:expense).permit(:amount, :reconciled, :expense_id, :user_id, :date, :notes, :share, :name)
  end
  def debt_params
    params.require(:expense).permit(:amount, :reconciled, :expense_id, :user_id, :date, :notes, :share, :name)
  end
end
