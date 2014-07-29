# -*- coding: utf-8 -*-
require 'rails_helper'

describe "events/show" do
  context '未ログインユーザがアクセスしたとき' do
    before do
      allow(view).to receive(:logged_in?) { false }
      allow(view).to receive(:current_user) { nil }
    end

    context 'かつ @event.owner が nil のとき' do
      before do
        assign(:event, FactoryGirl.create(:event, owner: nil))
        assign(:tickets, [])
      end

      it '"退会したユーザです"と表示されること' do
        render
        expect(rendered).to match /退会したユーザです/
      end
    end
  end
end
