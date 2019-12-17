RSpec.describe Calculator do
  let (:amount) { 100 }
  let (:commission_amount) { 1.0 }
  let (:commission_percent) { 20 }
  let (:basic_user) { User::BasicUser.new }
  let (:basic_product) { Product::BasicProduct.new }
  let (:commission_entity) { Calculator::Commission.new(user: basic_user,
                                                        product: basic_product)}

  it 'has a version number' do
    expect(Calculator::VERSION).not_to be nil
  end

  describe 'User' do
    context 'IndividualEntrepreneurUser' do
      let (:individual_entrepreneur_user) { User::IndividualEntrepreneurUser.new }
      let (:commission_entity) { Calculator::Commission.new(user: individual_entrepreneur_user,
                                                            product: basic_product)}

      it 'calculates with with additional commision' do
        output = Calculator.call(amount: amount,
                                 commission_amount: commission_amount,
                                 commission_percent: commission_percent,
                                 commission_entity: commission_entity)
        expect(output).to eq([79.67, 20.33])
      end
    end

    context 'LegalEntityUser' do
      let (:legal_entity_user) { User::LegalEntityUser.new }
      let (:commission_entity) { Calculator::Commission.new(user: legal_entity_user,
                                                            product: basic_product)}

      it 'calculates with with additional commision' do
        output = Calculator.call(amount: amount,
                                 commission_amount: commission_amount,
                                 commission_percent: commission_percent,
                                 commission_entity: commission_entity)
        expect(output).to eq([79.56, 20.44])
      end
    end
  end

  describe 'Product' do
    context 'HardwareProduct' do
      let (:hardware_product) { Product::HardwareProduct.new }
      let (:commission_entity) { Calculator::Commission.new(user: basic_user,
                                                            product: hardware_product)}

      it 'calculates with with additional commision' do
        output = Calculator.call(amount: amount,
                                 commission_amount: commission_amount,
                                 commission_percent: commission_percent,
                                 commission_entity: commission_entity)
        expect(output).to eq([79.45, 20.55])
      end
    end

    context 'SoftwareProduct' do
      let (:software_product) { Product::SoftwareProduct.new }
      let (:commission_entity) { Calculator::Commission.new(user: basic_user,
                                                            product: software_product)}

      it 'calculates with with additional commision' do
        output = Calculator.call(amount: amount,
                                 commission_amount: commission_amount,
                                 commission_percent: commission_percent,
                                 commission_entity: commission_entity)
        expect(output).to eq([79.35, 20.65])
      end
    end
  end


  describe 'increase commission amount by 0.01%' do
    [[150, [119.95, 30.05]], [140, [111.96, 28.04]],
     [243, [194.26, 48.74]]].each do |amount, result|
      it "when price >= #{amount}" do

        output = Calculator.call(amount: amount,
                                 commission_amount: commission_amount,
                                 commission_percent: commission_percent,
                                 commission_entity: commission_entity)
        expect(output).to eq(result)
      end
    end

    it 'for non basic product and user when price is higer than 100' do
      software_product =  Product::SoftwareProduct.new
      legal_entity_user = User::LegalEntityUser.new
      commission_entity = Calculator::Commission.new(user: legal_entity_user,
                                                     product: software_product)
      output = Calculator.call(amount: 150,
                               commission_entity: commission_entity)
      expect(output).to eq([103.86, 46.14])
    end
  end

  it 'calculates with all inputs' do
    output = Calculator.call(amount: amount,
                             commission_amount: commission_amount,
                             commission_percent: commission_percent,
                             commission_entity: commission_entity)
    expect(output).to eq([80.0, 20.0])
  end

  it 'calculates without commission_amount input' do
    output = Calculator.call(amount: amount,
                             commission_percent: commission_percent,
                             commission_entity: commission_entity)
    expect(output).to eq([80.0, 20.0])
  end

  it 'calculates without commission_entity and commission_amount input' do
    output = Calculator.call(amount: amount,
                             commission_percent: commission_percent)
    expect(output).to eq([79.0, 21.0])
  end

  it 'calculates without commission_percent, commission_entity and commission_amount input' do
    output = Calculator.call(amount: amount)
    expect(output).to eq([69.0, 31.0])
  end

  it 'throw an error when commission is higer than total Amount' do
    expect{Calculator.call(amount: 20, commission_percent:100)}.
    to raise_error(CalculatorError, 'Commission is higer than total Amount')
  end
end
