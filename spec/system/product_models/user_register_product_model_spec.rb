require 'rails_helper'

describe 'Usuário cadastra um novo Modelo de Produto' do
  it 'com sucesso' do
    # Arrange
    Supplier.create!(
      brand_name: 'LG', corporate_name: 'LG Eletronics International', nif: '1234567890129',
      full_address: 'Av Internacional de Greenwich', city: 'Greenwich', state: 'RU',
      email: 'vemnimim@lg.com', contact_number: '123456789'
    )

    # Act
    visit root_path
    click_on 'Modelos de Produto'
    click_on 'Cadastrar Modelo de Produto'
    fill_in 'Nome', with: 'Boombox SoundBox'
    fill_in 'Peso', with: 500
    fill_in 'Largura', with: 5
    fill_in 'Altura', with: 15
    fill_in 'Profundidade', with: 5
    fill_in 'SKU', with: 'LGBOOM-45670-1234567'
    select 'LG', from: 'product_model_supplier_id'
    click_on 'Enviar'

    # Assert
    expect(current_path).to eq product_models_path
    expect(page).to have_content('Modelo de Produto cadastrado com sucesso.')
    expect(page).to have_content('Boombox SoundBox')
  end
end