module FuelComsumptionCalculator
  def calculate_fuel_mass_land(mass:, gravity:)
    (mass * gravity * 0.033 - 42).floor
  end

  def calculate_fuel_mass_launch(mass:, gravity:)
    (mass * gravity * 0.042 - 33).floor
  end

  # Calculations of fuel consumption of flight phase also
  # could be done by creating recursive method, but I prefer
  # not to use recursive methods when it's possible.
  def calculate_phase_fuel_consumtion(mass:, flight_direction:, gravity:)
    calculation_method = :calculate_fuel_mass_land if flight_direction.eql?(:land)
    calculation_method = :calculate_fuel_mass_launch if flight_direction.eql?(:launch)

    fuel_masses = []
    while mass > 0
      mass = method(calculation_method).call(mass: mass, gravity: gravity)
      (fuel_masses << mass) if mass > 0
    end

    fuel_masses.sum
  end

  def calculate_mission_fuel_consumtion(mass:, flight_instructions:)
    # On the earlier stages of flight we need also to carry fuel
    # for later stages of flight. So we start calculating fuel weight from the end
    flight_instructions.reverse!
    dry_mass = mass
    equipped_mass = dry_mass

    flight_instructions.each do |flight_direction, gravity|
      equipped_mass += calculate_phase_fuel_consumtion(mass: equipped_mass, flight_direction: flight_direction, gravity: gravity)
    end

    equipped_mass - dry_mass
  end
end
