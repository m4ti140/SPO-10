%% charakterystyka promieniowania

figure;
patternCustom(H_B.', az, el,'CoordinateSystem','polar','Slice','phi','SliceValue',0);
hold on;
patternCustom(H_B.', az, el,'CoordinateSystem','polar','Slice','theta','SliceValue',0);
patternCustom(V_B.', az, el,'CoordinateSystem','polar','Slice','phi','SliceValue',0);
patternCustom(V_B.', az, el,'CoordinateSystem','polar','Slice','theta','SliceValue',0);
legend("Pol. pozioma, pl. E", "Pol. pozioma, pl. H", "Pol. pionowa, pl. H", "Pol. pionowa, pl. E");
%saveas(gcf, "radpattern",'png');

%% zrodlo promieniowania

for i=1:61
    buff_t((i-1)*100+1)=propagaded_wave.time(i);
    buff_s((i-1)*100+1)=real(propagaded_wave.signals.values(1,1,i));
    for j=2:100
        buff_t((i-1)*100+j)=buff_t((i-1)*100+1)+(propagaded_wave.time(i+1)-propagaded_wave.time(i))/100*(j-1);
        buff_s((i-1)*100+j)=real(propagaded_wave.signals.values(j,1,i));
    end
end

figure
plot(buff_t,buff_s);
grid
title("Sygnal docierajacy do anteny, cz??? rzeczywista");
xlabel("czas, [s]");

%% antena

for i=1:61
    buff_t((i-1)*100+1)=antenna_out.time(i);
    buff_s((i-1)*100+1)=real(antenna_out.signals.values(1,1,i));
    for j=2:100
        buff_t((i-1)*100+j)=buff_t((i-1)*100+1)+(antenna_out.time(i+1)-antenna_out.time(i))/100*(j-1);
        buff_s((i-1)*100+j)=real(antenna_out.signals.values(j,1,i));
    end
end

figure
plot(buff_t,buff_s);
grid
title("Sygnal odebrany przez anten?, cz??? rzeczywista");
xlabel("czas, [s]");

%% detektor

for i=1:61
    buff_t((i-1)*100+1)=detector_out.time(i);
    buff_s((i-1)*100+1)=real(detector_out.signals.values(1,1,i));
    for j=2:100
        buff_t((i-1)*100+j)=buff_t((i-1)*100+1)+(detector_out.time(i+1)-detector_out.time(i))/100*(j-1);
        buff_s((i-1)*100+j)=real(detector_out.signals.values(j,1,i));
    end
end

figure
plot(buff_t,buff_s);
grid
title("Sygnal z detektora");
ylim([-0.5 1.5]);
xlabel("Czas, [s]");
ylabel("wartosc binarna");

%% selektor impulsów

figure
plot(TD_in*0.1);
hold

plot(TD_out*0.2);
plot(IS_stage_1*0.3);
plot(IS_stage_2*0.4);
plot(IS_stage_3*0.5);
plot(IS_stage_4*0.6);
xlim([0 0.0015]);
ylim([-0.2 1]);
set(gca,'YTickLabel',[]);
xlabel("Czas, [s]");
ylabel("Kolejno?? powstania");
legend("wyj?cie z detektora","wyjscie ustandaryzowane z UP","pierwszy multiwibrator", "drugi multiwibrator", "koniunkcja z sygna?em z UP","wyj?cie na wska?nik",'Location','northwest');
title("Przetwarzanie sygnalu detektora na wskazania wyswietlacza");

%% wyjscie

figure
plot(s3m5_out)
ylim([-0.2 1.2]);
set(gca,'YTickLabel',[]);
ylabel("Stan");
xlabel("Czas [s]");
title("Wyjscie na wyswietlacz");

%% wyjscie uproszczone

figure
plot(simp_FR);
hold
plot(simp_FL,'--');
legend("Prawy przedni kana?", "Lewy Przedni Kana?")
title("Wyj?cie modelu uproszczonego dla po?rednich azymutów");
ylabel("Stan");
xlabel("Czas [t]");