require 'spec_helper'

describe Postcodes::IO do
  let(:base_url) {'https://api.postcodes.io'}
  let(:stub_valid_response) { File.read('spec/fixtures/validation_valid_response.json') }
  let(:stub_invalid_response) { File.read('spec/fixtures/validation_invalid_response.json') }

  describe '#validate' do
    before :each do
      stub_request(:get, "#{base_url}/postcodes/CM129TR/validate")
          .to_return(status: 200, body: stub_valid_response)

      stub_request(:get, "#{base_url}/postcodes/TR49BW/validate")
          .to_return(status: 200, body: stub_valid_response)

      stub_request(:get, "#{base_url}/postcodes/helloooooo/validate")
          .to_return(status: 200, body: stub_invalid_response)
    end

    def validate(postcode)
      subject.validate(postcode)
    end

    it 'removes whitespace from postcodes' do
      validate('CM12     9TR')
      WebMock.should have_requested(:get, "#{base_url}/postcodes/CM129TR/validate")
    end

    it 'validates a postcode' do
      validate('CM129TR')
      WebMock.should have_requested(:get, "#{base_url}/postcodes/CM129TR/validate")
    end

    it 'returns true for valid postcodes' do
      expect(validate('TR49BW')).to be_truthy
    end

    it 'returns false for valid postcodes' do
      expect(validate('helloooooo')).to be_falsy
    end
  end
end
