require_relative '../../../lib/mdl/multi_date_formatter'

module MDL
  describe MultiDateFormatter do
    describe '.format' do
      subject { MultiDateFormatter.format(date) }

      context 'with date format "YYYY"' do
        let(:date) { '1926' }
        it { is_expected.to eq %w(1926) }
      end

      context 'with date format "YYYY?"' do
        let(:date) { '1926?' }
        it { is_expected.to eq %w(1926) }
      end

      context 'with date format "YYYY - YYYY"' do
        let(:date) { '1926 - 1930' }
        it { is_expected.to eq %w(1926 1927 1928 1929 1930) }
      end

      context 'with date format "YYYY - YYYY?"' do
        let(:date) { '1926 - 1930?' }
        it { is_expected.to eq %w(1926 1927 1928 1929 1930) }
      end

      context 'with date format "YYYY-mm-dd"' do
        let(:date) { '2000-11-21' }
        it { is_expected.to eq %w(2000) }
      end

      context 'with date format "YYYY-mm"' do
        let(:date) { '2007-05' }
        it { is_expected.to eq %w(2007) }
      end

      context 'with date format "YYYY-mm?"' do
        let(:date) { '2007-05?' }
        it { is_expected.to eq %w(2007) }
      end

      context 'with date format "YYYY-mm-dd - YYYY-mm-dd"' do
        let(:date) { '1877-01-19 - 1881-02-02' }
        it { is_expected.to eq %w(1877 1878 1879 1880 1881 ) }
      end

      context 'with date format "mm/dd/YYYY"' do
        let(:date) { '02/14/1976' }
        it { is_expected.to eq %w(1976) }
      end

      context 'with date format "mm/dd/YYYY - mm/dd/YYYY"' do
        let(:date) { '12/31/1988 - 01/01/1989' }
        it { is_expected.to eq %w(1988 1989) }
      end

      context 'with a bad date format' do
        let(:date) { '123' }
        it { is_expected.to eq [] }
      end

      context 'with nil' do
        let(:date) { nil }
        it { is_expected.to eq [] }
      end
    end
  end
end
