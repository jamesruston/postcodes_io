require 'spec_helper'

describe Postcodes::IO do

  let(:base_url) {'https://api.postcodes.io'}
  let(:stub_autocomplete) { File.read('spec/fixtures/autocomplete_response.json') }

  describe '#autocomplete' do

    before :each do
      stub_request(:get, "#{base_url}/postcodes/NN10/autocomplete")
          .to_return(status: 200, body: stub_autocomplete)
    end

    let(:input) { 'NN10' }
    let(:output) { subject.autocomplete(input) }

    it 'requests a postcode' do
      output
      WebMock.should have_requested(:get, "#{base_url}/postcodes/NN10/autocomplete")
    end

    it 'returns autocompleted array' do
      expect(output.list).to eq(["NN10 0AA",
                                 "NN10 0AD",
                                 "NN10 0AE",
                                 "NN10 0AF",
                                 "NN10 0AG",
                                 "NN10 0AH",
                                 "NN10 0AJ",
                                 "NN10 0AL",
                                 "NN10 0AN",
                                 "NN10 0AP"])
    end
  end
end
