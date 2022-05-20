require 'rails_helper'

describe 'Usuário cadatra um pedido' do
  it 'com sucesso' do
    # Arrange
    user = User.create!(name: 'Thiago', email: 'thiago@email.com', password: 'baralho')

    Warehouse.create!(
      name: 'Cuiabá', code: 'CWB', city: 'Cuiabá', area: 10_000, postal_code: '56000-000',
      address: 'Avenida dos Jacarés, 1000', description: 'Galpão no centro do país'
    )

    warehouse = Warehouse.create!(
      name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000, postal_code: '15000-000',
      address: 'Avenida do Aeroporto, 100', description: 'Galpão destinado a cargas internacionais'
    )

    Supplier.create!(
      corporate_name: 'Instituto Xavier para crianças superdotadas', brand_name: 'X-Men', nif: '03126458670890',
      full_address: 'Do lado de minha casa, 14', city: 'Ipiaú', state: 'BA',
      email: 'contato@xmen.com', contact_number: '+557331183804'
    )

    supplier = Supplier.create!(
      corporate_name: 'Fábrica de Chocolate LTDA', brand_name: 'Indústrias Wonka', nif: '09875653431200',
      full_address: 'Do lado de minha casa, 14', city: 'Salvador', state: 'BA',
      email: 'contato@wonka.com', contact_number: '+557133224455'
    )

    # Act
    login_as(user)
    visit root_path
    click_on 'Registrar Pedido'
    select warehouse.name, from: 'Galpão Destino'
    select supplier.corporate_name, from: 'Fornecedor'
    fill_in 'Data de Entrega Prevista', with: '20/12/2022'
    click_on 'Gravar'

    # Assert
    expect(page).to have_content 'Pedido registrado com sucesso'
    expect(page).to have_content 'Galpão Destino: Aeroporto SP'
    expect(page).to have_content 'Fornecedor: Fábrica de Chocolate LTDA'
    expect(page).to have_content 'Usuário Responsável: Thiago | thiago@email.com'
    expect(page).to have_content 'Data de Entrega Prevista: 20/12/2022'
    expect(page).not_to have_content 'Cuiabá'
    expect(page).not_to have_content 'CWB'
  end
end
