require_relative "fuel_consumption_calculator"
include FuelComsumptionCalculator

missions_params = {
  apollo_11_mission: [
    28_801,
    [
      [:launch, 9.807],
      [:land, 1.62],
      [:launch, 1.62],
      [:land, 9.807],
    ],
  ],
  mars_mission: [
    14_606,
    [
      [:launch, 9.807],
      [:land, 3.711],
      [:launch, 3.711],
      [:land, 9.807],
    ],
  ],
  passenger_mission: [
    75_432,
    [
      [:launch, 9.807],
      [:land, 1.62],
      [:launch, 1.62],
      [:land, 3.711],
      [:launch, 3.711],
      [:land, 9.807],
    ],
  ],
}

missions_params.each do |name, params|
  dry_mass = params[0]
  flight_instructions = params[1]

  fuel_mass = calculate_mission_fuel_consumtion(mass: dry_mass, flight_instructions: flight_instructions)

  puts "Fuel comsumption for #{name} is #{fuel_mass} kg"
end
