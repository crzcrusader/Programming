clc; clear; close all;

%% USER SETTINGS
Cox = 0.7e-6;   % F/cm^2
W_L = 10;

%% =========================
%% FUNCTION: READ VGS FILE
%% =========================
function [VGS, IDS] = read_vgs(filename)

fid = fopen(filename);
raw = textscan(fid, '%s', 'Delimiter', '\n');
fclose(fid);
raw = raw{1};

start_idx = 0;
for i = 1:length(raw)
    if startsWith(strtrim(raw{i}), '0')
        start_idx = i;
        break;
    end
end

data = [];
for i = start_idx:length(raw)
    row = str2num(raw{i}); %#ok<ST2NM>
    data = [data; row];
end

VGS = data(:,2);
IDS = data(:,3) * 1e-3; % mA → A

end

%% =========================
%% FUNCTION: READ VDS FILE
%% =========================
function [VGS_vals, data] = read_vds(filename)

fid = fopen(filename);
raw = textscan(fid, '%s', 'Delimiter', '\n');
fclose(fid);
raw = raw{1};

% Extract VGS values from header
for i = 1:length(raw)
    if contains(raw{i}, 'Trace:')
        line = raw{i};
        break;
    end
end

tokens = regexp(line, 'Vgs=([-\d\.]+)', 'tokens');
VGS_vals = cellfun(@(x) str2double(x{1}), tokens);

% Find numeric data
start_idx = 0;
for i = 1:length(raw)
    if startsWith(strtrim(raw{i}), '0')
        start_idx = i;
        break;
    end
end

data = [];
for i = start_idx:length(raw)
    row = str2num(raw{i}); %#ok<ST2NM>
    data = [data; row];
end

end

%% =========================
%% NMOS ANALYSIS
%% =========================
[VGS_n, IDS_n] = read_vgs('nmos_vgs.txt');

valid = IDS_n > 1e-6;
VGS_n = VGS_n(valid);
IDS_n = IDS_n(valid);

% VT
p = polyfit(VGS_n, sqrt(IDS_n), 1);
VT_n = -p(2)/p(1);

% K
K_n = 2 * p(1)^2;

% mu
mu_n = K_n / (Cox * W_L);

% theta
Y = IDS_n ./ (VGS_n - VT_n).^2;
valid = isfinite(Y) & Y > 0;
p_theta = polyfit(VGS_n(valid), Y(valid), 1);
theta_n = p_theta(1)/p_theta(2);

%% Lambda (NMOS)
[VGS_vals_n, data_n] = read_vds('nmos_vds.txt');

lambda_vals_n = [];

for k = 1:length(VGS_vals_n)
    col_vds = 2 + (k-1)*2;
    col_ids = 3 + (k-1)*2;

    VDS = data_n(:,col_vds);
    IDS = data_n(:,col_ids)*1e-3;

    valid = VDS > 0.1;
    VDS = VDS(valid);
    IDS = IDS(valid);

    sat = round(0.7*length(VDS)):length(VDS);

    p = polyfit(VDS(sat), IDS(sat), 1);
    lambda_vals_n(end+1) = p(1)/p(2);
end

lambda_n = mean(lambda_vals_n);

%% =========================
%% PMOS ANALYSIS
%% =========================
[VGS_p, IDS_p] = read_vgs('pmos_vgs.txt');

% Take absolute values (PMOS handling)
IDS_p = abs(IDS_p);
VGS_p = abs(VGS_p);

valid = IDS_p > 1e-6;
VGS_p = VGS_p(valid);
IDS_p = IDS_p(valid);

% VT
p = polyfit(VGS_p, sqrt(IDS_p), 1);
VT_p = -p(2)/p(1);

% K
K_p = 2 * p(1)^2;

% mu
mu_p = K_p / (Cox * W_L);

% theta
Y = IDS_p ./ (VGS_p - VT_p).^2;
valid = isfinite(Y) & Y > 0;
p_theta = polyfit(VGS_p(valid), Y(valid), 1);
theta_p = p_theta(1)/p_theta(2);

%% Lambda (PMOS)
[VGS_vals_p, data_p] = read_vds('pmos_vds.txt');

lambda_vals_p = [];

for k = 1:length(VGS_vals_p)
    col_vds = 2 + (k-1)*2;
    col_ids = 3 + (k-1)*2;

    VDS = abs(data_p(:,col_vds));
    IDS = abs(data_p(:,col_ids))*1e-3;

    valid = VDS > 0.1;
    VDS = VDS(valid);
    IDS = IDS(valid);

    sat = round(0.7*length(VDS)):length(VDS);

    p = polyfit(VDS(sat), IDS(sat), 1);
    lambda_vals_p(end+1) = p(1)/p(2);
end

lambda_p = mean(lambda_vals_p);

%% =========================
%% FINAL RESULTS
%% =========================
fprintf('\n===== NMOS =====\n');
fprintf('VT = %.4f V\n', VT_n);
fprintf('mu_0 = %.6e\n', mu_n);
fprintf('theta = %.6f\n', theta_n);
fprintf('lambda = %.6f\n', lambda_n);
fprintf('K = %.6e\n', K_n);

fprintf('\n===== PMOS =====\n');
fprintf('VT = %.4f V\n', VT_p);
fprintf('mu_0 = %.6e\n', mu_p);
fprintf('theta = %.6f\n', theta_p);
fprintf('lambda = %.6f\n', lambda_p);
fprintf('K = %.6e\n', K_p);


%% =========================
%% NMOS RECONSTRUCTION
%% =========================

[VGS_vals, data] = read_vds('nmos_vds.txt');

figure; hold on;

for k = 1:length(VGS_vals)

    VGS = VGS_vals(k);

    VDS = data(:,2*k);
    IDS_meas = data(:,2*k+1) * 1e-3;

    IDS_model = zeros(size(VDS));

    for i = 1:length(VDS)

        if VDS(i) < (VGS - VT_n)
            % Triode
            IDS_model(i) = K_n * ((VGS - VT_n)*VDS(i) - 0.5*VDS(i)^2);
        else
            % Saturation
            IDS_model(i) = 0.5*K_n*(VGS - VT_n)^2 * (1 + lambda_n*VDS(i));
        end

    end

    % Plot measured (markers)
    plot(VDS, IDS_meas, 'o');

    % Plot model (solid)
    plot(VDS, IDS_model, 'LineWidth', 1.5);

    % Mark transition point
    VDS_sat = VGS - VT_n;
    IDS_sat = 0.5*K_n*(VGS - VT_n)^2;

    plot(VDS_sat, IDS_sat, 'ko', 'MarkerSize', 8, 'LineWidth', 2);

end

title('NMOS: Measured vs Modeled');
xlabel('VDS'); ylabel('IDS (A)');
grid on;

%% =========================
%% PMOS RECONSTRUCTION
%% =========================

[VGS_vals, data] = read_vds('pmos_vds.txt');

figure; hold on;

for k = 1:length(VGS_vals)

    VGS = abs(VGS_vals(k));

    VDS = abs(data(:,2*k));
    IDS_meas = abs(data(:,2*k+1)) * 1e-3;

    IDS_model = zeros(size(VDS));

    for i = 1:length(VDS)

        if VDS(i) < (VGS - VT_p)
            % Triode
            IDS_model(i) = K_p * ((VGS - VT_p)*VDS(i) - 0.5*VDS(i)^2);
        else
            % Saturation
            IDS_model(i) = 0.5*K_p*(VGS - VT_p)^2 * (1 + lambda_p*VDS(i));
        end

    end

    plot(VDS, IDS_meas, 's');
    plot(VDS, IDS_model, 'LineWidth', 1.5);

    % Transition point
    VDS_sat = VGS - VT_p;
    IDS_sat = 0.5*K_p*(VGS - VT_p)^2;

    plot(VDS_sat, IDS_sat, 'ko', 'MarkerSize', 8, 'LineWidth', 2);

end

title('PMOS: Measured vs Modeled');
xlabel('VDS'); ylabel('IDS (A)');
grid on;

%% %% =========================
%% MOBILITY DEGRADATION PLOT
%% =========================

% Create VGS ranges
VGS_n_range = linspace(0, max(VGS_n)+1, 100);
VGS_p_range = linspace(0, max(VGS_p)+1, 100);

% Compute mobility vs VGS
mu_eff_n = mu_n ./ (1 + theta_n .* (VGS_n_range - VT_n));
mu_eff_p = mu_p ./ (1 + theta_p .* (VGS_p_range - VT_p));

% Remove invalid regions (below threshold)
valid_n = (VGS_n_range > VT_n);
valid_p = (VGS_p_range > VT_p);

VGS_n_plot = VGS_n_range(valid_n);
mu_eff_n = mu_eff_n(valid_n);

VGS_p_plot = VGS_p_range(valid_p);
mu_eff_p = mu_eff_p(valid_p);

%% Plot
figure; hold on;

plot(VGS_n_plot, mu_eff_n, 'LineWidth', 2);
plot(VGS_p_plot, mu_eff_p, 'LineWidth', 2);

legend('NMOS','PMOS');
title('Mobility Degradation vs VGS');
xlabel('VGS (V)');
ylabel('Effective Mobility');
grid on;
