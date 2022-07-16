require_relative 'index.rb'

RSpec.describe "Daily Costs" do
    let(:start_date) {Date.new(2022, 5, 1)}
    let(:wrong_start_date) {Date.new(2022, 5, 4)}
    let(:end_date) {Date.new(2022, 5, 3)}
    let(:all_time_periods) { %w(daily weekly monthly)}

    let(:single_time_period) {[
        {
            time_period: all_time_periods[0], # daily
            cost: 10.0
        }
    ]}

    let(:multiple_time_periods) {[
        {
            time_period: all_time_periods[0], # daily
            cost: 10.0
        },
        {
            time_period: all_time_periods[1], # weekly
            cost: 70.0
        },
        {
            time_period: all_time_periods[2], # monthly
            cost: 150.0
        }
    ]}

    let(:wrong_cost_value) {[
        {
            time_period: all_time_periods[0],
            cost: -10.0
        }
    ]}

    let(:wrong_time_period) {[
        {
            time_period: all_time_periods[4],
            cost: 10.0
        }
    ]}

    it "single time period" do
        result = daily_cost single_time_period, start_date, end_date
  
        expect(result.size).to eq(3)
    end

    it "multiple time period" do
        result = daily_cost multiple_time_periods, start_date, end_date
  
        expect(result.size).to eq(3)
    end

    it "wrong date" do
        result = daily_cost single_time_period, wrong_start_date, end_date
  
        expect(result).to eq("End date must be greater or equal to start date")
    end

    it "wrong cost value" do
        result = daily_cost wrong_cost_value, start_date, end_date
  
        expect(result).to eq("Cost cant be negative")
    end

    it "wrong time period" do
        result = daily_cost wrong_time_period, start_date, end_date
  
        expect(result).to eq('Wrong time period')
    end
end

