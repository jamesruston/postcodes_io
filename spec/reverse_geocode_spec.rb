require 'spec_helper'

RSpec.describe Postcodes::IO, '#reverse_geocode' do
  let(:latitiude) { '53.6099106263766' }
  let(:longitude) { '2.60515477763266' }
  let(:base_url) { 'https://api.postcodes.io' }
  let(:url) { "#{base_url}/postcodes?lon=#{longitude}&lat=#{latitiude}&limit=10&radius=100&wideSearch=false" }
  let(:no_results_response) do
    File.read('spec/fixtures/no_results_response.json')
  end
  let(:reverse_geocode_response) do
    File.read('spec/fixtures/reverse_geocode_response.json')
  end

  subject(:reverse_geocode) do
    described_class.new.reverse_geocode(
      longitude: longitude, latitude: latitiude)
  end

  context 'when a 400 is returned' do
    before do
      stub_request(:get, url).to_return(status: 400)
    end

    it { is_expected.to be_nil }
  end

  context 'when there are no results returned' do
    before do
      stub_request(:get, url).to_return(status: 200, body: no_results_response)
    end

    it { is_expected.to be_nil }
  end

  context 'when results are returned' do
    before do
      stub_request(:get, url)
        .to_return(status: 200, body: reverse_geocode_response)
    end

    it 'returns the correct number of postcodes' do
      expect(reverse_geocode.count).to eq(3)
    end

    it 'instantiates an object for each returned postcode' do
      reverse_geocode.each do |result|
        expect(result).to be_a(Postcodes::Postcode)
      end
    end
  end
end
