using PyCall
PyDict(pyimport("matplotlib")["rcParams"])["font.sans-serif"] = ["Helvetica"]

# Script to simulate uncompetive inhibition -
using PyPlot

# Setup base parameters -
KI = 0.1;
VM = 1.5;
KM = 1.0;

# Setup I levels -
number_of_inhibitor_steps = 10;
number_of_substrate_steps = 100;
inhibitor_vector = logspace(-2.0,1,number_of_inhibitor_steps);
substrate_vector = logspace(-2.0,1,number_of_substrate_steps);

# Main loop -
for inhibitor_level in inhibitor_vector

  rate_array = zeros(number_of_substrate_steps);
  rate_counter = 1;
  for substrate_level in substrate_vector

    # Calculate the rate -
    inhibition_term = (1+inhibitor_level/KI);
    Vmax_app = VM/inhibition_term;
    KM_app = KM/inhibition_term;

    rate_array[rate_counter] = Vmax_app*(substrate_level)/(KM_app + substrate_level);

    # update the counter -
    rate_counter = rate_counter + 1;
  end

  #plot?
  plot(substrate_vector,rate_array,"k");
end

# labels -
xlabel("Substrate [mmol/L]",fontsize="14")
ylabel("Reaction rate [mmol/L-hr]",fontsize="14")
savefig("Uncompetive_low_KI.pdf");
