require_relative '../../../lib/mdl/rights_config.rb'
module MDL
  describe RightsConfig do
    describe 'when given a valid url' do
      it 'returns a rights statement configuration' do
        url = 'http://rightsstatements.org/vocab/NoC-US/1.0/'
        rights_config =  RightsConfig.new(url: url)
        mapping = rights_config.mapping
        expect(mapping[:url]).to eq(url)
        expect(mapping[:image_url]).to eq 'http://rightsstatements.org/files/buttons/NoC-US.dark-white-interior.png'
        expect(mapping[:name]).to eq 'NO COPYRIGHT - UNITED STATES'
      end
    end

    describe 'when given an invalid url' do
      it 'knows that no mapping exists' do
        url = 'http://billy-bobs-house-of-rights.com/foo/1'
        rights_config =  RightsConfig.new(url: url)
        expect(rights_config.exists?).to be false
      end
    end
  end
end
