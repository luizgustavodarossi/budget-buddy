class TransactionsController < ApplicationController
  before_action :set_transaction, only: %i[ show edit update destroy ]

  def index
    @transactions = current_user.transactions
  end

  def show
  end

  def new
    @transaction = current_user.transactions.new

    set_transaction_kind
    set_accountable_type
  end

  def edit
  end

  def create
    @transaction = current_user.transactions.new(transaction_params)

    respond_to do |format|
      if @transaction.save
        format.html { redirect_to transaction_url(@transaction), notice: "Transaction was successfully created." }
        format.json { render :show, status: :created, location: @transaction }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @transaction.update(transaction_params)
        format.html { redirect_to transaction_url(@transaction), notice: "Transaction was successfully updated." }
        format.json { render :show, status: :ok, location: @transaction }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @transaction.destroy

    respond_to do |format|
      format.html { redirect_to transactions_url, notice: "Transaction was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_transaction
      @transaction = current_user.transactions.find(params[:id])

      set_categories_for_transaction
      set_accounts_and_credit_cards
    end

    def transaction_params
      params.require(:transaction).permit(:kind, :amount, :emitted_at, :description, :observation, :category_id, :accountable_id, :accountable_type)
    end

    def set_transaction_kind
      @transaction.kind = {
        "transfer" => :transfer,
        "income" => :income,
        "expense" => :expense
      }.fetch(params[:kind], :expense)

      set_categories_for_transaction if @transaction.income? || @transaction.expense?
    end

    def set_accountable_type
      @transaction.accountable_type = params[:accountable_type] || "Account"
      set_accounts_and_credit_cards
    end

    def set_categories_for_transaction
      @categories = current_user.categories.send(@transaction.kind.to_s.pluralize)
    end

    def set_accounts_and_credit_cards
      if @transaction.accountable_type == "Account"
        @accounts = current_user.accounts
      else
        @credit_cards = current_user.credit_cards
      end
    end
end
