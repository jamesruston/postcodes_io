require 'spec_helper'

describe Postcodes::IO do

  let(:base_url) {'https://api.postcodes.io'}
  let(:stub_single_response) { File.read('spec/fixtures/lookup_response.json') }
  let(:stub_multi_response) { File.read('spec/fixtures/lookup_multi_response.json') }

  describe '#lookup' do

    before :each do
      stub_request(:get, "#{base_url}/postcodes/CM129TR")
        .to_return(status: 200, body: stub_single_response)
    end

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

  describe '#lookup with multiple postcodes' do

    before :each do
      stub_request(:post, "#{base_url}/postcodes")
        .with(body: postcode_payload, headers: {'Content-Type' => 'application/json'})
        .to_return(status: 200, body: stub_multi_response)
    end

    let(:input) { ['OX495NU', 'M320JG', 'NE301DP'] }
    let(:output) { subject.lookup(input) }
    let(:postcode_payload) { {postcodes: input}.to_json }
    
    it 'makes a request with mutliple postcodes' do
      output
      WebMock.should have_requested(:post, "#{base_url}/postcodes")
    end

    it 'returns a postcode object for each result' do
      output.count.should == 3
      output.each do |o|
        o.class.should == Postcodes::Postcode
      end
    end

  end
end
