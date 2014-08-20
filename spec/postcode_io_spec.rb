require 'spec_helper'

describe Postcodes::IO do

  let(:base_url) {'https://api.postcodes.io'}
  let(:stub_response) { File.read('spec/fixtures/lookup_response.json') }

  before :each do
    stub_request(:get, "#{base_url}/postcodes/CM129TR")
    .to_return(status: 200, body: stub_response)
  end

  describe '#lookup' do
    let(:input) { 'CM12 9TR' }
    let(:output) { subject.lookup(input) }

    it 'requests a postcode' do
      output
      WebMock.should have_requested(:get, "#{base_url}/postcodes/CM129TR")
    end

    it 'returns the long and lat' do
      output.longitude.should == 0.411227930206834
    end

  end
end
