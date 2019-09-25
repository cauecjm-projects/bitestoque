require 'rails_helper'

RSpec.describe AvailableProductsController, type: :controller do

  describe 'GET #index' do
    context 'quando não há produtos a serem exibidos' do
      before { get :index }

      it 'retorna status 200' do
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe 'GET #list' do
    context 'quando não há produtos a serem exibidos' do
      before { get :list }

      it 'retorna status 200' do
        expect(response).to have_http_status(:ok)
      end


      it 'retorna @available_products vazio' do
        expect(assigns(:available_products)).to be_empty
      end

      it '@available_products igual ao bd' do
        assert_equal AvailableProduct.all, assigns(:available_products)
      end
    end

    context 'quando há produtos a serem exibidos' do
      before do
        create(:available_product)

        get :list
      end

      it 'retorna status 200' do
        expect(response).to have_http_status(:ok)
      end

      it 'retorna @available_products' do
        expect(assigns(:available_products)).not_to be_empty
      end

      it '@available_products igual ao bd' do
        assert_equal AvailableProduct.all, assigns(:available_products)
      end
    end
  end

  describe 'POST #create' do
    context 'com params inválidos' do
      before do
         post :create, params: {
          product_name: '', product_descr: '',
          color_id:     '', size_id:       '',
          qtd:          ''
        }
      end

      it 'retorna status 400' do
        expect(response).to have_http_status(:bad_request)
      end

      context 'nenhum dado gravado' do
        it { expect(AvailableProduct.all.size).to eql(0) }
        it { expect(Product.all.size).to          eql(0) }
        it { expect(Color.all.size).to            eql(0) }
        it { expect(Size.all.size).to             eql(0) }
      end
    end

    context 'com params válidos' do
      before do
        color   = create(:color)
        size    = create(:size)

        product   = build(:product)
        @ava_prod = build(:available_product, product: product, color: color, size: size)

        post :create, params: {
          product_name: @ava_prod.product.name, product_descr: @ava_prod.product.description,
          color_id:     @ava_prod.color.id,     size_id:       @ava_prod.size.id,
          qtd:          @ava_prod.qtd
        }
      end

      it 'retorna status 200' do
        expect(response).to have_http_status(:ok)
      end

      context 'dados gravados corretamente' do
        it { expect(AvailableProduct.last).to have_attributes(qtd: @ava_prod.qtd) }
        it { expect(Product.last).to          have_attributes(name: @ava_prod.product.name, description: @ava_prod.product.description) }
        it { expect(Color.last).to            eql(@ava_prod.color) }
        it { expect(Size.last).to             eql(@ava_prod.size) }
      end
    end
  end

  describe 'PUT #update' do
    context 'com params inválidos' do
      before do
        @ava_prod = create(:available_product)

        put :update, params: {
          product_name: '', product_descr:        '',
          color_id:     '', size_id:              '',
          qtd:          '', available_product_id: @ava_prod.id
        }
      end

      it 'retorna status 400' do
        expect(response).to have_http_status(:bad_request)
      end

      context 'dados não foram alterados' do
        it { expect(AvailableProduct.last).to eql(@ava_prod) }
        it { expect(Product.last).to          eql(@ava_prod.product) }
        it { expect(Color.last).to            eql(@ava_prod.color) }
        it { expect(Size.last).to             eql(@ava_prod.size) }
      end
    end

    context 'com params válidos' do
      before do
        @ava_prod = create(:available_product)

        color         = create(:color)
        size          = create(:size)
        product       = build(:product)
        @ava_prod_new = build(:available_product, product: product, color: color, size: size)

        put :update, params: {
          product_name: @ava_prod_new.product.name, product_descr:        @ava_prod_new.product.description,
          color_id:     @ava_prod_new.color.id,     size_id:              @ava_prod_new.size.id,
          qtd:          @ava_prod_new.qtd,          available_product_id: @ava_prod.id
        }
      end

      it 'retorna status 200' do
        expect(response).to have_http_status(:ok)
      end

      context 'dados foram alterados' do
        it { expect(AvailableProduct.last).to have_attributes(qtd: @ava_prod_new.qtd) }
        it { expect(Product.last).to          have_attributes(name: @ava_prod_new.product.name, description: @ava_prod_new.product.description) }
        it { expect(Color.last).to            eql(@ava_prod_new.color) }
        it { expect(Size.last).to             eql(@ava_prod_new.size) }
      end
    end
  end

end
