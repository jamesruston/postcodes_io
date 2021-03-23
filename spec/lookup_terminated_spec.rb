require 'spec_helper'

describe Postcodes::IO do
  let(:base_url) { 'https://api.postcodes.io' }
  let(:stub_response) { File.read('spec/fixtures/lookup_terminated_response.json') }

  describe '#lookup_terminated' do
    before :each do
      stub_request(:get, "#{base_url}/terminated_postcodes/CM129TR")
        .to_return(status: 200, body: stub_response)
    end

    let(:input) { 'CM12 9TR' }
    let(:output) { subject.lookup_terminated(input) }

    it 'requests a terminated postcode' do
      output
      WebMock.should have_requested(:get, "#{base_url}/terminated_postcodes/CM129TR")
    end

    it 'returns the long and lat' do
      output.longitude.should == -1.316261
      output.latitude.should == 51.062297
    end
  end
end
