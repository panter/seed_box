require 'spec_helper'

RSpec.describe SeedBox do
  # create a class which includes the module under test so we can easily test
  # the methods
  subject { Class.new { include SeedBox }.new }

  it 'has a version number' do
    expect(SeedBox::VERSION).not_to be nil
  end

  describe '.seed' do
    context 'with 1 parameter find_or_create_by given' do
      it 'creates a record' do
        subject.seed(SeededUser, { first_name: 'Gob' })

        expect(SeededUser.count).to eq 1
        expect(SeededUser.last).to have_attributes first_name: 'Gob'
      end

      it 'returns the created record' do
        expect(
          subject.seed(SeededUser, { first_name: 'Gob' })
        ).to eq SeededUser.first
      end

      it 'does not create a second record when executed twice' do
        subject.seed(SeededUser, { first_name: 'Gob' })
        subject.seed(SeededUser, { first_name: 'Gob' })

        expect(SeededUser.count).to eq 1
      end

      it 'raises an error if a validation error occurs' do
        expect {
          subject.seed(SeededUser, { last_name: 'Bluth' })
        }.to raise_error(
          RuntimeError,
          "Couldn't save SeededUser (First name can't be blank) with provided " \
          "data: {:last_name=>\"Bluth\"}, {}"
        )
      end
    end

    context 'with 2 parameter find_or_create_by and update_with given' do
      it 'creates a record' do
        subject.seed(SeededUser, { first_name: 'Gob' }, { last_name: 'Bluth' })

        expect(SeededUser.count).to eq 1
        expect(SeededUser.last).to have_attributes first_name: 'Gob', last_name: 'Bluth'
      end

      it 'returns the created record' do
        expect(
          subject.seed(SeededUser, { first_name: 'Gob' })
        ).to eq SeededUser.first
      end

      it 'does not create a second record when executed twice' do
        subject.seed(SeededUser, { first_name: 'Gob' }, { last_name: 'Bluth' })
        subject.seed(SeededUser, { first_name: 'Gob' }, { last_name: 'Bluth' })

        expect(SeededUser.count).to eq 1
      end

      it 'updates the attributes identified by the first argument' do
        subject.seed(SeededUser, { first_name: 'Gob' }, { last_name: 'Bloth' })
        subject.seed(SeededUser, { first_name: 'Gob' }, { last_name: 'Bluth' })

        expect(SeededUser.count).to eq 1
        expect(SeededUser.last).to have_attributes first_name: 'Gob', last_name: 'Bluth'
      end

      it 'creates a new record when the first argument differs' do
        subject.seed(SeededUser, { first_name: 'Go' }, { last_name: 'Bluth' })
        subject.seed(SeededUser, { first_name: 'Gob' }, { last_name: 'Bluth' })

        expect(SeededUser.count).to eq 2
        expect(SeededUser.first).to have_attributes first_name: 'Go', last_name: 'Bluth'
        expect(SeededUser.last).to have_attributes first_name: 'Gob', last_name: 'Bluth'
      end
    end
  end

  describe '.seed_once' do
    context 'with 1 parameter find_or_create_by given' do
      it 'creates a record' do
        subject.seed_once(SeededUser, { first_name: 'Gob' })

        expect(SeededUser.count).to eq 1
        expect(SeededUser.last).to have_attributes first_name: 'Gob'
      end

      it 'does not create a second record when executed twice' do
        subject.seed_once(SeededUser, { first_name: 'Gob' })
        subject.seed_once(SeededUser, { first_name: 'Gob' })

        expect(SeededUser.count).to eq 1
      end
    end

    context 'with 2 parameter find_or_create_by and update_with given' do
      it 'creates a record' do
        subject.seed_once(SeededUser, { first_name: 'Gob' }, { last_name: 'Bluth' })

        expect(SeededUser.count).to eq 1
        expect(SeededUser.last).to have_attributes first_name: 'Gob', last_name: 'Bluth'
      end

      it 'does not create a second record when executed twice' do
        subject.seed_once(SeededUser, { first_name: 'Gob' }, { last_name: 'Bluth' })
        subject.seed_once(SeededUser, { first_name: 'Gob' }, { last_name: 'Bluth' })

        expect(SeededUser.count).to eq 1
      end

      it 'does not update the attributes identified by the first argument' do
        subject.seed_once(SeededUser, { first_name: 'Gob' }, { last_name: 'Bloth' })
        subject.seed_once(SeededUser, { first_name: 'Gob' }, { last_name: 'Bluth' })

        expect(SeededUser.count).to eq 1
        expect(SeededUser.last).to have_attributes first_name: 'Gob', last_name: 'Bloth'
      end

      it 'creates a new record when the first argument differs' do
        subject.seed_once(SeededUser, { first_name: 'Go' }, { last_name: 'Bluth' })
        subject.seed_once(SeededUser, { first_name: 'Gob' }, { last_name: 'Bluth' })

        expect(SeededUser.count).to eq 2
        expect(SeededUser.first).to have_attributes first_name: 'Go', last_name: 'Bluth'
        expect(SeededUser.last).to have_attributes first_name: 'Gob', last_name: 'Bluth'
      end

      it 'raises an error if a validation error occurs' do
        expect {
          subject.seed_once(SeededUser, { last_name: 'Bluth' })
        }.to raise_error(
          RuntimeError,
          "Couldn't save SeededUser (First name can't be blank) with provided " \
          "data: {:last_name=>\"Bluth\"}, {}"
        )
      end
    end
  end

  describe '.seed_file' do
    it 'calls File.new with the file path' do
      allow(Rails).to receive(:root).and_return(
        Pathname.new('/path/to/rails/root')
      )

      expect(File).to receive(:new).with(
        Pathname.new('/path/to/rails/root/db/seeds/gob.jpg')
      )

      subject.seed_file('gob.jpg')
    end
  end
end
