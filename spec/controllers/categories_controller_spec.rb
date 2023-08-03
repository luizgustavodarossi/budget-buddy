require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  describe "GET #index" do
    context "when user is logged in" do
      let(:current_user) { create :user }
      let!(:categories) { create_list :category, 3, user: current_user }
      before { sign_in current_user }

      it "returns http success" do
        get :index
        expect(response).to have_http_status :success
      end

      it "returns only the current user's categories" do
        another_user = create :user
        another_category = create :category, user: another_user

        get :index
        expect(assigns(:categories)).to match_array categories
        expect(assigns(:categories)).not_to include another_category
      end

      it "renders the index template" do
        get :index
        expect(response).to render_template :index
      end
    end

    context "when user is not logged in" do
      let!(:categories) { create_list :category, 3 }

      it "returns http redirect" do
        get :index
        expect(response).to have_http_status(:redirect)
      end
    end
  end

  describe "GET #show" do
    context "when user is logged in" do
      let(:current_user) { create :user }
      let(:category) { create :category, user: current_user }
      before { sign_in current_user }

      it "returns http success" do
        get :show, params: { id: category.id }
        expect(response).to have_http_status :success
      end

      it "returns only the current user's category" do
        another_user = create :user
        another_category = create :category, user: another_user

        get :show, params: { id: category.id }
        expect(assigns(:category)).to eq category

        expect do
          get :show, params: { id: another_category.id }
        end.to raise_error(ActiveRecord::RecordNotFound)
      end

      it "renders the show template" do
        get :show, params: { id: category.id }
        expect(response).to render_template :show
      end
    end

    context "when user is not logged in" do
      let(:category) { create :category }

      it "returns http redirect" do
        get :show, params: { id: category.id }
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

      it "returns a new category created by the current user" do
        get :new
        expect(assigns(:category)).to be_a_new(Category)
        expect(assigns(:category).user).to eq current_user
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
      let(:category) { create :category, user: current_user }
      before { sign_in current_user }

      it "returns http success" do
        get :edit, params: { id: category.id }
        expect(response).to have_http_status :success
      end

      it "returns only the current user's category" do
        another_user = create :user
        another_category = create :category, user: another_user

        get :edit, params: { id: category.id }
        expect(assigns(:category)).to eq category

        expect do
          get :edit, params: { id: another_category.id }
        end.to raise_error(ActiveRecord::RecordNotFound)
      end

      it "renders the edit template" do
        get :edit, params: { id: category.id }
        expect(response).to render_template :edit
      end
    end

    context "when user is not logged in" do
      let(:category) { create :category }

      it "returns http redirect" do
        get :edit, params: { id: category.id }
        expect(response).to have_http_status(:redirect)
      end
    end
  end

  describe "POST #create" do
    context "when user is logged in" do
      let(:current_user) { create :user }
      before { sign_in current_user }

      context "with valid params" do
        let(:valid_params) { attributes_for :category }

        it "creates a new category for the current user" do
          expect do
            post :create, params: { category: valid_params }
          end.to change(current_user.categories, :count).by 1
        end

        it "redirects to the created category" do
          post :create, params: { category: valid_params }
          expect(response).to redirect_to category_path(Category.last)
        end
      end

      context "with invalid params" do
        let(:invalid_params) { attributes_for :category, name: nil }

        it "does not create a new category" do
          expect do
            post :create, params: { category: invalid_params }
          end.to change(Category, :count).by(0)
        end

        it "renders the new template" do
          post :create, params: { category: invalid_params }
          expect(response).to render_template :new
        end
      end
    end

    context "when user is not logged in" do
      let(:valid_params) { attributes_for :category }

      it "returns http redirect" do
        post :create, params: { category: valid_params }
        expect(response).to have_http_status(:redirect)
      end
    end
  end

  describe "PATCH #update" do
    context "when user is logged in" do
      let(:current_user) { create :user }
      let(:category) { create :category, user: current_user }
      before { sign_in current_user }

      context "with valid params" do
        let(:valid_params) { attributes_for :category, name: "Update Name" }

        it "updates the category" do
          patch :update, params: { id: category.id, category: valid_params }
          category.reload
          expect(category.name).to eq "Update Name"
        end

        it "redirects to the updated category" do
          patch :update, params: { id: category.id, category: valid_params }
          expect(response).to redirect_to category_path(category)
        end
      end

      context "with invalid params" do
        let(:invalid_params) { attributes_for :category, name: nil }

        it "does not update the category" do
          patch :update, params: { id: category.id, category: invalid_params }
          category.reload
          expect(category.name).not_to be_nil
        end

        it "renders the edit template" do
          patch :update, params: { id: category.id, category: invalid_params }
          expect(response).to render_template :edit
        end
      end
    end

    context "when user is not logged in" do
      let(:category) { create :category }
      let(:valid_params) { attributes_for :category, name: "Update Name" }

      it "returns http redirect" do
        patch :update, params: { id: 1, category: valid_params }
        expect(response).to have_http_status(:redirect)
      end
    end
  end

  describe "DELETE #destroy" do
    context "when user is logged in" do
      let(:current_user) { create :user }
      let!(:category) { create :category, user: current_user }
      before { sign_in current_user }

      it "destroys the category" do
        expect do
          delete :destroy, params: { id: category.id }
        end.to change(Category, :count).by(-1)
      end

      it "redirects to the categories index" do
        delete :destroy, params: { id: category.id }
        expect(response).to redirect_to categories_path
      end
    end

    context "when user is not logged in" do
      let!(:category) { create :category }

      it "returns http redirect" do
        delete :destroy, params: { id: category.id }
        expect(response).to have_http_status(:redirect)
      end
    end
  end
end
