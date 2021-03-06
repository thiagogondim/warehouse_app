require 'rails_helper'

RSpec.describe Warehouse, type: :model do
  describe '#valid?' do
    context 'presença' do
      it 'falso quando _name_ for vazio' do
        # Arrange
        warehouse = Warehouse.new(
          name: '', code: 'RIO', address: 'Endereço', city: 'Rio',
          postal_code: '25000-000', area: 1000, description: 'Alguma descrição'
        )

        # Act and Assert
        expect(warehouse).not_to be_valid
      end

      it 'falso quando _code_ for vazio' do
        # Arrange
        warehouse = Warehouse.new(
          name: 'Rio', code: '', address: 'Endereço', city: 'Rio',
          postal_code: '25000-000', area: 1000, description: 'Alguma descrição'
        )

        # Act and Assert
        expect(warehouse).not_to be_valid
      end

      it 'falso quando _code_ for maior que 3 caracteres' do
        # Arrange
        warehouse = Warehouse.new(
          name: 'Rio', code: 'ASWE', address: 'Endereço', city: 'Rio',
          postal_code: '25000-000', area: 1000, description: 'Alguma descrição'
        )

        # Act and Assert
        expect(warehouse).not_to be_valid
      end

      it 'falso quando _code_ for menor que 3 caracteres' do
        # Arrange
        warehouse = Warehouse.new(
          name: 'Rio', code: 'AE', address: 'Endereço', city: 'Rio',
          postal_code: '25000-000', area: 1000, description: 'Alguma descrição'
        )

        # Act and Assert
        expect(warehouse).not_to be_valid
      end

      it 'falso quando _address_ for vazio' do
        # Arrange
        warehouse = Warehouse.new(
          name: 'Rio', code: 'RIO', address: '', city: 'Rio',
          postal_code: '25000-000', area: 1000, description: 'Alguma descrição'
        )

        # Act and Assert
        expect(warehouse).not_to be_valid
      end

      it 'falso quando _city_ for vazio' do
        # Arrange
        warehouse = Warehouse.new(
          name: 'Rio', code: 'RIO', address: 'Endereço', city: '',
          postal_code: '25000-000', area: 1000, description: 'Alguma descrição'
        )

        # Act and Assert
        expect(warehouse).not_to be_valid
      end

      it 'falso quando _postal_code_ for vazio' do
        # Arrange
        warehouse = Warehouse.new(
          name: 'Rio', code: 'RIO', address: 'Endereço', city: 'Rio',
          postal_code: '', area: 1000, description: 'Alguma descrição'
        )

        # Act and Assert
        expect(warehouse).not_to be_valid
      end

      it 'falso quando _area_ for vazio' do
        # Arrange
        warehouse = Warehouse.new(
          name: 'Rio', code: 'RIO', address: 'Endereço', city: 'Rio',
          postal_code: '25000-000', area: nil, description: 'Alguma descrição'
        )

        # Act and Assert
        expect(warehouse).not_to be_valid
      end

      it 'falso quando _description_ for vazio' do
        # Arrange
        warehouse = Warehouse.new(
          name: 'Rio', code: 'RIO', address: 'Endereço', city: 'Rio',
          postal_code: '25000-000', area: 1000, description: ''
        )

        # Act and Assert
        expect(warehouse).not_to be_valid
      end
    end

    it 'falso quando _code_ já está em uso' do
      # Arrange
      warehouse1 = Warehouse.create(
        name: 'Rio', code: 'RIO', address: 'Endereço', city: 'Rio',
        postal_code: '25000-000', area: 1000, description: 'Alguma descrição'
      )

      warehouse2 = Warehouse.new(
        name: 'Salvador', code: 'RIO', address: 'Av. Getúlio Vargas', city: 'Salvador',
        postal_code: '40000-000', area: 1_000_000, description: 'Bora Baêa!'
      )

      # Act and Assert
      expect(warehouse2).not_to be_valid
    end

    it 'verdadeiro quando o formato do _postal_code_ é 00000-000' do
      # Arrange
      warehouse = Warehouse.new(
        name: 'Salvador', code: 'RIO', address: 'Av. Getúlio Vargas', city: 'Salvador',
        postal_code: '40000-000', area: 1_000_000, description: 'Bora Baêa!'
      )

      # Act and Assert
      expect(warehouse).to be_valid
    end

    it 'falso quando o formato do _postal_code_ não é 00000-000' do
      # Arrange
      warehouse = Warehouse.new(
        name: 'Salvador', code: 'RIO', address: 'Av. Getúlio Vargas', city: 'Salvador',
        postal_code: '00000-0000', area: 1_000_000, description: 'Bora Baêa!'
      )

      # Act and Assert
      expect(warehouse).not_to be_valid
    end
  end

  describe '#full_description' do
    it 'exibe o nome e o código' do
      # Arrange
      w = Warehouse.new(name: 'Galpão Cuiabá', code: 'CBA')

      # Act
      result = w.full_description

      # Assert
      expect(result).to eq('CBA - Galpão Cuiabá')
    end
  end
end
