require 'date'

def days_in_month(year, month)
  Date.new(year, month, -1).day
end

def cost_equations time_period, cost
    {
        daily: cost,
        weekly: cost / 7,
        monthly: cost / days_in_month(Date.today.year, Date.today.month)

    }[time_period&.to_sym] || (raise 'Wrong time period')
end

def calculate_cost time_period_costs
    cost = 0
    time_period_costs.each do |record| 
        raise "Cost cant be negative" if record[:cost] < 0
        cost += cost_equations record[:time_period], record[:cost]
    end
    cost.round(2)
end

def daily_cost time_period_costs, start_date, end_date
    begin
        raise "End date must be greater or equal to start date" if start_date > end_date

        cost = calculate_cost time_period_costs
        (0..end_date - start_date).map {|x| {date: (start_date + x).strftime('%d/%m/%Y'), cost: cost}}
    rescue => e
        e.to_s
    end
end
