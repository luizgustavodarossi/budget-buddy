require 'rails_helper'

RSpec.describe CreditCardsController, type: :controller do
  describe "GET #index" do
    context "when user is logged in" do
      let(:current_user) { create :user }
      let!(:credit_cards) { create_list :credit_card, 3, user: current_user }
      before { sign_in current_user }

      it "returns http success" do
        get :index
        expect(response).to have_http_status :success
      end

      it "returns only the current user's credit card" do
        another_user = create :user
        another_credit_card = create :credit_card, user: another_user

        get :index
        expect(assigns(:credit_cards)).to match_array credit_cards
        expect(assigns(:credit_cards)).not_to include another_credit_card
      end

      it "renders the index template" do
        get :index
        expect(response).to render_template :index
      end
    end

    context "when user is not logged in" do
      let!(:credit_cards) { create_list :credit_card, 3 }

      it "returns http redirect" do
        get :index
        expect(response).to have_http_status(:redirect)
      end
    end
  end

  describe "GET #show" do
    context "when user is logged in" do
      let(:current_user) { create :user }
      let(:credit_card) { create :credit_card, user: current_user }
      before { sign_in current_user }

      it "returns http success" do
        get :show, params: { id: credit_card.id }
        expect(response).to have_http_status :success
      end

      it "returns only the current user's credit card" do
        another_user = create :user
        another_credit_card = create :credit_card, user: another_user

        get :show, params: { id: credit_card.id }
        expect(assigns(:credit_card)).to eq credit_card

        expect do
          get :show, params: { id: another_credit_card.id }
        end.to raise_error(ActiveRecord::RecordNotFound)
      end

      it "renders the show template" do
        get :show, params: { id: credit_card.id }
        expect(response).to render_template :show
      end
    end

    context "when user is not logged in" do
      let(:credit_card) { create :credit_card }

      it "returns http redirect" do
        get :show, params: { id: credit_card.id }
        expect(response).to have_http_status(:redirect)
      end
    end
  end

  describe "GET #new" do
    context "when user is logged in" do
      let(:current_user) { create :user }
      before { sign_in current_user }

      it "returns http success" do
        get :new
        expect(response).to have_http_status :success
      end

      it "returns a new credit card created by the current user" do
        get :new
        expect(assigns(:credit_card)).to be_a_new(CreditCard)
        expect(assigns(:credit_card).user).to eq current_user
      end

      it "renders the new template" do
        get :new
        expect(response).to render_template :new
      end
    end

    context "when user is not logged in" do
      it "returns http redirect" do
        get :new
        expect(response).to have_http_status(:redirect)
      end
    end
  end

  describe "GET #edit" do
    context "when user is logged in" do
      let(:current_user) { create :user }
      let(:credit_card) { create :credit_card, user: current_user }
      before { sign_in current_user }

      it "returns http success" do
        get :edit, params: { id: credit_card.id }
        expect(response).to have_http_status :success
      end

      it "returns only the current user's credit card" do
        another_user = create :user
        another_credit_card = create :credit_card, user: another_user

        get :edit, params: { id: credit_card.id }
        expect(assigns(:credit_card)).to eq credit_card

        expect do
          get :edit, params: { id: another_credit_card.id }
        end.to raise_error(ActiveRecord::RecordNotFound)
      end

      it "renders the edit template" do
        get :edit, params: { id: credit_card.id }
        expect(response).to render_template :edit
      end
    end

    context "when user is not logged in" do
      let(:credit_card) { create :credit_card }

      it "returns http redirect" do
        get :edit, params: { id: credit_card.id }
        expect(response).to have_http_status(:redirect)
      end
    end
  end

  describe "POST #create" do
    context "when user is logged in" do
      let(:current_user) { create :user }
      before { sign_in current_user }

      context "with valid params" do
        let(:valid_params) { attributes_for :credit_card }

        it "creates a new credit card for the current user" do
          expect do
            post :create, params: { credit_card: valid_params }
          end.to change(current_user.credit_cards, :count).by 1
        end

        it "redirects to the created credit card" do
          post :create, params: { credit_card: valid_params }
          expect(response).to redirect_to credit_card_path(CreditCard.last)
        end
      end

      context "with invalid params" do
        let(:invalid_params) { attributes_for :credit_card, name: nil }

        it "does not create a new credit card" do
          expect do
            post :create, params: { credit_card: invalid_params }
          end.to change(CreditCard, :count).by(0)
        end

        it "renders the new template" do
          post :create, params: { credit_card: invalid_params }
          expect(response).to render_template :new
        end
      end
    end

    context "when user is not logged in" do
      let(:valid_params) { attributes_for :credit_card }

      it "returns http redirect" do
        post :create, params: { credit_card: valid_params }
        expect(response).to have_http_status(:redirect)
      end
    end
  end

  describe "PATCH #update" do
    context "when user is logged in" do
      let(:current_user) { create :user }
      let(:credit_card) { create :credit_card, user: current_user }
      before { sign_in current_user }

      context "with valid params" do
        let(:valid_params) { attributes_for :credit_card, name: "Update Name" }

        it "updates the credit card" do
          patch :update, params: { id: credit_card.id, credit_card: valid_params }
          credit_card.reload
          expect(credit_card.name).to eq "Update Name"
        end

        it "redirects to the updated credit card" do
          patch :update, params: { id: credit_card.id, credit_card: valid_params }
          expect(response).to redirect_to credit_card_path(credit_card)
        end
      end

      context "with invalid params" do
        let(:invalid_params) { attributes_for :credit_card, name: nil }

        it "does not update the credit card" do
          patch :update, params: { id: credit_card.id, credit_card: invalid_params }
          credit_card.reload
          expect(credit_card.name).not_to be_nil
        end

        it "renders the edit template" do
          patch :update, params: { id: credit_card.id, credit_card: invalid_params }
          expect(response).to render_template :edit
        end
      end
    end

    context "when user is not logged in" do
      let(:credit_card) { create :credit_card }
      let(:valid_params) { attributes_for :credit_card, name: "Update Name" }

      it "returns http redirect" do
        patch :update, params: { id: 1, credit_card: valid_params }
        expect(response).to have_http_status(:redirect)
      end
    end
  end

  describe "DELETE #destroy" do
    context "when user is logged in" do
      let(:current_user) { create :user }
      let!(:credit_card) { create :credit_card, user: current_user }
      before { sign_in current_user }

      it "destroys the credit card" do
        expect do
          delete :destroy, params: { id: credit_card.id }
        end.to change(CreditCard, :count).by(-1)
      end

      it "redirects to the credit cards index" do
        delete :destroy, params: { id: credit_card.id }
        expect(response).to redirect_to credit_cards_path
      end
    end

    context "when user is not logged in" do
      let!(:credit_card) { create :credit_card }

      it "returns http redirect" do
        delete :destroy, params: { id: credit_card.id }
        expect(response).to have_http_status(:redirect)
      end
    end
  end
end
