# frozen_string_literal: true

RSpec.describe ActiveRecord::Base, 'formatting', type: :formatter do
  around do |example|
    columns = self.columns
    Temping.create('temp') do
      with_columns do |t|
        columns.each do |name, type, opts = {}|
          t.send(type, name, opts)
        end
      end
    end

    example.call
  ensure
    Temping.teardown
  end

  let(:columns) { {} }

  formatting_an_instance do
    object { Temp.new }

    it {
      byebug
      expect(subject.to_s).to eq '' }
  end
end
