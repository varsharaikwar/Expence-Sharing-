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
    @group = Group.find(params[:group_id])
    @expense = @group.expenses.new
  end

  def create
    @group = Group.find(params[:group_id])
    @expense = @group.expenses.new(expense_params)
    @debtors
    if expense_params[:debtor_ids].nil?
      @debtors = @group.users.reject{|user| user == current_user}
    else
      @debtors = expense_params[:debtor_ids].map do |debtor_id|
        User.find(debtor_id)
      end
    end
    @expense.user_id = current_user.id

    # default share is an even split
    if @expense.share == nil
      @expense.share = @expense.amount / (@debtors.length + 1)
    end
    @expense.save


    # upon creation, create associated debts
    @divided_cost = (@expense.amount - @expense.share)/@debtors.length
    @debtors.each do |debtor|
      debtor.debts.create(amount: @divided_cost, expense: @expense, reconciled: false)
    end


    redirect_to group_user_path(@group, current_user)
  end

  def edit
    @expense = Expense.find(params[:id])
  end

  def update
    @expense = Expense.find(params[:id])
    @expense.update(expense_params)

    redirect_to group_expense_path(@expense)
  end

  def destroy
    @expense = Expense.find(params[:id])
    @expense.destroy

    redirect_to group_expenses_path
  end

  # strong params
  private
  def expense_params
    params.require(:expense).permit(:amount, :expense_id, :user_id, :date, :notes, :share, :name, debtor_ids:[])
  end
  def debt_params
    params.require(:debt).permit(:amount, :reconciled, :expense_id, :debtor_id)
  end
end
