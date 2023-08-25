class CreditCardsController < ApplicationController
  before_action :set_credit_card, only: %i[ show edit update destroy ]

  def index
    @credit_cards = current_user.credit_cards
  end

  def show
  end

  def new
    @credit_card = current_user.credit_cards.new
  end

  def edit
  end

  def create
    @credit_card = current_user.credit_cards.new(credit_card_params)

    respond_to do |format|
      if @credit_card.save
        format.html { redirect_to credit_card_url(@credit_card), notice: "Credit card was successfully created." }
        format.json { render :show, status: :created, location: @credit_card }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @credit_card.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @credit_card.update(credit_card_params)
        format.html { redirect_to credit_card_url(@credit_card), notice: "Credit card was successfully updated." }
        format.json { render :show, status: :ok, location: @credit_card }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @credit_card.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @credit_card.destroy

    respond_to do |format|
      format.html { redirect_to credit_cards_url, notice: "Credit card was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_credit_card
      @credit_card = current_user.credit_cards.find(params[:id])
    end

    def credit_card_params
      params.require(:credit_card).permit(:name, :kind, :balance, :closes_day, :expire_day)
    end
end
