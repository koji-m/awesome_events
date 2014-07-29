# -*- coding: utf-8 -*-
require 'rails_helper'

#RSpec.describe Event, :type => :model do
#  pending "add some examples to (or delete) #{__FILE__}"
#end

describe Event do
  describe '#name' do
    it { should validate_presence_of(:name) }
    it { should ensure_length_of(:name).is_at_most(50) }
  end

  describe '#created_by?' do
    let(:event) { create(:event) }
    subject { event.created_by?(user) }

    context '引数が nil なとき' do
      let(:user) { nil }
      it { should be_falsey }
    end

    context '#owner_idと引数の#idが同じとき' do
      let(:user) { double('user', id: event.id) }
      it { should be_truthy }
    end
  end

  describe '#rails?' do
    context '#name が "Rails勉強会" のとき' do
      it 'true を返すこと' do
        event = create(:event, name: 'Rails勉強会')
        expect(event.rails?).to eq true
      end
    end
 
    context '#name が "Ruby勉強会" のとき' do
      it 'false を返すこと' do
        event = create(:event, name: 'Ruby勉強会')
        expect(event.rails?).to eq false
      end
    end
  end
end
