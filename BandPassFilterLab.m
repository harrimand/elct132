
XLc = @(F, L) 2 .* pi .* F .* L;
XCc = @(F, C) 1 ./ (2 .* pi .* F .* C);

L1 = 56E-3;
C1 = .022E-6;
L2 = 56E-3;
C2 = .022E-6;
R1 = 330;
Vpp = 4;
Vp = Vpp / 2;
Vph = 0;  % Voltage Phase Angle

Vrms = Vp / sqrt(2) * cos(deg2rad(Vph)) + Vp / sqrt(2) * sin(deg2rad(Vph)) * 1i;

F = 1E3 : 100 : 10E3;

L1z = (0 + XLc(F, L1) * 1i);    % L1 Impedance
C1z = (0 - XCc(F, C1) * 1i);     % C1 impedance

L2z = (0 + XLc(F, L2) .* 1i);   % L2 Impedance
C2z = (0 - XCc(F, C2) .* 1i);   % C2 Impedance
R1z = (R1 + zeros(1, length(F)) .* 1i); % R1 Impedance

Zs = L1z + C1z; % Series Impedance
Zp = 1 ./ ( 1 ./ L2z + 1 ./ C2z + 1 ./ R1z);    % Parallel Impedance
Zt = Zs + Zp;   % Total Impedance

Vout = Vrms .* Zp ./ Zt; % Voltage Divider

[ang, mag] = cart2pol(real(Vout), imag(Vout));
figure()
subplot(2, 1, 1)
plot(F, mag)
grid on
set(gca, 'xtick', [1E3:500:10E3])
set(gca, 'xlim', [1E3, 10E3])
set(gca, 'ytick', [-.5:.1:1.5])
set(gca, 'ylim', [-.1, 1.5])
title('RLC Circuit Voltage Output')
subplot(2, 1, 2)
plot(F, ang .* 180 / pi)
hold on
plot([0, F(end)], [0, 0], 'LineWidth', 2)
grid on
set(gca, 'xtick', [1E3:500:10E3])
set(gca, 'xlim', [1E3, 10E3])
set(gca, 'ytick', [-140:10:140])
set(gca, 'ylim', [-140, 140])
title('RLC Circuit Phase Angle')