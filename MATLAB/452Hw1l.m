% Screening Curve for Power Plant Economics
% Variables: h (hours per year), y (Revenue Required in $/yr-kW)

% 1. Define the range for hours in a year
h = 0:1:8736; 

% 2. Define the Revenue Required equations
% We assume the first term is Fixed Cost ($/kW-yr) and 
% the second term is Variable Cost ($/kWh).
FCR = 0.1;
Coal = 2000*FCR + 0.02 * h;
NGCC = 1200*FCR + 0.04 * h;  % Assumed '+' instead of '*' to match plant logic
CT   = 800*FCR  + 0.06 * h;

% 3. Create the Plot
figure;
hold on;
plot(h, Coal, 'r', 'LineWidth', 2);
plot(h, NGCC, 'b', 'LineWidth', 2);
plot(h, CT,   'g', 'LineWidth', 2);

% 4. Formatting the Graph
grid on;
xlabel('Hours of Operation (h)');
ylabel('Revenue Required ($/yr-kW)');
title('Screening Curve for Power Plant Technologies');
legend('Coal (Base)', 'NGCC (Mid)', 'CT (Peak)', 'Location', 'best');
xlim([0 8736]);

% 5. Optional: Highlight the "Lower Envelope"
% This shows the least-cost choice at any given hour.
Total_Costs = [Coal; NGCC; CT];
[min_cost, idx] = min(Total_Costs);
plot(h, min_cost, 'k--', 'LineWidth', 1.5); % Dotted line for optimal path