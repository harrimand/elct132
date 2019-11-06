F = logspace(1, 4, 200);
C = .22E-6;
L = 56E-3;
R = 470;
omega = 2*pi.*F;
ZC = 1./(j.*omega.*C);
ZL = j.*omega.*L;
Hf = ZC./(R+ZC+ZL);

subplot(2, 1, 1)
loglog(F, abs(Hf), 'linewidth', 2)
set(gca, 'fontsize', 20)
grid on
title('Gain vs. Frequency', 'fontsize', 20)

subplot(2, 1, 2)
semilogx(F, angle(Hf) .* 180/pi, 'linewidth', 2)
set(gca, 'fontsize', 20)
grid on
title('Phase Angle vs. Frequency', 'fontsize', 20)

minD = @(A, d) find(min(abs(A - d)) == abs(A - d));
A = abs(Hf);
HppI = minD(A, 1 ./ sqrt(2)); %Half Power Point Index
F(HppI)
A(HppI)
