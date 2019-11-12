F = logspace(1, 4, 400);
R = 100;
C = 10E-6;
w = 2 * pi * F;
Zc = 1 ./ (j .* w .* C);
A = abs(1 ./ (j .* w .* R .* C + 1));
AdB = 20 * log10(A);
ph = angle(1 ./ (j .* w .* R .* C + 1)).*180/pi;
minD = @(A, d) find(min(abs(A - d)) == abs(A - d));

FcInd = minD(AdB, -3) % Find index for closest point to -3 dB
F(FcInd) % Frequency CutOff
AdB(FcInd) % Closest point to -3 dB
ph(FcInd) % Phase angle at -3 dB

close

subplot(2, 1, 1);
semilogx(F, AdB, 'color', 'b', 'linewidth', 2)
line([F(FcInd),F(FcInd)], [0, AdB(FcInd)], 'color', 'r', 'linewidth', 2);
grid on
set(gca, 'fontsize', 20)
TitledB = sprintf('dB Gain vs Frequency | Cutoff Frequency: %s Gain %s',...
    num2str(F(FcInd)), num2str(AdB(FcInd)))
title(TitledB)

subplot(2, 1, 2);
semilogx(F, ph, 'color', 'r', 'linewidth', 2);
line([F(FcInd),F(FcInd)], [0, ph(FcInd)], 'color', 'b', 'linewidth', 2);
grid on
set(gca, 'fontsize', 20)
Titleph = sprintf('dB Gain vs Frequency | Cutoff Frequency: %s |Phase Angle %s',...
    num2str(F(FcInd)), num2str(ph(FcInd)))
title(Titleph)
