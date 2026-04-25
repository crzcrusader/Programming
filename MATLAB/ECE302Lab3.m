%% BJT Parameter Extraction from DCA Pro Ic-Vce Data
clear; clc;

%% -------- Import data file --------
filename = 'NPNBJT_Ic_Vce.txt';
data = readmatrix(filename);

% Remove first column (point index)
data = data(:,2:end);

%% -------- Base current values (A) --------
Ib = [35 28 21 14 7]*1e-6;   % base currents from header
num_traces = length(Ib);

%% -------- Initialize storage --------
BF0_vals = zeros(num_traces,1);
VA_vals  = zeros(num_traces,1);

figure; hold on; grid on;

%% -------- Process each trace --------
for k = 1:num_traces

    % Extract columns
    Vce = data(:,2*k-1);
    Ic  = data(:,2*k)/1000;   % convert mA to A

    % Remove NaNs
    idx_valid = ~isnan(Vce) & ~isnan(Ic);
    Vce = Vce(idx_valid);
    Ic  = Ic(idx_valid);

    % -------- Forward-active region selection --------
    idx = Vce > 2;        % adjust if needed
    Vce_FA = Vce(idx);
    Ic_FA  = Ic(idx);

    % -------- BF0 calculation --------
    beta = Ic_FA ./ Ib(k);
    BF0_vals(k) = mean(beta);

    % -------- Early voltage calculation --------
    p = polyfit(Vce_FA, Ic_FA, 1);
    m = p(1);
    b = p(2);
    VA_vals(k) = -b/m;

    % -------- Plot data and fit --------
    plot(Vce, Ic,'o');
    plot(Vce_FA, polyval(p,Vce_FA),'LineWidth',2);

end

xlabel('V_{CE} (V)');
ylabel('I_C (A)');
title('Ic vs Vce with Linear Fits (Forward Active)');
legend('Data','Fit');

%% -------- Average parameters --------
BF0_avg = mean(BF0_vals);
VA_avg  = mean(VA_vals);

fprintf('---------------------------------\n');
fprintf('BF0 values:\n');
disp(BF0_vals);

fprintf('VA values (V):\n');
disp(VA_vals);

fprintf('---------------------------------\n');
fprintf('Average BF0 = %.2f\n', BF0_avg);
fprintf('Average VA  = %.2f V\n', VA_avg);
